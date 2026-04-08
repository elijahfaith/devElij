import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/bottom_nav/nav_service.dart';
import 'package:link_go/app/home/home_page.dart';
import 'package:link_go/app/profile/profile_page.dart';
import '../message_chat/all_messages.dart';
import '../search/search_page.dart';
import '../match_screen/swipper-screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    CardSwiperScreen(),
    AllMessages(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: const Color(0x1A000000),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: Colors.black,
          elevation: 0,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem("home", 'Home', 0),
                _buildNavItem("discover", 'Discovery', 1),
                const SizedBox(width: 40), // Space for FAB
                _buildNavItem("like-tag", 'Message', 3),
                _buildNavItem("profile-circle", 'Profile', 4),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x4D5B4FE8),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(2),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(child: Image.asset("assets/images/lovely 2.png", height: 30.h,)),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(String imagePath, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ?  Colors.red : Colors.grey;

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           Image.asset("assets/images/$imagePath.png", height: 20.h,),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: color,
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
