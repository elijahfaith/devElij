import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/product_provider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class Conditions extends ConsumerStatefulWidget {
  const Conditions({super.key});

  @override
  ConsumerState<Conditions> createState() => _ConditionState();
}
class _ConditionState extends ConsumerState<Conditions> {
  late ProductProvider productProvider;
  final Set<String> selectedConditionIds = {};

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Item Condition',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      )),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              SizedBox(height: 10.h),

              productProvider.productCondition.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: productProvider.productCondition.length,
                itemBuilder: (context, index) {
                  final condition = productProvider.productCondition[index];
                  final isSelected = selectedConditionIds .contains(condition.id);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedConditionIds .remove(condition.id);
                        } else {
                          selectedConditionIds .add(condition.id);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.greyLight),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/condition.svg',
                            height: 30,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                condition.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                condition.description,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.lightTextBlack
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            value: isSelected,
                            onChanged: (_) {
                              setState(() {
                                if (isSelected) {
                                  selectedConditionIds .remove(condition.id);
                                } else {
                                  selectedConditionIds .add(condition.id);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () async {
                  print(selectedConditionIds .toList());
                  await productProvider.setMySearchedFilteredProduct(
                    condition: selectedConditionIds .isEmpty
                        ? null
                        : selectedConditionIds .toList(),
                  );
                  productProvider.markSearchFilterAsApplied();
                  Navigator.pop(context);
                },
                label: 'Apply',
                fillColor: AppColors.primaryColor,
                buttonTextColor: Colors.white,
              )

            ],
          ),
        ),
      ),
    );
  }
}

