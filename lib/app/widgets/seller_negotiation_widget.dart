import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:link_go/app/widgets/rejec_offer_dilog.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/utils/toTitleCase.dart';
import '../../models/negotiation_model.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../../utils/helpers.dart';
import '../widgets/custom_button.dart';

class SellerNegotiationWidget extends ConsumerStatefulWidget {
  final NegotiatedProduct products;

  const SellerNegotiationWidget({
    super.key,
    required this.products,
  });

  @override
  ConsumerState<SellerNegotiationWidget> createState() =>
      _SellerNegotiationWidgetState();
}

late AccountProvider accountProvider;
String formatYearDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return "";

  try {
    DateTime date = DateTime.parse(dateString);
    return DateFormat("MMMM d, yyyy").format(date); // e.g. August 1, 2025
  } catch (e) {
    return "";
  }
}

class _SellerNegotiationWidgetState
    extends ConsumerState<SellerNegotiationWidget> {
  late ProductProvider productProvider;
  void _acceptOrder(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/sucessListing.svg'),
                SizedBox(height: 10.h),
                Text(
                  'Order Approved',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Container(
                      height: 64.h,
                      width: 64.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/cloth.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Floral Summer Dress',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Quantity: 1',
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          '₦22,500',
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #ORD-2025052502",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.lightTextBlack,
                      ),
                    ),
                    Text(
                      'May 25, 2025',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.lightTextBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  fillColor: AppColors.primaryColor,
                  label: 'Send Package',
                  buttonTextColor: AppColors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                // imageUrl:
                //     widget.newProducts.imageUrls?[0].localUrl ?? "",
                imageUrl: widget.products.buyer.image?.isNotEmpty ?? false
                    ? widget.products.buyer.image ?? ""
                    : "",
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    height: 48.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2.w, color: AppColors.primaryColor),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: 48.w, // 50.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
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
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    height: 48.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2.w, color: AppColors.primaryColor),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 30.w,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '@${widget.products.buyer.username}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              // // if(widget.products.seller.id == widget.products.buyer.id)
              // if(widget.products.buyer.id != widget.products.seller.id)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2),
                decoration: BoxDecoration(
                  color: widget.products.status == "rejected"
                      ? Colors.red
                      : AppColors.lightYellow,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    '${widget.products.status.toTitleCase() ?? ""}',
                    style: GoogleFonts.roboto(
                      color: widget.products.status == "rejected"
                          ? Colors.white
                          : AppColors.orange,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),

          /// Offer message
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            // height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.greyLight2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.products.messages.map((msg) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (msg.senderType != 'seller')
                          Text(
                            "${msg.senderType.toUpperCase()} ₦${msg.offeredPrice}",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            msg.comment,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: msg.senderType != 'buyer'
                                  ? AppColors.primaryColor
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Original:",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          currencyFormat.format(double.parse(
                              widget.products.product.price.toString() ?? '0')),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Offered:",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.grey,
                          ),
                        ),

                        // change the seller to seller in the apii
                        // work on accepot anad reject and counter
                        // ensure the flow works accordingly
                        // enhance to beautiful UIUX
                        Text(
                          currencyFormat.format(double.parse(widget
                                  .products.messages.first.offeredPrice
                                  .toString() ??
                              '0')),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),

          /// Product details & actions
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            //height: 189.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          widget.products.product.images.isNotEmpty ?? false
                              ? widget.products.product.images[0] ?? ''
                              : "",
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          height: 64.h,
                          width: 64.w,
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
                    SizedBox(width: 5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.products.product.name}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          currencyFormat.format(double.parse(
                              widget.products.product.price.toString() ?? '0')),
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   'Order #ORD-2025052601',
                    //   style: GoogleFonts.roboto(
                    //     color: AppColors.grey,
                    //     fontSize: 14.sp,
                    //   ),
                    // ),
                    Text(
                      '${formatYearDate("${widget.products.messages.first.createdAt ?? ""}")}',
                      style: GoogleFonts.roboto(
                        color: AppColors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                if (widget.products.status != "rejected" &&
                    widget.products.status != "accepted") ...[
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  RejecOfferDilog(product: widget.products),
                            );
                          },
                          label: 'Decline',
                          buttonTextColor: Colors.black,
                          fillColor: AppColors.greyLight,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: CustomButton(
                          onPressed: () => productProvider.acceptOffer(
                            context,
                            widget.products.id,
                            "I accept the price the negotiated price for this product",
                            widget.products.messages.first.offeredPrice
                                .toString(),
                          ), // _acceptOrder(context),
                          label: 'Accept',
                          buttonTextColor: Colors.white,
                          fillColor: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
