import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:scrumlab_flutter_tindercard/scrumlab_flutter_tindercard.dart';

import 'lover_match_screen.dart';

// ---------------------- Data Model ----------------------
class Profile {
  final String name;
  final int age;
  final String distance;
  final String location;
  final String imageUrl;

  Profile({
    required this.name,
    required this.age,
    required this.distance,
    required this.location,
    required this.imageUrl,
  });
}

final List<Profile> dummyProfiles = [
  Profile(
    name: "Alice",
    age: 25,
    distance: "5 km away",
    location: "Aquarius",
    imageUrl: "assets/images/person.jpg",
  ),
  Profile(
    name: "Bob",
    age: 28,
    distance: "10 km away",
    location: "Aquarius",
    imageUrl: "assets/images/person.jpg",
  ),
  Profile(
    name: "Charlie",
    age: 23,
    distance: "2 kmn away",
    location: "Aquarius",
    imageUrl: "assets/images/person.jpg",
  ),
  Profile(
    name: "Diana",
    age: 30,
    distance: "8 km away",
    location: "Aquarius",
    imageUrl: "assets/images/person.jpg",
  ),
];
// -------------------------------------------------------

class CardSwiperScreen extends StatefulWidget {
  const CardSwiperScreen({super.key});

  @override
  State<CardSwiperScreen> createState() => _CardSwiperScreenState();
}

class _CardSwiperScreenState extends State<CardSwiperScreen>
    with TickerProviderStateMixin {
  // Controller for programmatic swiping
  CardController cardController = CardController();

  Widget _buildProfileCard(Profile profile) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(profile.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
          child: Column(
            children: [
              const Spacer(), // Push content to the bottom
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 25,
                  ), // Frost effect
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 20.h,
                    ),
                    color: Colors.black.withOpacity(
                      0.3,
                    ), // Semi-transparent overlay
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: Profile picture + name/age
                        Row(
                          children: [
                            Container(
                              height: 46.h,
                              width: 46.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/person.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 9.w,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${profile.name}, ${profile.age}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                        horizontal: 10.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Row(
                                        spacing: 5.w,
                                        children: [
                                          Container(
                                            height: 8.h,
                                            width: 8.w,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Text(
                                            "Online",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      profile.distance,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(
                                      Icons.flag,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      profile.location,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // Bottom row: Floating action buttons
                        Center(
                          child: Container(
                            height: 84.h,
                            width: 230.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Color.fromRGBO(255, 255, 255, 0.2),
                            ),
                            child: Row(
                              spacing: 5.w,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () => cardController.triggerLeft(),

                                child: Container(
                                    height: 58.h,
                                    width: 58.w,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.2),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            0.2,
                                          ), // shadow color
                                          spreadRadius: 1, // how much it spreads
                                          blurRadius: 4, // how soft the shadow is
                                          offset: const Offset(
                                            0,
                                            2,
                                          ), // horizontal & vertical offset
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/cancel.png",
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () => cardController.triggerRight(),

                                child: Container(
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/hh.png",
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () => debugPrint('Details'),

                                child: Container(
                                    height: 58.h,
                                    width: 58.w,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.2),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            0.2,
                                          ), // shadow color
                                          spreadRadius: 1, // how much it spreads
                                          blurRadius: 4, // how soft the shadow is
                                          offset: const Offset(
                                            0,
                                            2,
                                          ), // horizontal & vertical offset
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/message.svg",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 2.w),
              child: Row(
                children: [
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
                        "Hi, 👋💓💝",
                        style: GoogleFonts.manrope(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Jack Ryder",
                        style: GoogleFonts.manrope(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Spacer(),

                  /// Icons
                  Row(
                    children: [
                      //  SvgPicture.asset("assets/images/Vector.svg"),
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.2,
                              ), // shadow color
                              spreadRadius: 1, // how much it spreads
                              blurRadius: 4, // how soft the shadow is
                              offset: const Offset(
                                0,
                                2,
                              ), // horizontal & vertical offset
                            ),
                          ],
                        ),
                        child: Icon(Icons.notifications),
                      ),

                      SizedBox(width: 12.w),
                      Icon(Icons.more_vert_rounded),
                    ],
                  ),
                ],
              ),
            ),
            // ---------------- Card Swiping Area ----------------
            SizedBox(
              height: size.height * 0.70,
              child: TinderSwapCard(
                orientation: AmassOrientation.bottom,
                totalNum: dummyProfiles.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: size.width * 0.9,
                maxHeight: size.height * 0.65,
                minWidth: size.width * 0.8,
                minHeight: size.height * 0.55,
                cardBuilder: (context, index) {
                  return _buildProfileCard(dummyProfiles[index]);
                },
                cardController: cardController,
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {},
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                      if (orientation == CardSwipeOrientation.left) {
                        debugPrint(
                          'Card ${dummyProfiles[index].name} disliked!',
                        );
                      } else if (orientation == CardSwipeOrientation.right) {
                        debugPrint('Card ${dummyProfiles[index].name} liked!');
                      }
                      if (index == dummyProfiles.length - 1) {
                        // Navigate to another screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (
                                context) => const LoverMatchScreen(), // replace with your screen
                          ),
                        );
                      };
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
