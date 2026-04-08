import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/sign_up/birth_details.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/progress_bar_manager/appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/pin_input_field.dart';

class AgeConfirmation extends ConsumerStatefulWidget {
  const AgeConfirmation({super.key});

  @override
  ConsumerState createState() => _AgeConfirmationState();
}

class _AgeConfirmationState extends ConsumerState<AgeConfirmation> {
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int selectedAge = 18; // default selected age

  void _updateButtonState() {
    // Enable button when age is selected
    _isButtonEnabled.value = selectedAge > 0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateButtonState();
    });
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
                      Image.asset("assets/images/boygirl.png", height: 40.h,),
                      Text(
                        'How Old are you?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'We’ll use this to help verify your identity and that you are over 18 ',
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

                SizedBox(height: 40.h),

                // ✅ Age Picker Wheel
                SizedBox(
                  height: 200.h,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedAge = index;
                        _updateButtonState();
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index > 100) return null;
                        return Center(
                          child: Text(
                            index.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 28.sp,
                              fontWeight: selectedAge == index? FontWeight.bold : FontWeight.w400,
                              color: selectedAge == index
                                  ? AppColors.black
                                  : Colors.black54,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Spacer(),
                ValueListenableBuilder<bool>(
                  valueListenable: _isButtonEnabled,
                  builder: (context, isEnabled, _) {
                    return CustomButton(
                      label: "Continue",
                      fillColor:
                      isEnabled ? AppColors.primaryColor : Colors.grey,
                      onPressed: isEnabled
                          ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BirthDetails(),
                            ),
                          );
                          print("Selected Age: $selectedAge");
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
