import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/storage/bank_model.dart';
import '../../../utils/app_colors.dart';

class BankSelectorField extends StatelessWidget {
  final BankModel? selectedBank;
  final VoidCallback onTap;

  const BankSelectorField({
    Key? key,
    required this.selectedBank,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: "Select Bank",
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          selectedBank?.name ?? 'Select Bank',
          style: GoogleFonts.roboto(
            color: selectedBank == null ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}
