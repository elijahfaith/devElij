import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_go/app/login/login_screen.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/home/home_page.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/app/widgets/sign_in_button.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/utils/helpers.dart';
import 'package:link_go/utils/notification_helper.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/app/widgets/custom_text_form_field.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

import '../../utils/locator.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final NavigatorService _navigation = NavigatorService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  void _updateButtonState() {
    final isEmailNotEmpty =
        accountProvider.signUpEmailController.text.isNotEmpty &&
        accountProvider.phoneController.text.isNotEmpty &&
        accountProvider.passwordController.text.isNotEmpty;
    _isButtonEnabled.value = isEmailNotEmpty;
  }

  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  @override
  void dispose() {
    accountProvider.signUpEmailController.clear();
    accountProvider.phoneController.clear();
    accountProvider.passwordController.clear();
    super.dispose();
  }

  bool isChecked = false;

  @override
  void initState() {
    Future.microtask(() {
      accountProvider.signUpEmailController.addListener(_updateButtonState);
      accountProvider.phoneController.addListener(_updateButtonState);
      accountProvider.passwordController.addListener(_updateButtonState);
      _updateButtonState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,

        onTap: () {},
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/linkgo_text_logo.png",
                      height: 25.h,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Find your Partner',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      suffixIcon: Icon(Icons.email_outlined),

                      inputType: TextInputType.emailAddress,
                      //label: 'Email',
                      controller: accountProvider.signUpEmailController,
                      validator: Validators().isEmail,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Mobile Number',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      suffixIcon: Icon(Icons.phone_enabled_rounded),

                      inputType: TextInputType.phone,
                      //label: 'Email',
                      controller: accountProvider.phoneController,
                      validator: Validators().isPhone,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Password',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: accountProvider.passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.lock
                                : Icons.lock_open_rounded,
                            color: Colors.black, // AppColors.fadedBlack.withOpacity(0.4),
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8391A1),
                        ),
                        fillColor: Colors.grey.shade50,//,AppColors.white,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.black,
                          ),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: AppColors.black,
                            width: 1.w,
                          ),
                        ),
                        errorStyle: const TextStyle(color: AppColors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      onChanged: (v) {},
                      obscureText: passwordVisible,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                    ),
                    SizedBox(height: 40.h),

                    ValueListenableBuilder<bool>(
                      valueListenable: _isButtonEnabled,
                      builder: (context, isEnabled, _) {
                        return CustomButton(
                          label: "Sign Up",
                          fillColor: isEnabled
                              ? AppColors.primaryColor
                              : Colors.grey,
                          onPressed: isEnabled
                              ? () {
                                  if (_formKey.currentState!.validate()){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                    //accountProvider.startRegistration();
                                  }
                                }
                              : null,
                        );
                      },
                    ),

                    SizedBox(height: 15.h),
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'or Sign Up with',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      spacing: 15,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Center(
                            child: Image.asset(Assets.googleLogo, scale:4,)
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Center(
                              child: Image.asset(Assets.appLogo, scale:4,)
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Center(
                              child: Image.asset(Assets.facebookIcon, scale:4,)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
