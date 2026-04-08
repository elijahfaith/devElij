import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/sign_up/terms_condition.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

class LocationEnabling extends ConsumerStatefulWidget {
  const LocationEnabling({super.key});

  @override
  ConsumerState<LocationEnabling> createState() => _LocationEnablingState();
}

class _LocationEnablingState extends ConsumerState<LocationEnabling> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: CustomAppBar(centerTitle: false, onTap: () {}),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset("assets/images/location.png", height: 30.h),

                  SizedBox(height: 10.h),
                  Text(
                    "Enable Location",
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
                    child: Column(
                      children: [
                        Text(
                          'Find people nearbye',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "We'll show you people in your area and help you discover matches close to you",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.w,
                    children: [
                      Image.asset("assets/images/bestmatch.png", height: 30.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Better Matches",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "See people in your area first",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.w,
                    children: [
                      Image.asset("assets/images/protected.png", height: 30.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Privacy protected",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Your exact location is never\nshared",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomButton(
                label: "Allow Location Access",
                fillColor: AppColors.primaryColor,
                onPressed: () {
                  /// NEXT PAGE
                  // Navigator.push(
                  //   context,
                  //   MaterialPa geRoute(
                  //     builder: (context) => const DatingIntention(),
                  //   ),
                  // );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CustomButton(
                label: "Skip for now",
                borderColor: Colors.black,
                buttonTextColor: Colors.black,
                fillColor: Colors.transparent,
                onPressed: () {
                  /// NEXT PAGE
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsCondition(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15.h,),

            Center(
              child: Text(
                textAlign: TextAlign.center,
                "You can change this setting later in\nyour profile",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 30.h,)

          ],
        ),
      ),
    );
  }
}
