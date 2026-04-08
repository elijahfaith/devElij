import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/progress_bar_manager/appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/pin_input_field.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  ConsumerState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _updateButtonState() {
    final isPinNotEmpty =
        accountProvider.forgotPasswordPinController.text.length == 5;
    _isButtonEnabled.value = isPinNotEmpty;
  }

  static const int _startSeconds = 60; // 10 minutes
  int _remainingSeconds = _startSeconds;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      accountProvider.forgotPasswordPinController.addListener(
        _updateButtonState,
      );
      _startTimer();
      _updateButtonState(); // Initial check
    });
  }

  @override
  void dispose() {
    accountProvider.forgotPasswordPinController.removeListener(
      _updateButtonState,
    );
    accountProvider.forgotPasswordPinController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: CustomAppBar(centerTitle: false, onTap: () {}),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'OTP VERIFICATION',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'They’ll send you 5 digit code to your Email to confirm it’s you ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: PinInputField(
                    pinNumber: 5,
                    obscure: false,
                    pinController: accountProvider.forgotPasswordPinController,
                  ),
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: ValueNotifier(_remainingSeconds),
                      builder: (context, value, _) {
                        final bool canResend = _remainingSeconds == 0;
                        return InkWell(
                          onTap: canResend
                              ? () {
                            // Reset the timer
                            setState(() {
                              _remainingSeconds = _startSeconds;
                              _startTimer();
                            });
                            //todo: resend otp api
                           // accountProvider.resentForgotPassOTP();
                          }
                              : null,
                          child: Text(
                            canResend
                                ? 'Resend Code?'
                                : 'Resend in ${_formatTime(_remainingSeconds)}',
                            style: TextStyle(
                              fontFamily: "SF Pro",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: canResend
                                  ? AppColors.black
                                  : Colors.grey, // Greyed out while waiting
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
