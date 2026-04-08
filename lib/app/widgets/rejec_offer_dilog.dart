import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/models/negotiation_model.dart';
import 'package:link_go/providers/product_provider.dart';

import '../../../models/Products.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_manager.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class RejecOfferDilog extends ConsumerStatefulWidget {
  final NegotiatedProduct product;

  const RejecOfferDilog({super.key, required this.product});

  @override
  ConsumerState<RejecOfferDilog> createState() => _MakeOfferDialogState();
}

class _MakeOfferDialogState extends ConsumerState<RejecOfferDilog> {
  final TextEditingController _offerController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _offerController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    productProvider = ref.watch(RiverpodProvider.productProvider);
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
                    'Reject Offer',
                    style: GoogleFonts.roboto(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
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
                    imageUrl: product.product.images?.isNotEmpty == true
                        ? product.product.images[0]
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
                        product.product.name,
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
                            "₦${product.product.price}",
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
                maxLines: 2,
                hint: 'Send a message to the buyer',
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  final offer = _offerController.text.trim();
                  final message = _messageController.text.trim();
                  productProvider.acceptOffer(context, widget.product.id,
                       message, offer,);
                },
                fillColor: AppColors.primaryColor,
                label: 'Send',
                buttonTextColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
