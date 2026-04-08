import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:link_go/app/bottom_nav/nav_service.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/payment_provider.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/helpers.dart';
import 'package:link_go/utils/storage_util.dart';
import '../../models/Products.dart';
import '../../utils/locator.dart';
import '../widgets/custom_profile_listTIle.dart';
import '../widgets/custom_text_form_field.dart';

class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  late PaymentProvider paymentProvider;
  late NavStateProvider navStateProvider;
  final NavigatorService _navigation = NavigatorService();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {});
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    paymentProvider = ref.watch(RiverpodProvider.paymentProvider);
    navStateProvider = ref.watch(RiverpodProvider.navStateProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 630,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: AssetImage("assets/images/nicegirl.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top row: Profile picture + name/age
                            Row(
                              children: [
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '24,',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tanisha Agrawal,',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Delhi, 11km',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                height: 84.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: Color.fromRGBO(255, 255, 255, 0.2),
                                ),
                                child: Row(
                                  spacing: 5.w,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                            253,
                                            253,
                                            253,
                                            1,
                                          ),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ), // shadow color
                                              spreadRadius:
                                                  1, // how much it spreads
                                              blurRadius:
                                                  4, // how soft the shadow is
                                              offset: const Offset(
                                                0,
                                                2,
                                              ), // horizontal & vertical offset
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(Icons.close, size: 30),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      //  onTap: () => cardController.triggerRight(),
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(101, 55, 212, 1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/images/more.png",
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ), // shadow color
                                              spreadRadius:
                                                  1, // how much it spreads
                                              blurRadius:
                                                  4, // how soft the shadow is
                                              offset: const Offset(
                                                0,
                                                2,
                                              ), // horizontal & vertical offset
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.star,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                            253,
                                            253,
                                            253,
                                            1,
                                          ),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ), // shadow color
                                              spreadRadius:
                                                  1, // how much it spreads
                                              blurRadius:
                                                  4, // how soft the shadow is
                                              offset: const Offset(
                                                0,
                                                2,
                                              ), // horizontal & vertical offset
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(Icons.favorite, size: 30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ), // optional: rounded corners
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(
                          191,
                          18,
                          42,
                          0.8,
                        ), // semi-transparent red
                        Color.fromRGBO(110, 43, 187, 1), // solid purple
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bio",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors
                              .white, // text color should contrast gradient
                        ),
                      ),
                      Text(
                        "Lover of cold coffee, deep convos, and spontaneous weekend trips, If you can beat me at Uno, you win my heart",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors
                              .white, // text color should contrast gradient
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Row(
                        spacing: 10.w,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.r,
                              ), // optional: rounded corners
                              color: Color.fromRGBO(255, 238, 157, 1),
                            ),
                            child: Text(
                              "coffee",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors
                                    .black, // text color should contrast gradient
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.r,
                              ), // optional: rounded corners
                              color: Color.fromRGBO(255, 238, 157, 1),
                            ),
                            child: Text(
                              "cats",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors
                                    .black, // text color should contrast gradient
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.r,
                              ), // optional: rounded corners
                              color: Color.fromRGBO(255, 238, 157, 1),
                            ),
                            child: Text(
                              "R&B",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors
                                    .black, // text color should contrast gradient
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  textAlign: TextAlign.center,
                  "My Interest",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      26.r,
                    ), // optional: rounded corners
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: Text(
                    "cats",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          Colors.black, // text color should contrast gradient
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  textAlign: TextAlign.center,
                  "About me",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      26.r,
                    ), // optional: rounded corners
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: Text(
                    "height 162 cm",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          Colors.black, // text color should contrast gradient
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  textAlign: TextAlign.center,
                  "I am looking for",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      26.r,
                    ), // optional: rounded corners
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: Text(
                    "Long-term Relationship",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          Colors.black, // text color should contrast gradient
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  textAlign: TextAlign.center,
                  "Languages",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      26.r,
                    ), // optional: rounded corners
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: Text(
                    "English",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          Colors.black, // text color should contrast gradient
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            14.r,
                          ), // optional: rounded corners
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(219, 195, 230, 1),
                          ),
                        ),
                        child: Text(
                          "Recommend to a friend ",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors
                                .black, // text color should contrast gradient
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Hide and Report",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors
                              .grey, // text color should contrast gradient
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
