import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/utils/progress_bar_manager/utility_app_bar.dart';

import '../../models/Products.dart';
import '../../services/navigation/navigator_service.dart';
import '../../services/navigation/route_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../../utils/helpers.dart';
import '../message_chat/chat_page.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late ProductProvider productProvider;

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    final hasSearch = _searchController.text.trim().isNotEmpty;
    // final hasFilter =  productProvider.searchedFilteredProducts != null &&
    //     productProvider.searchedFilteredProducts!.isNotEmpty;
    // ;
    final hasFilterApplied = productProvider.isSearchFilterApplied;
    final hasFilterResults =
        productProvider.searchedFilteredProducts?.isNotEmpty ?? false;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 15.h,
            top: 50.h,
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
                "Recommendations",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // MAIN IMAGE WITH DARK OVERLAY
                  Container(
                    height: 92.h, // slightly larger than inner
                    width: 92.w,
                    padding: EdgeInsets.all(3), // thickness of gradient border
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(141, 241, 255, 1),
                          Color.fromRGBO(255, 67, 187, 1),
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/person.jpg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.35), // darken image
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // NOTIFICATION BADGE
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/indivmessage.png",
                          height: 25,
                        ),
                      ),
                    ),
                  ),

                  // NAME
                  Positioned(
                    left: 30,
                    bottom: 20,
                    child: Text(
                      "AIKO",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  // HEAR HER VOICE → GRADIENT BORDER + INNER CONTAINER
                  Positioned(
                    bottom: -13,
                    child: Container(
                      padding: EdgeInsets.all(2), // border thickness
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      child: Container(
                        height: 28.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(84, 83, 83, 0.4),
                          borderRadius: BorderRadius.circular(60.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/voice.png", height: 16),
                            SizedBox(width: 5.w),
                            Text(
                              "Hear her Voice",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),
              Text(
                "Explore  🔎",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              MasonryGridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 12,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                padding: EdgeInsets.all(16),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    height: index.isEven ? 200 : 230, // uneven heights
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.pink.shade200,
                      image: DecorationImage(
                        image: AssetImage("assets/images/person.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/indivmessage.png",
                                  height: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),

                        Text(
                          "45.9k Chats",
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(84, 83, 83, 0.4),
                            borderRadius: BorderRadius.circular(41.7.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,   // <-- THIS makes it wrap content
                            children: [
                              Icon(Icons.favorite_border, color: Colors.white, size: 16),
                              SizedBox(width: 5.w),
                              Text(
                                "Hear her Voice",
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  );
                },
              ),

              // Column(
              //   children: [
              //     Text(
              //       "Jessica Drew",
              //       style: GoogleFonts.manrope(
              //         color: Colors.black87,
              //         fontSize: 16.sp,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     Text(
              //       "Ok, see you later",
              //       style: GoogleFonts.manrope(
              //         color: Colors.black87,
              //         fontSize: 13.sp,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              // Spacer(),
              // Column(
              //   children: [
              //     Text(
              //       "18:30",
              //       style: GoogleFonts.manrope(
              //         color: Colors.black87,
              //         fontSize: 16.sp,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     Container(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 10,
              //         vertical: 10,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Colors.red,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Text(
              //         "2",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterOptions extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onTap;
  const FilterOptions({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/$image.svg'),
            SizedBox(width: 5.h),
            Text(
              title,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 5.h),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 15,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
