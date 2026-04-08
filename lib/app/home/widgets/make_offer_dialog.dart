import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/utils/helpers.dart';

import '../../../models/Products.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

class MakeOfferDialog extends ConsumerStatefulWidget {
  final Products? product;

  const MakeOfferDialog({super.key, required this.product});

  @override
  ConsumerState<MakeOfferDialog> createState() => _MakeOfferDialogState();
}

class _MakeOfferDialogState extends ConsumerState<MakeOfferDialog> {
  final TextEditingController _offerController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _offerController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  late ProductProvider productProvider;
  double getMinimumOffer(double price) {
    return (price * 0.7);
  }

  bool isOfferValid(double price, double offer) {
    return offer >= getMinimumOffer(price);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    productProvider = ref.watch(RiverpodProvider.productProvider);
    final minOffer = widget.product != null
        ? getMinimumOffer(widget.product!.price!.toDouble())
        : 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Ensure dialog is scrollable on small screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Make an Offer',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: product?.images?.isNotEmpty == true
                        ? product?.images[0] ?? ""
                        : "",
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      height: 60.h,
                      width: 60.w,
                      child: Center(
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(185.r),
                      child: Image.asset(
                        Assets.laptopPowerbank,
                        height: 60.h,
                        width: 60.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.name ?? "",
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Listed Price: ",
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey),
                          ),
                          Text(
                            "₦${product?.price}",
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                'Your Offer (₦)',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 11),
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: _offerController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(249, 250, 251, 1),
                  hintStyle: GoogleFonts.roboto(
                      color: AppColors.grey, fontSize: 12.sp),
                  hintText: 'Enter amount in Naira',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.grey),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'You cannot negotiate less than ₦${minOffer.toStringAsFixed(0)} (70% of the actual price)',
                style: GoogleFonts.roboto(
                  color: AppColors.warningRed,
                  fontWeight: FontWeight.w500,
                  fontSize: 8.sp,
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Minimum: ₦45,000",
              //       style: TextStyle(
              //         fontSize: 12.sp,
              //         color: AppColors.grey,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 5.h),
              Text(
                'Message',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                controller: _messageController,
                maxLines: 3,
                hint: 'Add a Message to the seller...',
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  final offerText = _offerController.text.trim();
                  final message = _messageController.text.trim();

                  // Check if either field is empty
                  if (offerText.isEmpty || message.isEmpty) {
                    showErrorToast(message: "Amount and Message are required");
                    return;
                  }

                  // Parse offer
                  final offer = double.tryParse(offerText);
                  if (offer == null) {
                    showErrorToast(
                        message: "Please enter a valid numeric amount");
                    return;
                  }

                  final price = widget.product?.price?.toDouble() ?? 0;
                  if (!isOfferValid(price, offer)) {
                    final minOffer = getMinimumOffer(price);
                    showErrorToast(
                        message:
                            "Offer cannot be less than ₦${minOffer.toStringAsFixed(0)}");
                    return;
                  }
                  productProvider.negotiateProduct(
                    context,
                    widget.product?.id ?? "",
                    message,
                    offerText,
                  );
                },
                fillColor: AppColors.primaryColor,
                label: 'Send Offer',
                buttonTextColor: AppColors.white,
              ),

              // CustomButton(
              //   onPressed: () {
              //     final offer = _offerController.text.trim();
              //     final message = _messageController.text.trim();
              //     productProvider.negotiateProduct(
              //         context, widget.product?.id ?? "", message, offer);
              //   },
              //   fillColor: AppColors.primaryColor,
              //   label: 'Send Offer',
              //   buttonTextColor: AppColors.white,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
