import 'dart:io';

import 'package:flutter/material.dart';
import 'package:link_go/app/bottom_nav/nav.dart';
import 'package:link_go/app/forgotPassword/email_input_screen.dart';
import 'package:link_go/app/forgotPassword/set_new_password.dart';
import 'package:link_go/app/home/confirmed_payment.dart';
import 'package:link_go/app/home/pay_with_wallet.dart';
import 'package:link_go/app/home/widgets/carousel_content.dart';
import 'package:link_go/app/login/login_screen.dart';
import 'package:link_go/app/notification.dart';
import 'package:link_go/app/onboarding/onboarding_screen_view.dart';
import 'package:link_go/app/profile/add_new_address.dart';
import 'package:link_go/app/settings/change_password_page.dart';
import 'package:link_go/app/settings/change_transaction_pin.dart';
import 'package:link_go/app/settings/delete_account.dart';
import 'package:link_go/app/profile/orders/my_oders_page.dart';
import 'package:link_go/app/sign_up/set_password.dart';
import 'package:link_go/app/sign_up/signup.dart';
import 'package:link_go/app/sign_up/verify_account.dart';
import 'package:link_go/models/Products.dart';
import 'package:link_go/models/SignInResponse.dart';
import 'package:link_go/models/categories_with_subcategories.dart';
import 'package:link_go/services/analytics_service.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/base_model.dart';
import 'package:link_go/utils/locator.dart';
import '../../app/forgotPassword/successful_reset_page.dart';
import '../../app/home/home_page.dart';
import '../../app/profile/about_us.dart';
import '../../app/profile/widgets/edit_dialog.dart';
import '../../app/settings/create_transaction_pin.dart';
import '../../app/settings/notifications_page.dart';
import '../../app/settings/privavy_and_security.dart';
import '../../app/settings/setting_page.dart';
import '../../models/BestSellerModel.dart';
import '../../models/CategoriesModel.dart';
import '../../models/MarketListModel.dart';
import '../../models/categories_with_subcategories.dart';
import '../../models/productModel.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case bottomNavigationRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const BottomNav(),
      );

    case loginScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const LoginScreen(),
      );

    case homeScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HomePage(),
      );

    case onBoardingScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const OnboardingScreen(),
      );
    case privacyAnsSecurity:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const PrivavyAndSecurity(),
      );

    case emailInputScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const EmailInputScreen(),
      );
    case confirmedPaymentPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ConfirmedPayment(),
      );
    case payWithWallet:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: PayWithWallet(),
      );
    case setNewPasswordRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SetNewPassword(),
      );
    case MyOrdersScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: MyOdersPage(),
      );

    case successfulResetPageScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SuccessfulResetPage(),
      );
    case completeSignUp:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const CompleteSignUp(),
      );
    case setPasswordScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SetPasswordScreen(),
      );
    case signupScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Signup(),
      );



    // case categories:
    //   Products CategoryModel = settings.arguments! as CategoryModel;
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: CategoriesPage(
    //       categories: newProducts,
    //     ),
    //   );
    case carouselContent:
      //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CarouselContent(
            // newProducts: newProducts,
            ),
      );

    //     case orderDetailScreen:
    // //    Products newProducts = settings.arguments! as Products;
    //     return _getPageRoute(
    //       routeName: settings.name!,
    //       viewToShow: OrderDetailPage(
    //        // newProducts: newProducts,
    //       ),
    //     );



    case editProfileRoute:
      //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EditProfileDialog(
            // newProducts: newProducts,
            ),
      );
    case aboutUs:
      //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AboutUs(
            // newProducts: newProducts,
            ),
      );

    case notificationPage:
      //    Products newProducts = settings.arguments! as Products;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: NotificationPage(
            // newProducts: newProducts,
            ),
      );

    case notificationPageRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const NotificationPage(),
      );
    case addNewAddressScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const AddNewAddress(),
      );
    case settingsScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SettingPage(),
      );

    case changePasswordScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ChangePasswordPage(),
      );
    case notificationSettingScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const NotificationsPage(),
      );
    case deleteAccountScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const DeleteAccount(),
      );
    case changeTransactionPINScreenRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ChangeTransactionPin(),
      );
    case createTransactionPin:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const CreateTransactionPin(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  locator<AnalyticsService>().setCurrentScreen(routeName);
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: Platform.isAndroid
                ? () async {
                    if (locator<BaseModel>().busy) {
                      return false;
                    } else {
                      return true;
                    }
                  }
                : null,
            child: viewToShow);
      });
}
