import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/sign_up/location_enabling.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/app/widgets/custom_button.dart';
import 'package:link_go/utils/progress_bar_manager/appbar.dart';

class YourInterestTopics extends ConsumerStatefulWidget {
  const YourInterestTopics({super.key});

  @override
  ConsumerState<YourInterestTopics> createState() => _YourInterestTopicsState();
}

class _YourInterestTopicsState extends ConsumerState<YourInterestTopics> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // selected gender option
  String? selectedGender;

  final TextEditingController _searchCtrl = TextEditingController();

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

  List<Map<String, String>> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filtered = allInterests
        .where((i) => i['title']!
        .toLowerCase()
        .contains(_searchCtrl.text.toLowerCase()))
        .toList();
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: CustomAppBar(centerTitle: false, onTap: () {}),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/interest.png", height: 30.h,),

                    SizedBox(height: 10.h),
                    Text(
                      "Your interests",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Choose up to 10 things you love',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchCtrl,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selected: ${selectedInterests.length}/10",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => selectedInterests.clear()),
                          child: const Text(
                            "Clear All",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedInterests
                          .map(
                            (i) => Chip(
                          side: BorderSide.none,
                          backgroundColor: AppColors.primaryColor,
                          label: Text(
                            "${i['icon']} ${i['title']}",
                            style: const TextStyle(color: Colors.black),
                          ),
                          ///deleteIcon: const Icon(Icons.close, color: Colors.white),
                          // onDeleted: () {
                          //   setState(() => selectedInterests.remove(i));
                          // },
                        ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Available",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        children: filtered.map((i) {
                          bool isSelected = selectedInterests.contains(i);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedInterests.remove(i);
                                } else {
                                  if (selectedInterests.length < 10) {
                                    selectedInterests.add(i);
                                  }
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                              ),
                              child: Text(
                                "${i['icon']} ${i['title']}",
                                style: TextStyle(
                                  color:
                                  isSelected ? Colors.white : Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.all(20),
                child: CustomButton(
                  label: "Continue (${selectedInterests.length} selected)",
                  fillColor: AppColors.primaryColor,
                  onPressed: () {
                    /// NEXT PAGE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationEnabling(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}