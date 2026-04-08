import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/login/login_screen.dart';
import 'package:link_go/app/onboarding/onboarding_screen_model.dart';
import 'package:link_go/app/sign_up/signup.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/animated_navigation.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/screen_size.dart';

import 'onboarding_screen_view_two.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final AnimatedNavigation _navigation = AnimatedNavigation();
  final PageController _controller = PageController();
  late AccountProvider accountProvider;

  late final List<OnboardingScreenModel> screens;
  late final int lastPage;
  int currentPage = 0;
  bool isLastPage = false;

  void nextAction() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
    );
  }

  void signup() {
    _navigation.navigateTo(
      context: context,
      destinationScreen: const Signup(),
      animationDuration: 1200,
    );
  }

  void doneAction() {
    _navigation.navigateTo(
      context: context,
      destinationScreen: const OnboardingScreenViewTwo(),
      animationDuration: 1200,
    );
  }

  @override
  void initState() {
    super.initState();
    screens = getScreens();
    lastPage = screens.length - 1;

    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page?.round() ?? 0;
        isLastPage = currentPage == lastPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 Background image (fills the screen)
          Positioned.fill(
            child: Image.asset(
              "assets/images/onboarding_backgrounf.jpg",
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// 🌑 Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          /// ✨ Foreground content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                // SizedBox(height: 100.h),
                // SizedBox(height: 60.h),
                // SizedBox(height: 50.h),
                Image.asset(
                  'assets/images/lovely.png',
                  height: 100.h,
                  fit: BoxFit.contain,
                ),

                Text(
                  "Find Your",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 35.sp,
                    color: AppColors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Perfect",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 35.sp,
                        color: Color.fromRGBO(159, 45, 15, 1),
                      ),
                    ),Text(
                      " Match",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 35.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Text(
                  "Meet New People, Spark Real Connections, And See Where it Goes on ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 30.h),

               // const Spacer(),
                MaterialButton(
                  onPressed: () {
                  doneAction();

                  },
                  child: Container(
                    height: 55.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
