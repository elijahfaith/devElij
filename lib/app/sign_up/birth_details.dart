import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/sign_up/dating_intention.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/progress_bar_manager/appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/pin_input_field.dart';

class BirthDetails extends ConsumerStatefulWidget {
  const BirthDetails({super.key});

  @override
  ConsumerState createState() => _AgeConfirmationState();
}

class _AgeConfirmationState extends ConsumerState<BirthDetails> {
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
  String? selectedGender = 'Select Gender';


  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24.r)

                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },


                              child: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Your Birth Details',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Essential for accurate astrological calculators ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender*',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black54),
                              ),
                            ),
                            hint: const Text('Gender'),
                            value: selectedGender,
                            items: [
                              DropdownMenuItem(value: 'Select Gender', child: Text('Select Gender', style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),)),
                              DropdownMenuItem(value: 'Male', child: Text('Male', style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),)),
                               DropdownMenuItem(value: 'Female', child: Text('Female', style: GoogleFonts.poppins(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w400,
                                 color: Colors.black,
                               ),)),
                               DropdownMenuItem(value: 'Other', child: Text('Other', style: GoogleFonts.poppins(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w400,
                                 color: Colors.black,
                               ),)),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Birth Date',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          TextFormField(
                           // controller: accountProvider.signInPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_month_outlined,
                                 // color: Colors.white, // AppColors.fadedBlack.withOpacity(0.4),
                                ),
                                onPressed: () {
                                  // setState(() {
                                  //   passwordVisible = !passwordVisible;
                                  // });
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
                                  width: 0.5,
                                  color: AppColors.black,
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: AppColors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: AppColors.black,
                                  width: 0.5,
                                ),
                              ),
                              errorStyle: const TextStyle(color: AppColors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onChanged: (v) {},
                            //obscureText: passwordVisible,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Use to calculate your sun sign and compatibility',
                            //textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ), SizedBox(height: 15.h),
                          Text(
                            'Birth Time (Optional)',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          TextFormField(
                           // controller: accountProvider.signInPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.schedule,
                                 // color: Colors.white, // AppColors.fadedBlack.withOpacity(0.4),
                                ),
                                onPressed: () {
                                  // setState(() {
                                  //   passwordVisible = !passwordVisible;
                                  // });
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
                                  width: 0.5,
                                  color: AppColors.black,
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: AppColors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: AppColors.black,
                                  width: 0.5,
                                ),
                              ),
                              errorStyle: const TextStyle(color: AppColors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onChanged: (v) {},
                            //obscureText: passwordVisible,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'For moon and rising sign calculations (more accurate matches!)',
                            //textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ), SizedBox(height: 15.h),
                          Text(
                            'Birth Location*',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          TextFormField(
                           // controller: accountProvider.signInPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_month_outlined,
                                 // color: Colors.white, // AppColors.fadedBlack.withOpacity(0.4),
                                ),
                                onPressed: () {
                                  // setState(() {
                                  //   passwordVisible = !passwordVisible;
                                  // });
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
                                  width: 0.5,
                                  color: AppColors.black,
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: AppColors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: AppColors.black,
                                  width: 0.5,
                                ),
                              ),
                              errorStyle: const TextStyle(color: AppColors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onChanged: (v) {},
                            //obscureText: passwordVisible,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Helps calculate your rising sign and local cosmic influences',
                            //textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),



                //  const Spacer(),
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
                            // You can use selectedAge here
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DatingIntention()));
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
      ),
    );
  }
}
