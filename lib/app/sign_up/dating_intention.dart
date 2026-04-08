import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/sign_up/add_photos.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

class DatingIntention extends ConsumerStatefulWidget {
  const DatingIntention({super.key});

  @override
  ConsumerState<DatingIntention> createState() => _DatingIntentionState();
}

class _DatingIntentionState extends ConsumerState<DatingIntention> {
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
                    Image.asset("assets/images/datingIntention.png", height: 40.h),

                    SizedBox(height: 10.h),
                    Text(
                      "What's your Dating\nintention?",
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
                        'We match daters using three broad gender groups you can add more about your gender after',
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

              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    genderOption("Life Partner"),
                    genderOption("Long term Relationship"),
                    genderOption("Long term relationship, open to short"),
                    genderOption("Short term relationship, open to long"),
                    genderOption("Short term relationship"),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              Padding(
                padding: EdgeInsets.all(20),
                child: CustomButton(
                  label: "Continue",
                  fillColor: AppColors.primaryColor,
                  onPressed: () {
                    if (selectedGender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please select a gender option"),
                        ),
                      );
                      return;
                    }

                    /// NEXT PAGE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPhotos(),
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

            // Custom Radio Circle
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
