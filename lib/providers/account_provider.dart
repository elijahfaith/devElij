import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:link_go/app/bottom_nav/nav_service.dart';
import 'package:link_go/models/BannerModel.dart';
import 'package:link_go/models/auth_model.dart';
import 'package:link_go/models/SignInResponse.dart';
import 'package:link_go/models/util_model.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/repository/auth_repository.dart';
import 'package:link_go/services/dialog_service.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/utils/base_model.dart';
import 'package:link_go/utils/enums.dart';
import 'package:link_go/utils/helpers.dart';
import 'package:link_go/utils/locator.dart';
import 'package:link_go/utils/storage_util.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';
import '../models/CustomerAddressModel.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import '../models/checkout_model.dart';
import '../models/state_model.dart';
import '../models/storage/bank_model.dart';


class AccountProvider extends BaseModel {
  final Ref ref;
  AccountProvider.init({
    required this.ref,
  });
  final NavigatorService _navigation = locator<NavigatorService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  late NavStateProvider navStateProvider;
  final DialogService dialogService = locator<DialogService>();
  ScrollController? controller;
  LoadingState _loadingState = LoadingState.idle;
  LoadingState get loadingState => _loadingState;
  LoadingState _fetchState = LoadingState.loading;
  LoadingState get fetchState => _fetchState;
  List<BannerModel>? _bannerList;
  List<BannerModel>? get bannerList => _bannerList;

  int? selectedAddressIndex;
  int? selectedPickUpIndex;
  CustomerAddress? _currentLocationAddress;
  CustomerAddress? get currentLocationAddress => _currentLocationAddress;

  CustomerAddress getSelectedAddress(List<CustomerAddress> addressList) {
    if (selectedAddressIndex == null && _currentLocationAddress != null) {
      return _currentLocationAddress!;
    }
    if (selectedAddressIndex != null &&
        selectedAddressIndex! < addressList.length) {
      return addressList[selectedAddressIndex!];
    }
    if (addressList.isNotEmpty) {
      return addressList.first;
    }
    return CustomerAddress(
      addressId: 0,
      addressTitle: '',
      address: '',
      city: '',
      state: '',
      landmark: '',
      defaultAddress: false,
    );
  }

// functions for profile pages
  void onTapDetailPage() {
    _navigation.navigateTo(PersonalDetail);
  }

  void onTapDeliveryAddress() {
    _navigation.navigateTo(deliveryAddressScreenRoute);
  }

  void onTapMyOrder() {
    _navigation.navigateTo(MyOrdersScreenRoute);
  }

  void onTapWallet() {
    _navigation.navigateTo(WalletPageScreenRoute);
  }

  void onTapWishlist() {
    _navigation.navigateTo(WishlistScreenRoute);
  }

  void addNewAddress() {
    _navigation.navigateTo(addNewAddressScreenRoute);
  }

  void onTapSettings() {
    _navigation.navigateTo(settingsScreenRoute);
  }

  void changePassword() {
    _navigation.navigateTo(changePasswordScreenRoute);
  }

  void changeTransactionPIN() {
    _navigation.navigateTo(changeTransactionPINScreenRoute);
  }

  void notificationSetting() {
    _navigation.navigateTo(notificationSettingScreenRoute);
  }

  void closeAccount() {
    _navigation.navigateTo(deleteAccountScreenRoute);
  }

  void helpPage() {
    _navigation.navigateTo(helpScreenRoute);
  }

  void legalTerms() {
    _navigation.navigateTo(legalTermsScreenRoute);
  }

  void privacyPolicy() {
    _navigation.navigateTo(privacyPolicyScreenRoute);
  }

  void termsOfUse() {
    _navigation.navigateTo(termsOfUseScreenRoute);
  }

  void sellersPage() {
    _navigation.navigateTo(sellersPageScreenRoute);
  }

  void faqPage() {
    _navigation.navigateTo(FaqScreenRoute);
  }

  void negotiationPage() {
    _navigation.navigateTo(negotiationScreenRoute);
  }

  //
  late SignInResponse _currentUser;
  SignInResponse get currentUser => _currentUser;

  late AuthModel _token;
  AuthModel get token => _token;
  setFetchState(LoadingState value) {
    _fetchState = value;
    notifyListeners();
  }

  setLoadingState(LoadingState value) {
    _loadingState = value;
    notifyListeners();
  }

  final GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController signInPhoneOrEmailController =
      TextEditingController(); //""test@gmail.com"
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpPinController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController settingPasswordController = TextEditingController();

  startRegistration() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.signup({
        "email": signUpEmailController.text.trim(),
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        notifyListeners();

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  completeAccountRegistration(token) async {
    setBusy(true);
    try {
      final platform = kIsWeb
          ? 'web'
          : Platform.isAndroid
              ? 'android'
              : Platform.isIOS
                  ? 'ios'
                  : 'unknown'; // Fallback if needed
      HTTPResponseModel result = await _authRepository.createAccount({
        "firstname": firstNameController.text.trim(),
        "lastname": lastNameController.text.trim(),
        "email": signUpEmailController.text.trim(),
        "password": signUpPasswordController.text.trim(),
        "username": signUpNameController.text,
        "phoneNumber": signUpPhoneController.text.startsWith('0')
            ? '+234${signUpPhoneController.text.substring(1)}'
            : '+234${signUpPhoneController.text}',
        // "phoneNumber": '+234${signUpPhoneController.text}',
        "fcmToken": token,
        "platform": platform, // kIsWeb ? 'web' : 'mobile',
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;
        await StorageUtil.setData('token', auth.token);
        showToast(message: result.all['message']);
        print(result.all);
        _navigation.navigateReplacementTo(bottomNavigationRoute);
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  verifyOtpCode(String pin) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.verifyForgot({
        "otpCode": pin,
        "email": signUpEmailController.text.trim(),
        "type": 'signup',
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  verifyForgotPassOtpCode(String pin) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.verifyForgot({
        "otpCode": pin,
        "email": forgotPasswordEmailController.text,
        "type": 'reset'
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController forgotPasswordEmailController =
      TextEditingController(); //""
  forgetPassword() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.sendForgotOtp({
        "email": forgotPasswordEmailController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController userChangePassCurrent = TextEditingController();
  TextEditingController userChangePassNew = TextEditingController();
  TextEditingController userChangePassConfNew = TextEditingController();
  TextEditingController userChangePassOTP = TextEditingController();
  requestChangeAccountPassword() async {
    setBusy(true);
    try {
      HTTPResponseModel result =
          await _authRepository.requestChangeAccountPassword({
        "currentPassword": userChangePassCurrent.text,
        "newPassword": userChangePassNew.text,
        "confirmPassword": userChangePassConfNew.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  changeAccountPassword() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.changeAccountPassword({
        "newPassword": userChangePassNew.text,
        "otpCode": userChangePassOTP.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController updateUserFirstNameController = TextEditingController();
  TextEditingController updateUserLastNameController = TextEditingController();
  TextEditingController updateUserCityController = TextEditingController();
  TextEditingController updateUserBioController = TextEditingController();
  TextEditingController updateUserAddressController = TextEditingController();
  updateUser() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.upDateUser({
        "firstname": updateUserFirstNameController.text,
        "lastname": updateUserLastNameController.text,
        "bio": updateUserBioController.text,
        "state": selectedBasicState?.name ?? "",
        "city": updateUserCityController.text,
        "address": updateUserAddressController.text,
        "longitude": _userProLng,
        "latitude" : _userProLat,

      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        getUserProfile();
        showToast(message: 'Profile updated successfully');
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  deleteUserAccount() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.deleteUser({});
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        StorageUtil.clearData();
        showToast(message: result.all['message']);
        _navigation.navigateReplacementTo(loginScreenRoute);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  logOutUserAccount() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.logoutUser({});
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        StorageUtil.clearData();
        showToast(message: result.all['message']);
        _navigation.navigateReplacementTo(loginScreenRoute);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController transacPin = TextEditingController();
  TextEditingController transacOTP = TextEditingController();
  createTransactionPin(String? pin) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.setTransactionPin({
        "pin": pin,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        getUserProfile();
        showToast(message: result.all['message']);

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  resendTransOTP() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.resendOTp({
        "email": currentUser.email,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  verifyCreateTranPin(String? otp) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.verifyTransactionOTP({
        "pin": transacPin.text,
        "otpCode": otp,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        getUserProfile();
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController newPinController = TextEditingController();
  verifyChangeTranPin(String? otp) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.verifyTransactionOTP({
        "pin": newPinController.text,
        "otpCode": otp,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        getUserProfile();
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController changeTransaPinOTP = TextEditingController();
  changeTransactionPin(oldPin, newPin) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.changeTransactionPin({
        "oldPin": oldPin,
        "newPin": newPin,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        getUserProfile();
        showToast(message: result.all['message']);

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController resendOTP = TextEditingController(); //""
  resentOTP() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.resendOTp({
        "email": signUpEmailController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController resendForgotOTP = TextEditingController(); //""
  resentForgotPassOTP() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.resendOTp({
        "email": forgotPasswordEmailController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController forgotPasswordPinController = TextEditingController();
  resetPassword(
    String password,
  ) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.resetPassword({
        "email": forgotPasswordEmailController.text,
        "otpCode": forgotPasswordPinController.text,
        "newPassword": password,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        _navigation.navigateReplacementTo(loginScreenRoute);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      print(e);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  updateUserprofileImage(
    String? dp,
    String? imageUrl,
  ) async {
    setBusy(true);
    try {
      if (dp == null) {
        throw Exception("No image path provided");
      }

      final ext = dp.split('.').last.toLowerCase();
      final mimeType =
          ext == 'png' ? MediaType('image', 'png') : MediaType('image', 'jpeg');

      HTTPResponseModel result = await _authRepository.updateUserProfileImage({
        "image": await MultipartFile.fromFile(
          dp,
          filename: imageUrl ?? dp.split('/').last,
          contentType: mimeType,
        )
      });

      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        getUserProfile();
        showToast(message: result.all['message']);
        ref.read(RiverpodProvider.productProvider).getProducts();
        ref.read(RiverpodProvider.productProvider).getUserListings();
        NavigatorService()
            .pop(NavigatorService().navigationKey!.currentContext!);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  List<StateModel> _state = [];
  List<StateModel> get state => _state;
  StateModel? selectedBasicState;
  StateModel? selectedSellerState;
  setAllState(List<StateModel> state) {
    _state = state;
    // selectedLGA = null;
    notifyListeners();
  }

  getState() async {
    try {
      HTTPResponseModel result = await _authRepository.getStates();
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        List<StateModel> questionList = List<StateModel>.from(
            result.data['data'].map((item) => StateModel.fromJson(item)));
        setAllState(questionList);
        notifyListeners();
        return true;
      } else {
        //showErrorToast(result.all['Message']);
        return false;
      }
    } catch (e) {
      //showErrorToast(e.toString());
      return false;
    }
  }

  validateBank(String? bankCode, String? accountNumber) async {
    setBusy(true);
    sellerBankAccountName.text = "";
    try {
      HTTPResponseModel result =
          await _authRepository.validateBank(bankCode, accountNumber);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        sellerBankAccountName.text = result.data['data']['account_name'];
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      //showErrorToast(e.toString());
      return false;
    }
  }

  String? verifyUsername;
  checkUsername(String username) async {
    //  setBusy(true);
    HTTPResponseModel res = await _authRepository.checkUserName(username);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      final resultData = res.all;
      verifyUsername = resultData['message'];
      print(res.data);
      notifyListeners();
    } else {
      //setBusy(false);
    }
  }

  TextEditingController sellerFullNameController = TextEditingController();
  TextEditingController sellerUsername = TextEditingController();
  TextEditingController sellerBvn = TextEditingController();
  TextEditingController sellerPhoneNumber = TextEditingController();
  TextEditingController sellerBcName = TextEditingController();
  TextEditingController sellerBio = TextEditingController();
  TextEditingController sellerCity = TextEditingController();
  TextEditingController sellerState = TextEditingController();
  TextEditingController sellerBankName = TextEditingController();
  TextEditingController sellerBankAccountNumber = TextEditingController();
  TextEditingController sellerBankAccountName = TextEditingController();
  List<String> selectedDeliveryOptions = [];
  bool isChecked = true;
  bool isChecked1 = true;

  String? dp;
  String? dpName;

  takePicture() async {
    final imagePicker = ImagePicker();
    File file = File(await imagePicker
        .pickImage(
          source: ImageSource.gallery,
        )
        .then((pickedFile) => pickedFile!.path));

    dp = file.path;
    dpName = file.path.split('/').last;
    notifyListeners();
  }

  createSellerAccount() async {
    setBusy(true);
    try {
      final ext = dpName?.split('.').last.toLowerCase();
      final mimeType =
          ext == 'png' ? MediaType('image', 'png') : MediaType('image', 'jpeg');
      selectedDeliveryOptions.clear();
      if (isChecked) selectedDeliveryOptions.add("In-person Meetup");
      if (isChecked1) selectedDeliveryOptions.add("Shipping");
      HTTPResponseModel result = await _authRepository.createSellerAccount({
        if (dp != null && dpName != null)
          "coverImage": await MultipartFile.fromFile(
            dp!,
            filename: dpName,
            contentType: mimeType,
          ),
        "fullname": sellerFullNameController.text,
        "username": sellerUsername.text,
        "businessName": sellerBcName.text,
        "businessPhone": sellerPhoneNumber.text,
        "bvn": sellerBvn.text,
        "businessAddress": businessAddressController.text,
        "bio": sellerBio.text,
        "city": sellerCity.text,
        "state": selectedSellerState?.name,
        "location": jsonEncode({
          "type": "Point",
          "coordinates": [_shippingLat, _shippingLng],
        }),
        "bankName": selectedBank?.name, //sellerBankName.text,
        "accountName": sellerBankAccountName.text,
        "accountNumber": sellerBankAccountNumber.text,
        "delivery_options": selectedDeliveryOptions,
        "bankCode" : selectedBank?.code
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        print(result.all);
        getUserProfile();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  List<BankModel> _banks = [];
  List<BankModel> get banks => _banks;
  BankModel? selectedBank;
  Future<void> getAllBanks() async {
    HTTPResponseModel res = await _authRepository.getAllBanks();

    // ✅ Custom check for this specific API, since it uses "status" instead of "success"
    if (res.all['status'] == true) {
      final List<dynamic> rawBankList =
          res.data; // Safe because data = parsedJson['data']
      final List<BankModel> _bankList =
          rawBankList.map((item) => BankModel.fromJson(item)).toList();

      print("Banks loaded: ${_bankList.length}");
      _banks = _bankList;
      //  setAllState(bankList);
    } else {
      print("Failed to load banks. Message: ${res.message}");
      //setAllState([]);
    }
  }

  // updateSellerAccount() async {
  //   setBusy(true);
  //   try {
  //     final ext = dpName!.split('.').last.toLowerCase();
  //     final mimeType = ext == 'png' ? MediaType('image', 'png') : MediaType('image', 'jpeg');
  //     selectedDeliveryOptions.clear();
  //     if (isChecked) selectedDeliveryOptions.add("In-person Meetup");
  //     if (isChecked1) selectedDeliveryOptions.add("Shipping");
  //     HTTPResponseModel result = await _authRepository.updateSellerAcc({
  //       if (dp != null && dpName != null)
  //         "coverImage": await MultipartFile.fromFile(
  //           dp!,
  //           filename: dpName,
  //           contentType: mimeType,
  //         ),
  //       "fullname": sellerFullNameController.text,
  //       "username": sellerUsername.text,
  //       "businessName": sellerBvn.text,
  //       "businessPhone": sellerPhoneNumber.text,
  //       "bvn": sellerBvn.text,
  //       "businessAddress": businessAddressController.text,
  //       "bio": sellerBio.text,
  //       "city": sellerCity.text,
  //       "state": selectedSellerState?.name,
  //       "location": jsonEncode({
  //         "type": "Point",
  //         "coordinates": [shippingLng, shippingLat],
  //       }),
  //       "bankName": selectedBank?.name,
  //       "accountName": sellerBankAccountName.text,
  //       "accountNumber": sellerBankAccountNumber.text,
  //       "delivery_options": selectedDeliveryOptions,
  //     });
  //     if (HTTPResponseModel.isApiCallSuccess(result)) {
  //       setBusy(false);
  //       showToast(message: result.all['message']);
  //       ref.watch(RiverpodProvider.productProvider).getProducts();
  //       getUserProfile();
  //       ref.watch(RiverpodProvider.productProvider).getUserListings();
  //       notifyListeners();
  //       return true;
  //     } else {
  //       setBusy(false);
  //       showErrorToast(message: result.all['message']);
  //       return false;
  //     }
  //   } catch (e) {
  //     setBusy(false);
  //     showErrorToast(message: e.toString());
  //     return false;
  //   }
  // }
  updateSellerAccount() async {
    setBusy(true);
    try {
      MultipartFile? imageFile;
      if (dp != null && dpName != null) {
        final ext = dpName?.split('.').last.toLowerCase();
        final mimeType = ext == 'png'
            ? MediaType('image', 'png')
            : MediaType('image', 'jpeg');

        imageFile = await MultipartFile.fromFile(
          dp!,
          filename: dpName,
          contentType: mimeType,
        );
      }
      selectedDeliveryOptions.clear();
      if (isChecked) selectedDeliveryOptions.add("In-person Meetup");
      if (isChecked1) selectedDeliveryOptions.add("Shipping");
      final requestBody = {
        if (imageFile != null) "coverImage": imageFile,
        "fullname": sellerFullNameController.text.trim(),
        "username": sellerUsername.text.trim(),
        "businessName": sellerBcName.text.trim(),
        "businessPhone": sellerPhoneNumber.text.trim(),
        "bvn": sellerBvn.text.trim(),
        "businessAddress": businessAddressController.text.trim(),
        "bio": sellerBio.text.trim(),
        "city": sellerCity.text.trim(),
        "state": selectedSellerState?.name,
        "location": jsonEncode({
          "type": "Point",
          "coordinates": [_shippingLat, _shippingLng,],
        }),
        "bankName": selectedBank?.name,
        "accountName": sellerBankAccountName.text.trim(),
        "accountNumber": sellerBankAccountNumber.text.trim(),
        "delivery_options": selectedDeliveryOptions,
        "bankCode" : selectedBank?.code
      };
      HTTPResponseModel result =
          await _authRepository.updateSellerAcc(requestBody);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        ref.read(RiverpodProvider.productProvider).getProducts();
        getUserProfile();
        ref.read(RiverpodProvider.productProvider).getUserListings();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  //
  // void clearForm() {
  //   productNameController.clear();
  //   productDescriptionController.clear();
  //   productPriceController.clear();
  //   productAmountInStockController.clear();
  //
  //   selectedGender = null;
  //   selectedCategory = null;
  //   selectedSubCategory = null;
  //   selectedColor = null;
  //   selectedImages.clear();
  //   isEditMode = false;
  //
  //   notifyListeners();
  // }

  // Future<bool> getDefaultLocation() async {
  //   try {
  //     setBusy(true);
  //     if (_userPosition == null) {
  //       await getUserLocation();
  //     }
  //     if (_userPosition == null) {
  //       return false;
  //     }
  //     final lat = _userPosition!.latitude;
  //     final lng = _userPosition!.longitude;
  //     HTTPResponseModel result =
  //         await _authRepository.getDefaultLocation(lat, lng);
  //     if (HTTPResponseModel.isApiCallSuccess(result)) {
  //       setBusy(false);
  //       final data = result.data;
  //       final address = data['address'];
  //       _currentLocationAddress = CustomerAddress(
  //         addressTitle: 'Current Location',
  //         address: address['village'] ?? '',
  //         city: address['city'] ?? '',
  //         state: address['state'] ?? '',
  //         landmark: '',
  //         defaultAddress: false,
  //       );
  //
  //       notifyListeners();
  //       return true;
  //     } else {
  //       setBusy(false);
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching default location: $e');
  //     setBusy(false);
  //     return false;
  //   }
  // }

  logIn(String? fcmToken) async {

    // jamsy102@yopmail.com
    // Password@1
    setBusy(true);
    try {
      final platform = kIsWeb
          ? 'web'
          : Platform.isAndroid
          ? 'android'
          : Platform.isIOS
          ? 'ios'
          : 'unknown';
      HTTPResponseModel result = await _authRepository.login({
        "email": signInPhoneOrEmailController.text,
        "password": signInPasswordController.text,
        "fcmToken" : fcmToken,
        "platform": platform,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        print(result.data);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;

        await StorageUtil.setData('token', auth.token);
        await StorageUtil.setData('profile', json.encode(user));
        showToast(message: result.all['message']);
        _navigation.pushNamedAndRemoveUntil(
          bottomNavigationRoute,
        );
        // navStateProvider.setCurrentTabTo(newTabIndex: 0);

        return true;
      } else {
        setBusy(false);
        print(result);
        showErrorToast(message: result.message);
        print(result.message);
        return false;
      }
    } catch (e) {
      setBusy(false);
      print(e.toString());
      showErrorToast(message: e.toString());
      return false;
    }
  }

  String guestId = Uuid().v6().toString();
  loginAsAGuest() {
    SignInResponse user = SignInResponse();
    _currentUser = user;
    notifyListeners();
    _navigation.pushNamedAndRemoveUntil(
      homeScreenRoute,
    );
  }

// google signUp

  performServiceAuth(String idToken) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.loginProviders(idToken);
      // print(userData.identityToken);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;
        await StorageUtil.setData('token', auth.token);
        await StorageUtil.setData('profile', json.encode(user));
        _navigation.pushNamedAndRemoveUntil(
          bottomNavigationRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        // if (result.code == 202) {
        //   debugPrint('User to sign up');
        //   showToast(
        //       message: 'Welcome ${userData.name}, kindly complete your profile');
        // }
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  performAppleLogin(String idToken) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.loginApple(idToken);
      // print(userData.identityToken);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;
        await StorageUtil.setData('token', auth.token);
        await StorageUtil.setData('profile', json.encode(user));
        _navigation.pushNamedAndRemoveUntil(
          bottomNavigationRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        // if (result.code == 202) {
        //   debugPrint('User to sign up');
        //   showToast(
        //       message: 'Welcome ${userData.name}, kindly complete your profile');
        // }
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  bool isSellerEditMode = false;
  Future<void> getUserProfile() async {
    // if (_currentUser != null) return; // prevent repeat API calls
    try {
      HTTPResponseModel result = await _authRepository.getUserProfile();
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        SignInResponse user = SignInResponse.fromJson(result.data);
        _currentUser = user;
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  signInWithGoogle() async {
    GoogleSignInAuthentication? googleSignInAuthentication;
    GoogleSignInAccount? account;

    try {
      final GoogleSignIn googleSignIn;
      if (Platform.isIOS) {
        googleSignIn = await GoogleSignIn(
          clientId:
              "483222300106-3a7p1q7qfslscjvkul4ccfa5m90jcb2i.apps.googleusercontent.com",
        );
      } else {
        googleSignIn = await GoogleSignIn(
          serverClientId:
              "483222300106-9mbtmfplmnjevjnk6pe4eoo64c14jjce.apps.googleusercontent.com",
        );
      }
      // GoogleSignIn();

      try {
        account = await googleSignIn.signIn();
        print(account?.email);
        googleSignInAuthentication = await account?.authentication;
      } catch (e) {
        debugPrint('Error retrieving Google SignInAuthentication: $e');
        return null;
      }

      if (googleSignInAuthentication == null) {
        showErrorToast(message: 'Sign-in canceled by user.');
        return null;
      }

      try {
        if (googleSignInAuthentication.accessToken == null ||
            googleSignInAuthentication.idToken == null) {
          showErrorToast(
              message: 'Google authentication failed. Please try again.');
          return null;
        } else {
          // final User userCredential = auth.currentUser!;
          // user = userCredential;
          //
          // debugPrint('User: ${user.displayName}');
          // debugPrint('Email: ${user.email}');
          // debugPrint('UID: ${user.uid}');
        }
      } catch (e) {
        // Handle general errors
        debugPrint('Exception during Google Sign-In: $e');
        showErrorToast(
            message: 'Error occurred using Google Sign In. Please try again.');
      }

      return googleSignInAuthentication.accessToken;
    } catch (e) {
      // Handle errors during Google Sign-In initialization
      debugPrint('Error during Google Sign-In: $e');
      showErrorToast(
          message: 'Error occurred during sign-in process. Try again.');

      return null;
    }
  }

  processAppleSignUp() async {
    AuthorizationCredentialAppleID? user;
    try {
      //var user = await FirebaseService.signInWithGoogle(context: context);
      user = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId: 'com.link_go.link_go',
          redirectUri:
              // For web your redirect URI needs to be the host of the "current page",
              // while for Android you will be using the API server that redirects back into your app via a deep link
              Uri.parse(
            'https://mighty-longing-machine.glitch.me/callbacks/sign_in_with_apple',
          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      showErrorToast(message: 'Apple login failed. Please try again.');

      return;
    }
    // ignore: avoid_print
    debugPrint(user.toString());

    debugPrint("user.userIdentifier: ");
    debugPrint(user.userIdentifier);

    debugPrint("user.identityToken: ");
    debugPrint(user.identityToken);

    debugPrint("user.familyName: ");
    debugPrint(user.familyName);
    debugPrint("user.givenName: ");
    debugPrint(user.givenName);

    var firstName = user.givenName ?? '';
    var surname = user.familyName ?? '';
    var name = "$surname $firstName";

    //perform login

    performAppleLogin(user.identityToken ?? '');
  }

  processGoogleSignUp(String type) async {
    try {
      // Attempt to sign in with Google
      var id = await signInWithGoogle();
// print(user);
//       if (user == null) {
//         // If the user is null, show a failure message and exit
//         showErrorToast(message: 'Google login failed. Please try again.');
//         return;
//       }else {
//         // Create the service auth user object
//         var userData = ServiceAuthUser(
//           platform: 'Google',
//           email: user.email ?? '',
//           name: user.displayName ?? '',
//           phone: user.phoneNumber,
//           uid: user.uid,
//           pictureUrl: user.photoURL,
//         );

      // Proceed to perform the service authentication
      await performServiceAuth(id);
    } catch (e) {
      // Handle unexpected errors
      debugPrint('Error during Google Sign-Up: $e');
      showErrorToast(
          message: 'An unexpected error occurred. Please try again later.');
    }
  }

// login page validatiom
  bool get isFormValid {
    // Check if both email and pin are not empty
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

// pin and phone validation
  checkActive() {
    notifyListeners();
  }

// Carousal slider images
  final currentPageProvider = StateProvider<int>((ref) => 0);

  final List<Widget> myitems = [
    ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
  ];

  //Old ones
  String _destinationAddress = '';
  double? _destinationLat;
  double? _destinationLng;

  double? _shippingLat;
  double? _shippingLng;

  double? get sellerLat => _shippingLat;
  double? get sellerLng => _shippingLng;

  set sellerLat(double? value) {
    _shippingLat = value;
  }

  set sellerLng(double? value) {
    _shippingLng = value;
  }

  double? _userProLat;
  double? _userProLng;
  double? get userProlat => _userProLat;
  double? get userProLng => _userProLng;

  set userProlat(double? value) {
    _shippingLat = value;
  }

  set userProLng(double? value) {
    _shippingLng = value;
  }

  String get destinationAddress => _destinationAddress;
  double? get destinationLat => _destinationLat;
  double? get destinationLng => _destinationLng;
  set destinationLat(double? value) {
    _destinationLat = value;
  }
  set destinationLng(double? value) {
    _destinationLng = value;
  }

  setAddress(
    String address,
    double? lat,
    double? lng,
  ) {
    _destinationAddress = address;
    _destinationLat = lat;
    _destinationLng = lng;
    notifyListeners();
  }

  //
  // late SignInResponse _currentUser;
  // SignInResponse get currentUser => _currentUser;
  //
  // late AuthModel _token;
  // AuthModel get token => _token;

  late String _role;
  String get role => _role;

  bool isLoading = false;

  // Setters
  setRole(String value) async {
    _role = value;
    notifyListeners();
  }

  // Setters
  setLoading(bool value) async {
    isLoading = value;
    notifyListeners();
  }

  alreadyLoggedIn() async {
    var d = await StorageUtil.getData('profile');
    SignInResponse user = SignInResponse.fromJson(json.decode(d!));
    _currentUser = user;
    var t = await StorageUtil.getData('token');
    final AuthModel auth = AuthModel.fromJson(t!);
    _token = auth;
    _navigation.navigateReplacementTo(bottomNavigationRoute);
    return "Success";
  }

  Position? _userPosition;
  Position? get userPosition => _userPosition;
  CustomerAddress? _currentAddress;
  CustomerAddress? get currentAddress => _currentAddress;

  //
  // Future<void> getUserLocationAndAddress() async {
  //   try {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       showToast(message: "Kindly enable location services");
  //       return;
  //     }
  //
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         showToast(message: "Location permission denied");
  //         return;
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       showToast(message: "Permission permanently denied. Enable it in settings.");
  //       return;
  //     }
  //
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     _userPosition = position;
  //
  //     print(_userPosition!.latitude);
  //     print(_userPosition!.latitude);
  //     print(_userPosition!.longitude);
  //     print(_userPosition!.latitude);
  //     print(_userPosition!.longitude);
  //
  //     // Reverse geocoding
  //     List<Geocoding.Placemark> placemarks = await Geocoding.placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Geocoding.Placemark place = placemarks.first;
  //
  //       _currentAddress = CustomerAddress(
  //         addressTitle: "Current Location",
  //         address: "${place.street}, ${place.subLocality}",
  //         city: place.locality ?? '',
  //         state: place.administrativeArea ?? '',
  //         lga: place.subAdministrativeArea ?? '',
  //         landmark: place.name ?? '',
  //         defaultAddress: true,
  //       );
  //
  //       debugPrint("Customer Address: ${_currentAddress!.toJson()}");
  //     }
  //
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint("Error getting location/address: $e");
  //     showToast(message: "Failed to get current location.");
  //   }
  // }

  // Future<void> getUserLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Check if location services are enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // You can show a dialog to prompt the user to enable location services
  //     print('Location services are disabled.');
  //     return;
  //   }
  //
  //   // Check permission
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       print('Location permissions are denied');
  //       return;
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     print('Location permissions are permanently denied');
  //     return;
  //   }
  //
  //   // Get the current position
  //   _userPosition = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //   print('User location: ${userPosition!.latitude}, ${userPosition!.longitude}');
  //   notifyListeners();
  // }

  StreamSubscription<Position>? _positionStreamSubscription;

  void startListeningToLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 2000, // only update if user moves 10m or more
      ),
    ).listen((Position position) {
      _userPosition = position;
      print('New location update: ${position.latitude}, ${position.longitude}');
      notifyListeners();
    });
  }

  void stopListeningToLocation() {
    _positionStreamSubscription?.cancel();
  }
  //
  // Future<void> initUserLocation() async {
  //  // if (_userPosition != null) return; // Already have it
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     print("Location services disabled");
  //     return;
  //   }
  //
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       print("Location permission denied");
  //       return;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     print("Location permission permanently denied");
  //     return;
  //   }
  //
  //   _userPosition = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.medium,
  //   );
  //   print(
  //       "User location initialized: ${_userPosition!.latitude}, ${_userPosition!.longitude}");
  //   notifyListeners();
  //
  //   // Reverse geocoding
  //   List<Geocoding.Placemark> placemarks =
  //       await Geocoding.placemarkFromCoordinates(
  //     _userPosition!.latitude,
  //     _userPosition!.longitude,
  //   );
  //
  //   if (placemarks.isNotEmpty) {
  //     Geocoding.Placemark place = placemarks.first;
  //
  //     _currentAddress = CustomerAddress(
  //       addressTitle: "Current Location",
  //       address: "${place.street}, ${place.subLocality}",
  //       city: place.locality ?? '',
  //       state: place.administrativeArea ?? '',
  //       lga: place.subAdministrativeArea ?? '',
  //       landmark: place.name ?? '',
  //       defaultAddress: true,
  //     );
  //
  //     debugPrint("Customer Address: ${_currentAddress!.toJson()}");
  //     notifyListeners();
  //
  //     if (_currentAddress?.state?.isNotEmpty == true) {
  //       ref.read(RiverpodProvider.productProvider).setMyProduct(
  //         // state: _currentAddress?.state??"",
  //         // city: _currentAddress?.city??"",
  //         long: _userPosition?.longitude ?? 0.0,
  //         lat: _userPosition?.latitude ?? 0.0
  //       );
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> initUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services disabled");
      _setFallbackLocation();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        _promptLocationDialog();
        _setFallbackLocation();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied");
      _promptLocationDialog();
      _setFallbackLocation();
      return;
    }

    try {
      _userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      print("User location initialized: ${_userPosition!.latitude}, ${_userPosition!.longitude}");

      // Reverse geocoding
      List<Geocoding.Placemark> placemarks = await Geocoding.placemarkFromCoordinates(
        _userPosition!.latitude,
        _userPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        Geocoding.Placemark place = placemarks.first;

        _currentAddress = CustomerAddress(
          addressTitle: "Current Location",
          address: "${place.street}, ${place.subLocality}",
          city: place.locality ?? '',
          state: place.administrativeArea ?? '',
          lga: place.subAdministrativeArea ?? '',
          landmark: place.name ?? '',
          defaultAddress: true,
        );

        debugPrint("Customer Address: ${_currentAddress!.toJson()}");
      }
    } catch (e) {
      print("Error fetching location: $e");
      _setFallbackLocation();
    }

    // Always set backend coordinates, fallback to 0.0 if null
    ref.read(RiverpodProvider.productProvider).setMyProduct(
      lat: _userPosition?.latitude ?? 0.0,
      long: _userPosition?.longitude ?? 0.0,
    );

    notifyListeners();
  }

  void _setFallbackLocation() {
    _userPosition = null;
    _currentAddress = null;
    ref.read(RiverpodProvider.productProvider).setMyProduct(
      lat: 0.0,
      long: 0.0,
    );
    notifyListeners();
  }
  void _promptLocationDialog() {
    final rootContext = NavigatorService.navigationKey_.currentContext;
    if (rootContext != null) {
      showDialog(
        context: rootContext,
        barrierDismissible: false, // user must tap button
        builder: (dialogContext) {
          return AlertDialog(
            title: Text('Location Required'),
            content: Text('Please enable location to get nearby products.'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(dialogContext); // use dialog's own context
                  await Geolocator.openAppSettings();
                },
                child: Text('Open Settings'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext); // safely close dialog
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
  }

  Future<void> checkAndRequestLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services disabled");
      // optionally show a dialog asking user to enable location
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        // You can show a SnackBar or dialog asking user to enable it
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied");
      // Show dialog directing user to app settings
      return;
    }

    // Permission granted
    _userPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
  }


  String? shippingAddress = '';
  TextEditingController businessAddressController = TextEditingController();

  // void showDestinationAddressPicker(appProvider) async {
  //   final defaultLatLng = LatLng(6.5244, 3.3792);
  //   final currentLatLng = appProvider._userPosition != null
  //       ? LatLng(
  //     appProvider._userPosition!.latitude,
  //     appProvider._userPosition!.longitude,
  //   )
  //       : defaultLatLng;
  //   Navigator.push(
  //     NavigatorService.navigationKey_.currentContext!,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         print("Opening MapLocationPicker...");
  //         return MapLocationPicker(
  //           location: Location(lat: 9.0820, lng: 8.6753),
  //           radius: 1200,
  //           apiKey: dotenv.env['GOOGLE_MAP_KEY'] ??"",
  //           currentLatLng: currentLatLng,
  //           popOnNextButtonTaped: true,
  //           backButton: IconButton(
  //             onPressed: () {
  //               NavigatorService().goBack();
  //             },
  //             icon: const Icon(Icons.arrow_back_ios),
  //           ),
  //           hideBackButton: false,
  //           onNext: (GeocodingResult? result) {
  //             shippingAddress = result?.formattedAddress ?? '';
  //             businessAddressController.text = result?.formattedAddress ?? '';
  //            // updateUserAddressController.text = result?.formattedAddress ?? '';
  //             shippingLat = result?.geometry.location.lat;
  //             shippingLng = result?.geometry.location.lng;
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  void showDestinationAddressPicker(
    appProvider,
  ) async {
    final defaultLatLng = LatLng(6.5244, 3.3792); // Lagos fallback
    final currentLatLng = appProvider._userPosition != null
        ? LatLng(
            appProvider._userPosition?.latitude,
            appProvider._userPosition?.longitude,
          )
        : defaultLatLng;

    Navigator.push(
      NavigatorService.navigationKey_.currentContext!,
      MaterialPageRoute(
        builder: (context) {
          print("Opening MapLocationPicker...");
          return MapLocationPicker(
            location: Location(lat: 9.0820, lng: 8.6753), // Abuja center
            radius: 1200,
            apiKey: dotenv.env['GOOGLE_MAP_KEY'] ?? "",
            currentLatLng: currentLatLng,
            popOnNextButtonTaped: true,
            backButton: IconButton(
              onPressed: () {
                NavigatorService().goBack();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            hideBackButton: false,
            onNext: (GeocodingResult? result) {
              if (result == null) return;

              // Assign formatted address
              shippingAddress = result.formattedAddress ?? '';
              businessAddressController.text = result.formattedAddress ?? '';

              // Extract city and state from components
              String? city;
              String? state;

              for (var component in result.addressComponents) {
                if (component.types.contains('locality')) {
                  city = component.longName;
                } else if (component.types
                    .contains('administrative_area_level_1')) {
                  state = component.longName;
                }
              }
              sellerCity.text = city ?? '';

              // Match and assign state to seller dropdown
              if (state != null) {
                try {
                  final matchingState = this.state.firstWhere(
                        (s) => s.name.toLowerCase() == state?.toLowerCase(),
                      );
                  this.selectedSellerState = matchingState;
                  this.notifyListeners(); // Optional: UI update
                } catch (e) {
                  print("State '$state' not found in accountProvider.state");
                }
              }
              // Assign lat/lng
              _shippingLat = result.geometry.location.lat;
              _shippingLng = result.geometry.location.lng;
              notifyListeners();
              print("Shipping address: $shippingAddress");
              print("City: $city");
              print("State: $state");
            },
          );
        },
      ),
    );
  }

  // void showDestinationAddress(appProvider) async {
  //   // If current position is null, fallback to a default center (e.g. Abuja, Nigeria)
  //   final defaultLatLng = LatLng(9.0820, 8.6753); // Replace with your app's fallback location
  //
  //   final currentLatLng = appProvider._userPosition != null
  //       ? LatLng(
  //     appProvider._userPosition!.latitude,
  //     appProvider._userPosition!.longitude,
  //   )
  //       : defaultLatLng;
  //
  //   Navigator.push(
  //     NavigatorService.navigationKey_.currentContext!,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         print("Opening MapLocationPicker...");
  //         return MapLocationPicker(
  //           location: Location(lat: defaultLatLng.latitude, lng: defaultLatLng.longitude),
  //           radius: 1200,
  //           apiKey: dotenv.env['GOOGLE_MAP_KEY'] ??"", //"AIzaSyBSzjGUZiQN3ixGLGVHs1p3o6mUm9GxYfs",
  //           currentLatLng: currentLatLng,
  //           popOnNextButtonTaped: true,
  //           backButton: IconButton(
  //             onPressed: () {
  //               NavigatorService().goBack();
  //             },
  //             icon: const Icon(Icons.arrow_back_ios),
  //           ),
  //           hideBackButton: false,
  //           onNext: (GeocodingResult? result) {
  //             updateUserAddressController.text = result?.formattedAddress ?? '';
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
//TODO ADD USER LNG AND LAT TO THE USER PROFILE
  void showUserAddressPicker(appProvider) async {
    // Fallback to default location (Abuja, Nigeria)
    final defaultLatLng = LatLng(9.0820, 8.6753);

    final currentLatLng = appProvider._userPosition != null
        ? LatLng(
            appProvider._userPosition!.latitude,
            appProvider._userPosition!.longitude,
          )
        : defaultLatLng;

    Navigator.push(
      NavigatorService.navigationKey_.currentContext!,
      MaterialPageRoute(
        builder: (context) {
          print("Opening MapLocationPicker...");
          return MapLocationPicker(
            location: Location(
              lat: defaultLatLng.latitude,
              lng: defaultLatLng.longitude,
            ),
            radius: 1200,
            apiKey: dotenv.env['GOOGLE_MAP_KEY'] ?? "",
            currentLatLng: currentLatLng,
            popOnNextButtonTaped: true,
            backButton: IconButton(
              onPressed: () {
                NavigatorService().goBack();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            hideBackButton: false,
            onNext: (GeocodingResult? result) {
              if (result == null) return;

              String? city;
              String? state;

              // Extract city and state from address components
              for (var component in result.addressComponents) {
                if (component.types.contains('locality')) {
                  city = component.longName;
                } else if (component.types
                    .contains('administrative_area_level_1')) {
                  state = component.longName;
                }
              }
              updateUserCityController.text = city ?? '';
              updateUserAddressController.text = result.formattedAddress ?? '';
              _userProLng = result.geometry.location.lng;
              _userProLat = result.geometry.location.lat;
              if (state != null) {
                try {
                  final matchingState = this.state.firstWhere(
                        (s) => s.name.toLowerCase() == state!.toLowerCase(),
                      );
                  this.selectedBasicState = matchingState;
                  this.notifyListeners();
                } catch (e) {
                  print("State '$state' not found in the list");
                }
              }
              notifyListeners();
              print('City: $city');
              print('State: $state');
            },
          );
        },
      ),
    );
  }

  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController checkoutCityController = TextEditingController();
  TextEditingController checkoutStateController = TextEditingController();

  Future<void> showShippingAddress(appProvider) async {
    final defaultLatLng =
        LatLng(9.0820, 8.6753);

    final currentLatLng = appProvider._userPosition != null
        ? LatLng(
            appProvider._userPosition!.latitude,
            appProvider._userPosition!.longitude,
          )
        : defaultLatLng;

    await Navigator.push(
      NavigatorService.navigationKey_.currentContext!,
      MaterialPageRoute(
        builder: (context) {
          print("Opening MapLocationPicker...");
          return MapLocationPicker(
            location: Location(
                lat: defaultLatLng.latitude, lng: defaultLatLng.longitude),
            radius: 1200,
            apiKey: dotenv.env['GOOGLE_MAP_KEY'] ??
                "", //"AIzaSyBSzjGUZiQN3ixGLGVHs1p3o6mUm9GxYfs",
            currentLatLng: currentLatLng,
            popOnNextButtonTaped: true,
            backButton: IconButton(
              onPressed: () {
                NavigatorService().goBack();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            hideBackButton: false,
            onNext: (GeocodingResult? result) {
             //  shippingAddressController.text = result?.formattedAddress ?? '';

             // // Navigator.pop(context);
             //  notifyListeners();
              if (result == null) return;
              String? checkoutCity;
              String? checkoutState;
              // Extract city and state from address components
              for (var component in result.addressComponents) {
                if (component.types.contains('locality')) {
                  checkoutCity = component.longName;
                } else if (component.types
                    .contains('administrative_area_level_1')) {
                  checkoutState = component.longName;
                }
              }
              _destinationLat = result?.geometry.location.lat;
              _destinationLng = result?.geometry.location.lng;
              checkoutCityController.text = checkoutCity ?? '';
              checkoutStateController.text = checkoutState ?? '';
              shippingAddressController.text = result?.formattedAddress ?? '';
              notifyListeners();
            },
          );
        },
      ),
    );
  }

  void clearCheckoutData() {
    checkoutData = null;
 //   selectedCouriers = {};
    notifyListeners();
  }

  // // Track selected couriers per seller
  // Map<String, Courier> selectedCouriers = {};
  //
  // int get selectedDeliveryFeeTotal =>
  //     selectedCouriers.values.fold(0, (sum, c) => sum + c.deliveryFee);
  //
  // int get grandTotal =>
  //     (checkoutData?.cartSummary.totalAmount ?? 0) +
  //         selectedDeliveryFeeTotal;

  // ensure each checkout has selected courier//----





  CheckoutData? checkoutData;
  checkout(
    String? address,
    String? phoneNumber,
  ) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.checkout({
        "deliveryAddress": {
          "name": "${currentUser.firstname} ${currentUser.lastname}",
          "phone": phoneNumber,
          "address": address ?? '',
          "city": checkoutCityController.text, //currentUser.city ?? "",
          "state": checkoutStateController.text, // currentUser.state ?? '',
          // "postalCode": "200001",
          "country": "Nigeria",
          "isDefault": true,
          "latitude": _destinationLat,
          "longitude": _destinationLng,
        }
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        checkoutData = CheckoutData.fromJson(result.data);
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  String? reference;
  String? sk;

  confirmCheckout() async {
    setBusy(true);
    try {
      final selectedCouriers = checkoutData?.shippingOptions.map((option) {
        final courier = option.couriers.first;

        return {
          "sellerId": option.seller.id,
          "serviceCode": courier.serviceCode,
          "courierId": courier.courierId,
          "courierName": courier.courierName,
          "deliveryFee": courier.deliveryFee,
          "requestToken": option.requestToken,
          "deliveryEtaTime": courier.deliveryEtaTime,
          "buyerDeliveryAddress": shippingAddressController.text.trim(), // required by backend
        };
      }).whereType<Map<String, dynamic>>().toList();

      print("Final selectedCouriers payload: $selectedCouriers");

      HTTPResponseModel result = await _authRepository.confirmCheckout({
        "selectedCouriers": selectedCouriers,
      });
      setBusy(false);
      reference = result.all['reference'];
      sk = result.all['key'];
      if (reference != null && sk != null) {
        print("Checkout confirmed successfully");
        notifyListeners();
        PayWithPayStack().now(
          context: NavigatorService.navigationKey_.currentContext!,
          secretKey: sk ?? "",
          customerEmail: currentUser.email ?? '',
          reference: reference ?? "",
          currency: "NGN",
          amount: (checkoutData?.cartSummary.grandTotal ?? 0).toDouble(),
          callbackUrl: "https://google.com",
          transactionCompleted: (paymentData) {
            print(paymentData);
            print(paymentData.reference);
             verifyPayment();
          },

          transactionNotCompleted: (reason) {
            debugPrint("==> Transaction failed reason $reason");
            Navigator.pushReplacementNamed(
              NavigatorService.navigationKey_.currentContext!,
              cartPageScreen,
            );
          },

        );
        return true;
      } else {
        showErrorToast(message: "Invalid payment data from server.");
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

 TextEditingController paywithWalletPin = TextEditingController();
  payWithWallet(String pin) async {
    setBusy(true);
    try {
      final selectedCouriers = checkoutData?.shippingOptions.map((option) {
        final courier = option.couriers.first;
        return {
          "sellerId": option.seller.id,
          "serviceCode": courier.serviceCode,
          "courierId": courier.courierId,
          "courierName": courier.courierName,
          "deliveryFee": courier.deliveryFee,
          "requestToken": option.requestToken,
          "deliveryEtaTime": courier.deliveryEtaTime,
          "buyerDeliveryAddress": shippingAddressController.text.trim(),
        };
      }).whereType<Map<String, dynamic>>().toList();

      print("Final selectedCouriers payload: $selectedCouriers");

      HTTPResponseModel result = await _authRepository.payWithWallet({
        "selectedCouriers": selectedCouriers,
        "transactionPin": pin,
        "description": "Paying with Wallet"
      });

      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        paywithWalletPin.clear();
        showToast(message: result.message);
        getUserProfile();

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e, stackTrace) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }


  verifyPayment() async {
    setBusy(true);
    HTTPResponseModel res = await _authRepository.verifyPayment(
        {"reference": reference});
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(message: res.all['message']);
      checkoutData = null;
      _navigation.pushAndRemoveUntil(bottomNavigationRoute);
      return true;
    } else {
      _navigation.pushAndRemoveUntil(bottomNavigationRoute);
    }
  }









  // sign up method
  final signUpMethodProvider = StateProvider<String>((ref) => '');
  // login

  // validate passwordcharacters

  bool criteria1Satisfied = false;
  bool criteria2Satisfied = false;
  bool hasUppercaseLetter = false;
  bool hasLowercaseLetter = false;
  bool hasNumber = false;
  bool hasSymbol = false;

  void validatePassword() {
    if (passwordController.text.length >= 8) {
      criteria1Satisfied = true;
      notifyListeners();
    } else {
      criteria1Satisfied = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[A-Z]'))) {
      hasUppercaseLetter = true;
      notifyListeners();
    } else {
      hasUppercaseLetter = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[a-z]'))) {
      hasLowercaseLetter = true;
      notifyListeners();
    } else {
      hasLowercaseLetter = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[0-9]'))) {
      hasNumber = true;
      notifyListeners();
    } else {
      hasNumber = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSymbol = true;
      notifyListeners();
    } else {
      hasSymbol = false;
      notifyListeners();
    }

    if (hasUppercaseLetter && hasLowercaseLetter && hasNumber && hasSymbol) {
      criteria2Satisfied = true;
      notifyListeners();
    } else {
      criteria2Satisfied = false;
      notifyListeners();
    }
  }

  // for change password in settings
  void validatePassword2() {
    if (userChangePassNew.text.length >= 8) {
      criteria1Satisfied = true;
      notifyListeners();
    } else {
      criteria1Satisfied = false;
      notifyListeners();
    }

    if (userChangePassNew.text.contains(RegExp(r'[A-Z]'))) {
      hasUppercaseLetter = true;
      notifyListeners();
    } else {
      hasUppercaseLetter = false;
      notifyListeners();
    }

    if (userChangePassNew.text.contains(RegExp(r'[a-z]'))) {
      hasLowercaseLetter = true;
      notifyListeners();
    } else {
      hasLowercaseLetter = false;
      notifyListeners();
    }

    if (userChangePassNew.text.contains(RegExp(r'[0-9]'))) {
      hasNumber = true;
      notifyListeners();
    } else {
      hasNumber = false;
      notifyListeners();
    }

    if (userChangePassNew.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSymbol = true;
      notifyListeners();
    } else {
      hasSymbol = false;
      notifyListeners();
    }

    if (hasUppercaseLetter && hasLowercaseLetter && hasNumber && hasSymbol) {
      criteria2Satisfied = true;
      notifyListeners();
    } else {
      criteria2Satisfied = false;
      notifyListeners();
    }
  }
}

//
class ShowHideNotifier extends StateNotifier<bool> {
  ShowHideNotifier() : super(false);
  void toggle(bool isExpanded) {
    state = isExpanded;
  }
}

final showHideProvider = StateNotifierProvider<ShowHideNotifier, bool>((ref) {
  return ShowHideNotifier();
});
//
