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

class OnboardingScreenViewTwo extends ConsumerStatefulWidget {
  const OnboardingScreenViewTwo({super.key});

  @override
  ConsumerState<OnboardingScreenViewTwo> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreenViewTwo> {
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
      destinationScreen: const LoginScreen(),
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
            child: Container(color: Colors.black.withOpacity(0.7)),
          ),

          /// ✨ Foreground content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                Image.asset(
                  'assets/images/lovely.png',
                  height: 100.h,
                  fit: BoxFit.contain,
                ),

                Text(
                  "Inclusive, Reliable, Safe ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ),

                SizedBox(height: 30.h),
                Text(
                  "Find your cosmic connection through the ancient wisdom of astrology. Your birth chart holds the key to compatibility and deeper understanding",
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
                    signup();
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
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5.w,
                  children: [
                    Text(
                      "Already have an account?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColors.white,
                      ),
                    ),InkWell(
                      onTap: (){
                        doneAction();
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
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
