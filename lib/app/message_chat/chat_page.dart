import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/utils/app_colors.dart';

class ChatPage extends ConsumerStatefulWidget {
  final ScrollController? scrollController;

  ChatPage({Key? key, this.scrollController}) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
  final NavigatorService _navigation = NavigatorService();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {});
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// ---------------------- HEADER ----------------------
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  ),
                  SizedBox(width: 10.w),

                  /// Avatar
                  Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/person.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  /// Name + Online
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jessica Drew",
                        style: GoogleFonts.manrope(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Online",
                        style: GoogleFonts.manrope(
                          color: Colors.grey,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  /// Icons
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/Vector.svg"),
                      SizedBox(width: 12.w),
                      SvgPicture.asset("assets/images/Vector (1).svg"),
                    ],
                  ),
                ],
              ),
            ),

            /// ---------------------- CHAT LIST ----------------------
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Date bubble
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          "Today",
                          style: GoogleFonts.manrope(
                            color: Colors.black87,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// ------------------- RECEIVED MESSAGE -------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// avatar
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/person.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        /// message bubble
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(18),
                                topLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OMG 😳 do you remember what you did last night at the work night out?",
                                  style: GoogleFonts.manrope(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "18:12",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),

                    /// ------------------- SENT MESSAGE -------------------
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(14),
                        width: 260.w,
                        decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "no haha",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "18:16",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(14),
                        width: 260.w,
                        decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "i don’t remember anything 😁",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "18:16",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// ------------------- RECEIVED LAST MESSAGE -------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/person.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              topLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lets connect",
                                style: GoogleFonts.manrope(
                                  fontSize: 15.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "18:12",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            /// ---------------------- INPUT BAR ----------------------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    // Emoji icon
                    SvgPicture.asset(
                      "assets/images/Emoji Icon.svg",
                      height: 24.h,
                    ),
                    SizedBox(width: 10),

                    // Text field
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    SizedBox(width: 10),
                    // Gift icon
                    Image.asset(
                      'assets/images/Gift 1.png',
                      height: 24.h,
                    ),
                    SizedBox(width: 10),
                    // Send icon
                    GestureDetector(
                      onTap: () {
                        // Handle send
                      },
                      child: SvgPicture.asset(
                        "assets/images/Send Icon.svg",
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
