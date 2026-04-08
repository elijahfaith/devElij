import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/sign_up/your_interest_topics.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

class AddPhotos extends ConsumerStatefulWidget {
  const AddPhotos({super.key});

  @override
  ConsumerState<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends ConsumerState<AddPhotos> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // selected gender option
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: CustomAppBar(centerTitle: false, onTap: () {}),
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
                    Image.asset("assets/images/addPhoto.png", height: 30.h,),

                    SizedBox(height: 10.h),
                    Text(
                      "Add Photos",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Add at least 2 photos to continue\nUpload up to 6 photos',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.upload),
                            SizedBox(height: 10.w),
                            Text(
                              'Drag & drop Video here',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              width: 120.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.black,)
                              ),
                              child: Center(
                                child: Text(
                                  'Choose File',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                      ),
                    ),
                    SizedBox(height: 35.w),

                    Text(
                      'Your first photo will be your main\nprofile picture',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.all(20),
                child: CustomButton(
                  label: "Continue 0/6",
                  fillColor: AppColors.primaryColor,
                  onPressed: () {
                    /// NEXT PAGE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const YourInterestTopics(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderOption(String label) {
    bool isSelected = selectedGender == label;

    return InkWell(
      onTap: () {
        setState(() => selectedGender = label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),

            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
