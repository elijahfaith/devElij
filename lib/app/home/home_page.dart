import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/home/sub_category_page.dart';
import 'package:link_go/models/Products.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/utils/app_colors.dart';
import '../../models/categories_with_subcategories.dart';
import '../../providers/account_provider.dart';
import '../../utils/enums.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerStatefulWidget {
  final ScrollController? scrollController;

  HomePage({Key? key, this.scrollController}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
  final NavigatorService _navigation = NavigatorService();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final ScrollController _controller;
  TextEditingController _searchController = TextEditingController();
  Timer? _apiTimer;
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();

  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  int selectedOption = 0;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {});
  }

  void scrollToTop() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void stopPeriodicApiCall() {
    _apiTimer?.cancel();
  }

  @override
  void dispose() {
    stopPeriodicApiCall(); // cancel timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      // backgroundColor: Color(0xFAFAFA),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {},
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 15.h,
                top: 30.h,
                left: 15.w,
                right: 15.w,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/linkgo_text_logo.png",
                          height: 22,
                        ),
                        SizedBox(height: 10.h),

                        Text(
                          "Find Your Match",
                          style: GoogleFonts.outfit(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          textAlign: TextAlign.center,
                          "Connect with people who share your\npassions and lifestyle",
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
                    "Lifestyle Preferences",
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 120.h,
                          width: 196.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.r),
                            image: DecorationImage(
                              image: AssetImage("assets/images/babies.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Bottom fade container FIRST so it's behind
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 30.h, // fade height
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.r),
                                      bottomRight: Radius.circular(15.r),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Main content
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                              84,
                                              83,
                                              83,
                                              0.4,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              41.7.r,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/profile-2user.png",
                                                height: 18,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "3k",
                                                style: GoogleFonts.outfit(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Child-Free",
                                      style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),

                              // Last text ON TOP of fade
                              Positioned(
                                left: 8,
                                bottom: 10.h, // slightly above container bottom
                                child: Text(
                                  "Enjoying life without kids",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Container(
                          height: 120.h,
                          width: 196.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.r),
                            image: DecorationImage(
                              image: AssetImage("assets/images/babies.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Bottom fade container FIRST so it's behind
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 30.h, // fade height
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.r),
                                      bottomRight: Radius.circular(15.r),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Main content
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                              84,
                                              83,
                                              83,
                                              0.4,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              41.7.r,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/profile-2user.png",
                                                height: 18,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "3k",
                                                style: GoogleFonts.outfit(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Child-Free",
                                      style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),

                              // Last text ON TOP of fade
                              Positioned(
                                left: 8,
                                bottom: 10.h, // slightly above container bottom
                                child: Text(
                                  "Enjoying life without kids",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
                    "Shared interests or hobbies",
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    textAlign: TextAlign.center,
                    "Find people with similar interests",
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8.w),
                    itemCount: 10, // 10 items
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cards per row
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio:
                          196 / 120, // match your card width/height ratio
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 120.h,
                        width: 196.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15.r),
                          image: DecorationImage(
                            image: AssetImage("assets/images/babies.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Fade container behind
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Main content
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                            84,
                                            83,
                                            83,
                                            0.4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            41.7.r,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/profile-2user.png",
                                              height: 18,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              "3k",
                                              style: GoogleFonts.outfit(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "Child-Free",
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),

                            // Last text ON TOP of fade
                            Positioned(
                              left: 8,
                              bottom: 5.h,
                              child: Text(
                                "Enjoying life without kids",
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r), // optional: rounded corners
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(191, 18, 42, 0.8), // semi-transparent red
                            Color.fromRGBO(110, 43, 187, 1), // solid purple
                          ],
                        ),
                      ),
                      child: Text(
                        "Start Matching",
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white, // text color should contrast gradient
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),


                  Text(
                    textAlign: TextAlign.center,
                    "Join thousands of people finding meaningful connections",
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
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
