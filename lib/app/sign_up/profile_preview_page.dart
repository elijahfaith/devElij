import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/bottom_nav/nav.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

class ProfilePreviewPage extends ConsumerStatefulWidget {
  const ProfilePreviewPage({super.key});

  @override
  ConsumerState<ProfilePreviewPage> createState() => _ProfilePreviewPageState();
}

class _ProfilePreviewPageState extends ConsumerState<ProfilePreviewPage> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> allInterests = [
    {"icon": "🎵", "title": "Music"},
    {"icon": "🎬", "title": "Movies"},
    {"icon": "📖", "title": "Reading"},
    {"icon": "🏃‍♂️", "title": "Fitness"},
    {"icon": "🍳", "title": "Cooking"},
    {"icon": "✈️", "title": "Travel"},
    {"icon": "🏊‍♂️", "title": "Swimming"},
    {"icon": "📸", "title": "Photography"},
    {"icon": "🎮", "title": "Gaming"},
    {"icon": "🎨", "title": "Art"},
    {"icon": "🧘‍♀️", "title": "Yoga"},
    {"icon": "🥾", "title": "Hiking"},
    {"icon": "🪴", "title": "Gardening"},
    {"icon": "🎪", "title": "Comedy"},
    {"icon": "🏀", "title": "Sports"},
    {"icon": "🎭", "title": "Theater"},
  ];
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded,

          ),
        ),
        title: Text("Profile Preview", style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700),),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                  height: 350.h,
                  width: double.infinity,
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
                          height: 80.h,
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

                            Spacer(),
                            Text(
                              "Chic Chiffon, 18",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),

                      // Last text ON TOP of fade
                      Positioned(
                        left: 8,
                        bottom: 10.h,
                        child: Row(
                          spacing: 5,
                          children: [
                            Icon(Icons.location_on_rounded, color: Colors.white, size: 20,),
                            Text(
                              "2 km away",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                    SizedBox(height: 20.h),
                    Text(
                      "Interest",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),

                    Chip(
                      side: BorderSide.none,
                      backgroundColor: AppColors.primaryColor,
                      label: Text(
                        "${allInterests[0]['icon']} ${allInterests[0]['title']}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 10.h),
                    Text(
                      "More Photos",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      spacing: 6.w,
                      children: [
                        Expanded(
                          child: Container(
                            height: 130.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.sp),
                              image: DecorationImage(
                                image: AssetImage("assets/images/person.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 130.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.sp),
                              image: DecorationImage(
                                image: AssetImage("assets/images/person.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 130.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.sp),
                              image: DecorationImage(
                                image: AssetImage("assets/images/person.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 10,
                ),
                child: CustomButton(
                  label: "Complete your Profile",
                  fillColor: AppColors.primaryColor,
                  onPressed: () {
                    /// NEXT PAGE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNav(),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  "You can always edit your profile later",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
