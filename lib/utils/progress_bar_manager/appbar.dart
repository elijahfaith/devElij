import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart'; // Import for AppColors

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool centerTitle;
  final String? text;
  bool? displayBack;
  void Function() onTap;
  CustomAppBar({
    super.key,
    required this.centerTitle,
     this.text,
    required this.onTap,
    this.displayBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade50,
      automaticallyImplyLeading: displayBack ?? true,
      centerTitle: centerTitle,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },

        child: Icon(Icons.arrow_back_ios),
      ),

      title: Text(
        text ??"",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
