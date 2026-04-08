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
import 'chat_page.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class AllMessages extends ConsumerStatefulWidget {
  final ScrollController? scrollController;

  AllMessages({Key? key, this.scrollController}) : super(key: key);

  @override
  ConsumerState<AllMessages> createState() => _AllMessagesState();
  final NavigatorService _navigation = NavigatorService();
}

class _AllMessagesState extends ConsumerState<AllMessages> {
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ), // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      // backgroundColor: Color(0xFAFAFA),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {},
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 15.h,
                top: 20.h,
                left: 15.w,
                right: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/linkgo_text_logo.png",
                        height: 25.h,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/coins.png", height: 40.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 5.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "400 coins",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Chats",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  TextField(
                    // controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "Search for profiles",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));
                    },
                    child: Row(
                      spacing: 5.w,
                      children: [
                        Container(
                          height: 56.h,
                          width: 56.w,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/person.jpg"),
                            ),
                          ),
                        ),
                        Column(
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
                              "Ok, see you later",
                              style: GoogleFonts.manrope(
                                color: Colors.black87,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "18:30",
                              style: GoogleFonts.manrope(
                                color: Colors.black87,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "2",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
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
