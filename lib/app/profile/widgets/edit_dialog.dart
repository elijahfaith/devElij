import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_go/utils/helpers.dart';
import '../../../models/state_model.dart';
import '../../../providers/account_provider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({super.key});

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}



class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  late AccountProvider accountProvider;
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController userName = TextEditingController();

  // Example state
  String? dp;
  String? dpName;
  takePicture() async {
    final imagePicker = ImagePicker();
    File file = File(await imagePicker
        .pickImage(
          source: ImageSource.gallery,
        )
        .then((pickedFile) => pickedFile!.path));
    setState(() {
      dp = file.path;
      dpName = file.path.split('/').last;
    });
    accountProvider.updateUserprofileImage(dp, dpName);
  }

  @override
  void initState() {
    Future.microtask(() async{
  accountProvider.updateUserFirstNameController.text =
          accountProvider.currentUser.firstname ?? '';
      accountProvider.updateUserLastNameController.text =
          accountProvider.currentUser.lastname ?? '';
      emailController.text =
          accountProvider.currentUser.email ?? '';
      phoneNumber.text = accountProvider.currentUser.phoneNumber ?? '';
      userName.text = accountProvider.currentUser.username ?? '';
      accountProvider.updateUserBioController.text = accountProvider.currentUser.bio ?? '';
      accountProvider.updateUserAddressController.text = accountProvider.currentUser.address ?? '';
      accountProvider.updateUserCityController.text = accountProvider.currentUser.city ?? '';
      await accountProvider.getState();
      final matchedState = accountProvider.state.firstWhere(
            (s) => s.name.toLowerCase() == (accountProvider.currentUser.state ?? '').toLowerCase(),
      );
           accountProvider.selectedBasicState = matchedState;
      accountProvider.getState();
      accountProvider.getUserProfile();

    });

    super.initState();
  }

  @override
  void dispose() {
    accountProvider.updateUserFirstNameController.clear();
    //accountProvider.selectedBasicState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    // print(accountProvider.currentUser.location?.coordinates?[0]);
    // print('am printing both coordinates');
    // print(accountProvider.currentUser.location?.coordinates?[1]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style:
              GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 72.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: AppColors.primaryColor,
                          ),
                          // color: dp == null ? ColorThemes.cyan : null,
                          image: dp != null
                              ? DecorationImage(
                                  image: FileImage(File(dp!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: dp == null
                            ? Center(
                                child: Text(
                                  accountProvider.currentUser.lastname!.isNotEmpty
                                      ? accountProvider.currentUser.lastname![0]
                                          .toUpperCase()
                                      : '',
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            takePicture();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: Colors.white),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Tap to change profile photo',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildLabel('First Name'),
            // _buildLabel(accountProvider.currentUser.location?.coordinates?[0].toString()??""),
            // _buildLabel(accountProvider.currentUser.location?.coordinates?[1].toString()??""),
            const SizedBox(height: 5),
            CustomTextFormField(
             //s enable: false,
                controller: accountProvider.updateUserFirstNameController,
                hint: 'Enter your first name'),
            const SizedBox(height: 10),
            _buildLabel('Last Name'),
            const SizedBox(height: 5),
            CustomTextFormField(
                controller: accountProvider.updateUserLastNameController,
                hint: 'Enter your last name'),
            const SizedBox(height: 10),
            _buildLabel('Username'),
            const SizedBox(height: 5),
            CustomTextFormField(
                controller: userName,
                enable: false,
            ),

            const SizedBox(height: 10),
            _buildLabel('Email'),
            const SizedBox(height: 5),
            CustomTextFormField(
              controller: emailController,
                enable: false,
                hint: ''),
            const SizedBox(height: 10),
            _buildLabel('Phone Number'),
            const SizedBox(height: 5),
            CustomTextFormField(
              controller: phoneNumber,
                enable: false,
                hint: ''),
            const SizedBox(height: 10),
            _buildLabel('Bio'),
            const SizedBox(height: 5),
            CustomTextFormField(
              maxLines: 3,
              controller: accountProvider.updateUserBioController,
              hint: "Enter your Bio",
              // validator: Validators().isSignUpEmpty,
            ),
            const SizedBox(height: 10),
            _buildLabel('Address'),
            const SizedBox(height: 5),
            CustomTextFormField(
                onTap: () {
                  print('i press something');
                  accountProvider
                      .showUserAddressPicker(accountProvider);
                },
                controller: accountProvider.updateUserAddressController,
                hint: '',
                maxLines: 2),
            const SizedBox(height: 10),
            if(accountProvider.updateUserAddressController.text.isNotEmpty)...[
            _buildLabel('City'),
            const SizedBox(height: 5),
            CustomTextFormField(
              controller: accountProvider.updateUserCityController,
                hint: ''),
            const SizedBox(height: 10),
            _buildLabel('State'),
            const SizedBox(height: 5),
            DropdownButtonFormField<StateModel>(
              onTap: () {
              },
              value: accountProvider.selectedBasicState,
              isExpanded: true,
              iconEnabledColor: AppColors.lightTextBlack,
              dropdownColor: AppColors.white,
              items: accountProvider.state
                  .map<DropdownMenuItem<StateModel>>(
                    (StateModel state) {
                  return DropdownMenuItem<StateModel>(
                    value: state,
                    child: Text(
                      state.name,
                      style: GoogleFonts.roboto(color: AppColors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ).toList(),
              onChanged: (StateModel? newValue) async {
                if (newValue != null) {
                  accountProvider.selectedBasicState = newValue;

                }
              },
              decoration: InputDecoration(
                hintText: "State",
                isDense: true,
                fillColor: AppColors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greyLight,
                    width: 0.2.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greyLight,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greyLight,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.greyLight,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                hintStyle: GoogleFonts.roboto(
                  color: AppColors.greyLight,
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              label: 'Save Change',
              fillColor: AppColors.primaryColor,
              onPressed: () async {
                bool success = await accountProvider.updateUser();
                if (success) {
                  Navigator.pop(context);
                  accountProvider.selectedBasicState = null;
                }
              },
            ),
            ],
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14),
    );
  }
}
