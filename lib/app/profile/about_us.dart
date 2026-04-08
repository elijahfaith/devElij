import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/progress_bar_manager/utility_app_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
class AboutUs extends ConsumerStatefulWidget {
  const AboutUs({super.key});

  @override
  ConsumerState createState() => _AboutUsState();
}


class _AboutUsState extends ConsumerState<AboutUs> {

  String? version;

  @override
  void initState() {
    super.initState(); // ✅ always call super first
    _getVersion();
  }

  Future<void> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return; // ✅ prevents setState after dispose
    setState(() {
      version = '${info.version}+${info.buildNumber}';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilityAppBar(
        text: "About Us",
        hasActions: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Version ${version ?? "..."}',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                    color: AppColors.grey
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'About',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Tefind is a sustainable fashion marketplace that connects conscious shoppers with pre-loved fashion items. Our mission is to promote sustainable fashion choices and reduce textile waste.',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Company',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Tefind Technologies Limited, Lagos, Nigeria',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h,),
            AboutUsOptions(title:  'Terms of Service',),
            AboutUsOptions(title: 'Privacy Policy',),
            AboutUsOptions(title: 'Community Guidelines',),
            SizedBox(height: 20.h,),
            Center(
              child: Text(
                '© 2025 Tefind. All rights reserved. ',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class AboutUsOptions extends StatelessWidget {
  final String title;
  const AboutUsOptions({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        final linkURL = "https://tefind.com";
        final url = Uri.parse(linkURL);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.inAppWebView);
        } else {
          debugPrint("Could not launch $url");
        }
      },
      child: Container(
        height: 48,
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
