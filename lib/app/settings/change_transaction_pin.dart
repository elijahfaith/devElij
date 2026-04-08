import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/progress_bar_manager/utility_app_bar.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../services/navigation/navigator_service.dart';
import '../../utils/helpers.dart';
import '../widgets/custom_button.dart';
import '../widgets/pin_input_field.dart';

class ChangeTransactionPin extends ConsumerStatefulWidget {
  const ChangeTransactionPin({super.key});

  @override
  ConsumerState createState() => _ChangeTransactionPinState();
}

class _ChangeTransactionPinState extends ConsumerState<ChangeTransactionPin> {
  late AccountProvider accountProvider;
  TextEditingController oldPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();

  void completeTransactionPIN() {
    // if (_formKey.currentState?.validate() ?? false) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Center(
                  child: Text(
                "Transaction PIN\nSuccessfully Created",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700),
              )),
            ],
          ),
          content: Text(
            "You can now carry out transactions with your TeFind account.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          actions: [
            CustomButton(
              fillColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pop(context);
                NavigatorService().navigateReplacementTo(bottomNavigationRoute);
              },
              label: "Done",
            ),
            SizedBox(
              height: 60.h,
            ),
          ],
        );
      },
    );
    //}
  }

  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);
  void _updateButtonState() {
    final isOldPinComplete = oldPinController.text.length == 4;
    final isNewPinComplete = accountProvider.newPinController.text.length == 4;
    _isButtonEnabled.value = isOldPinComplete && isNewPinComplete;
  }

  @override
  void initState() {
    Future.microtask(() {
      oldPinController.addListener(_updateButtonState);
      accountProvider.newPinController.addListener(_updateButtonState);
      _updateButtonState();
    });
    super.initState();
  }

  @override
  void dispose() {
    oldPinController.clear();
    accountProvider.newPinController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        text: 'Change Transaction PIN',
        hasActions: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Old Pin",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 30.h,
              ),
              // Text("Input Transaction PIN", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey,)),
              // SizedBox(height: 10.h,),
              PinInputField(
                obscure: true,
                pinController: oldPinController,
                pinNumber: 4,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "New Pin",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              // Text("Input Transaction PIN", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey,)),
              // SizedBox(height: 10.h,),
              PinInputField(
                obscure: true,
                pinController: accountProvider.newPinController,
                pinNumber: 4,
              ),
              SizedBox(
                height: 120.h,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isButtonEnabled,
                builder: (context, isEnabled, _) {
                  return CustomButton(
                    label: "Change",
                    fillColor: isEnabled ? AppColors.primaryColor : Colors.grey,
                    onPressed: isEnabled
                        ? () {
                            accountProvider.changeTransactionPin(
                                oldPinController.text, accountProvider.newPinController.text);
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
