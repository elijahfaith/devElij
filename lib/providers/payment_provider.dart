import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:link_go/models/CartModel.dart';
import 'package:link_go/models/CategoriesModel.dart';
import 'package:link_go/models/MarketListModel.dart';
import 'package:link_go/models/Products.dart';
import 'package:link_go/models/WishListModel.dart';
import 'package:link_go/models/brandListModel.dart';
import 'package:link_go/models/featured_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_go/models/util_model.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/repository/payment_repository.dart';
import 'package:link_go/repository/product_repository.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/utils/base_model.dart';
import 'package:link_go/utils/enums.dart';
import 'package:link_go/utils/helpers.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/productModel.dart';
import '../models/wallet_model.dart';

class PaymentProvider extends BaseModel {
  final Ref reader;

  PaymentProvider.init({
    required this.reader,
  });

  final _paymentRepository = PaymentRepository();

  String reference = '';
  String? sk;

  num? _cartId;

  num? get cartId => _cartId;

  changeCartId(num? value) {
    _cartId = value;
    notifyListeners();
  }

  bool isTransactionLoading = false;

  void setFilterLoading(bool value) {
    isTransactionLoading = value;
    notifyListeners();
  }

// Private backing field
  List<WalletTransaction>? _walletTransactions = [];

  List<WalletTransaction>? get walletTransactions => _walletTransactions;

  set walletTransactions(List<WalletTransaction>? value) {
    _walletTransactions = value;
    notifyListeners();
  }

  TextEditingController amountToDeposit = TextEditingController();

  NavigatorService _navigation = NavigatorService();
  initiateDeposit({String? description}) async {
    setBusy(true);
    HTTPResponseModel res = await _paymentRepository.initializeDeposit({
      "amount": double.tryParse(amountToDeposit.text) ?? 0.0,
      "currency": "NGN",
      "description": "Deposit money", // optional
      "meta_data": ""
    });
    if (HTTPResponseModel.isApiCallSuccess(res)) {}
    setBusy(false);
    reference = res.data['reference'];
    // verifyDeposit();
    notifyListeners();
    sk = res.data['key'];
    if (reference != null && sk != null) {
      notifyListeners();
      PayWithPayStack().now(
        context: NavigatorService.navigationKey_.currentContext!,
        secretKey: sk ?? "",
        customerEmail:
            reader.read(RiverpodProvider.accountProvider).currentUser.email ??
                '',
        reference: reference ?? "",
        currency: "NGN",
        amount: double.tryParse(amountToDeposit.text) ?? 0.0,
        callbackUrl: "https://google.com",
        transactionCompleted: (paymentData) {
          print(paymentData);
          print(paymentData.reference);
          verifyDeposit();
        },
        transactionNotCompleted: (reason) {
          _navigation.pushAndRemoveUntil(bottomNavigationRoute);
          debugPrint("==> Transaction failed reason $reason");
        },
      );
      return true;
    } else {
      return [];
    }
  }

  verifyDeposit() async {
    setBusy(true);
    HTTPResponseModel res = await _paymentRepository
        .verifyDeposit({"reference": reference}, reference);
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(message: res.all['message']);
      amountToDeposit.clear();
      getWalletBalance();
      notifyListeners();
      return true;
    } else {
      showErrorToast(message: res.message);
      // _navigation.pushAndRemoveUntil(bottomNavigationRoute);
    }
  }

  getDeposit() async {
    setBusy(true);
    HTTPResponseModel res = await _paymentRepository.getDeposit();
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(message: res.all['message']);
      return true;
    } else {
      showErrorToast(message: res.message);
      // _navigation.pushAndRemoveUntil(bottomNavigationRoute);
    }
  }

  // getWalletHistory() async {
  //   setBusy(true);
  //   HTTPResponseModel res = await _paymentRepository.getWalletHistory();
  //   setBusy(false);
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     showToast(message: res.all['message']);
  //     return true;
  //   } else {
  //     showErrorToast(message: res.message);
  //     // _navigation.pushAndRemoveUntil(bottomNavigationRoute);
  //   }
  // }

  Future<void> getWalletHistory() async {
    setFilterLoading(true);
    HTTPResponseModel res = await _paymentRepository.getWalletHistory();
    setFilterLoading(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      final data = WalletTransactionData.fromJson(res.all['data']);
      walletTransactions = data.transactions ?? [];
    } else {
      showErrorToast(message: res.message);
    }
  }

  int? walletBalance;
  getWalletBalance() async {
    HTTPResponseModel res = await _paymentRepository.getWalletBalance();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      walletBalance = res.data["balance"];
      notifyListeners();
      return true;
    } else {
      showErrorToast(message: res.message);
    }
  }

  TextEditingController amountToWithdraw = TextEditingController();
  TextEditingController transactionPin = TextEditingController();
  initiateWithdrawal(pin) async {
    setBusy(true);
    HTTPResponseModel res = await _paymentRepository.initiateWithdrwal({
      "amount": double.tryParse(amountToWithdraw.text) ?? 0.0,
      "bankCode": reader
          .read(RiverpodProvider.accountProvider)
          .currentUser
          .shop
          ?.paymentDetails
          ?.bankCode,
      "bankName": reader
              .read(RiverpodProvider.accountProvider)
              .currentUser
              .shop
              ?.paymentDetails
              ?.bankName ??
          "",
      "accountNumber": reader
              .read(RiverpodProvider.accountProvider)
              .currentUser
              .shop
              ?.paymentDetails
              ?.accountNumber ??
          "",
      "accountName": reader
              .read(RiverpodProvider.accountProvider)
              .currentUser
              .shop
              ?.paymentDetails
              ?.accountName ??
          "",
      "description": "Withdrawal from wallet", // optional
      "transactionPin": pin,
      "metadata": {}
    });
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      amountToWithdraw.clear();
      transactionPin.clear();
      showToast(message: res.message);

      getWalletBalance();
      getWalletHistory();
      notifyListeners();
      return true;
    } else {
      showErrorToast(message: res.message);
      return [];
    }
  }

  initiatePayment() async {
    setBusy(true);
    HTTPResponseModel res =
        await _paymentRepository.initiatePayment(_cartId ?? 0);
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      reference = res.data[0]['reference'];
      notifyListeners();
      showHalfScreenWebViewDialog(
        url: res.data[0]['authorization_url'],
        onDialogClosed: () {
          verifyPayment(_cartId ?? 0);
        },
      );
      return true;
    } else {
      return [];
    }
  }

  void showHalfScreenWebViewDialog({
    required String url,
    required VoidCallback onDialogClosed,
  }) {
    showModalBottomSheet(
      context: NavigatorService.navigationKey_.currentContext!,
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.8,
        child: WebViewSheet(url: url, onDialogClosed: onDialogClosed),
      ),
    );
  }

  verifyPayment(num cartId) async {
    setBusy(true);
    HTTPResponseModel res = await _paymentRepository.verifyPayment(
        {"cart_id": cartId, "type": "blusalt", "reference": reference});
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      reader
          .watch(RiverpodProvider.navStateProvider)
          .setCurrentTabTo(newTabIndex: 0);
      _navigation.pushAndRemoveUntil(bottomNavigationRoute);
      return true;
    } else {
      _navigation.pushAndRemoveUntil(bottomNavigationRoute);
    }
  }
}

class WebViewSheet extends StatefulWidget {
  final String url;
  final VoidCallback onDialogClosed;

  const WebViewSheet({
    Key? key,
    required this.url,
    required this.onDialogClosed,
  }) : super(key: key);

  @override
  State<WebViewSheet> createState() => _WebViewSheetState();
}

class _WebViewSheetState extends State<WebViewSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    widget.onDialogClosed(); // Trigger callback on close
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Scaffold(
          appBar: AppBar(
              title: Text('Payment'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      widget.onDialogClosed();
                    })
              ]),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ));
  }
}
