import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/forgotPassword/otp_verification_screen.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/app/widgets/custom_text_form_field.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/helpers.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

class EmailInputScreen extends ConsumerStatefulWidget {
  const EmailInputScreen({super.key});

  @override
  ConsumerState<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends ConsumerState<EmailInputScreen> {
  final NavigatorService _navigation = NavigatorService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AccountProvider accountProvider;
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  void _updateButtonState() {
    final isEmailNotEmpty =
        accountProvider.forgotPasswordEmailController.text.isNotEmpty;
    _isButtonEnabled.value = isEmailNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // accountProvider = ref.read(RiverpodProvider.accountProvider);
      accountProvider.forgotPasswordEmailController.addListener(
        _updateButtonState,
      );
      _updateButtonState(); // Initial check
    });
  }

  @override
  void dispose() {
    accountProvider.forgotPasswordEmailController.removeListener(
      _updateButtonState,
    );
    accountProvider.forgotPasswordEmailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: CustomAppBar(centerTitle: false, onTap: () {}),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Account Recovery',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'We’ll email you with 5 digit code to recover your account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
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
                  controller: accountProvider.forgotPasswordEmailController,
                  validator: Validators().isEmail,
                ),
                Spacer(),
                ValueListenableBuilder<bool>(
                  valueListenable: _isButtonEnabled,
                  builder: (context, isEnabled, _) {
                    return CustomButton(
                      label: "Continue",
                      fillColor: isEnabled
                          ? AppColors.primaryColor
                          : Colors.grey,
                      onPressed: isEnabled
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OtpVerificationScreen(),
                                  ),
                                );

                                //  accountProvider.forgetPassword();
                              }
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
