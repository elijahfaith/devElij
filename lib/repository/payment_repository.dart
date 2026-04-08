import 'dart:io';

import 'package:link_go/models/util_model.dart';
import 'package:link_go/repository/network_helper.dart';
import 'package:link_go/utils/enums.dart';

class PaymentRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> getDeposit() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'wallet/deposits',
    );
  }

  Future<HTTPResponseModel> getWalletBalance() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'wallet/balance',
    );
  }

  Future<HTTPResponseModel> getWalletHistory() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'wallet/transactions',
    );
  }

  Future<HTTPResponseModel> initializeDeposit(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "wallet/deposit/initialize",
      body: body,
    );
  }

  Future<HTTPResponseModel> verifyDeposit(
      Map<String, dynamic> body, String reference) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "wallet/deposit/verify/$reference",
    );
  }

  Future<HTTPResponseModel> verifyPayment(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "main-svc-v2/payment/verify",
      body: body,
    );
  }

  Future<HTTPResponseModel> initiatePayment(num cartId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "main-svc-v2/payment/initiate/unified/blusalt",
      body: {"cart_id": cartId},
    );
  }

  Future<HTTPResponseModel> initiateWithdrwal(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "wallet/withdraw",
      body: body,
    );
  }
}
