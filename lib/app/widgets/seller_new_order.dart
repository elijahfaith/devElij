// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:link_go/models/seller_order_model.dart';
// import 'package:link_go/providers/account_provider.dart';
// import 'package:link_go/utils/toTitleCase.dart';
//
// import '../../models/negotiation_model.dart';
// import '../../providers/product_provider.dart';
// import '../../providers/provider.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/assets_manager.dart';
// import '../../utils/helpers.dart';
// import '../home/widgets/make_offer_dialog.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/custom_text_form_field.dart';
//
// class SellerNewOrder extends ConsumerStatefulWidget {
//   final SellerOrderItem? products;
//   final SellerOrderModel parent;
//
//   const SellerNewOrder({
//     super.key,
//     required this.products,
//     required this.parent,
//   });
//
//   @override
//   ConsumerState<SellerNewOrder> createState() => _SellerNewOrderState();
// }
//
// String formatYearDate(String? dateString) {
//   if (dateString == null || dateString.isEmpty) return "";
//
//   try {
//     DateTime date = DateTime.parse(dateString);
//     return DateFormat("MMMM d, yyyy").format(date); // e.g. August 1, 2025
//   } catch (e) {
//     return "";
//   }
// }
//
// final TextEditingController _offerController = TextEditingController();
// final TextEditingController _messageController = TextEditingController();
//
// class _SellerNewOrderState extends ConsumerState<SellerNewOrder> {
//   late AccountProvider accountProvider;
//   late ProductProvider productProvider;
//
//   @override
//   Widget build(BuildContext context) {
//     accountProvider = ref.watch(RiverpodProvider.accountProvider);
//     productProvider = ref.watch(RiverpodProvider.productProvider);
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Header
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CachedNetworkImage(
//                 imageUrl:
//                 widget.parent?.user?.imagePath?.isNotEmpty ?? false
//                     ? widget.parent.user.imagePath ?? ""
//                     : "",
//                 imageBuilder: (context, imageProvider) => ClipRRect(
//                   borderRadius: BorderRadius.circular(15.r),
//                   child: Container(
//                     height: 48.h,
//                     width: 48.w,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border:
//                       Border.all(width: 2.w, color: AppColors.primaryColor),
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 placeholder: (context, url) => Container(
//                   width: 48.w, // 50.w,
//                   height: 48.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: SizedBox(
//                       width: 30.w,
//                       height: 30.h,
//                       child: const CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => ClipRRect(
//                   borderRadius: BorderRadius.circular(15.r),
//                   child: Container(
//                     height: 48.h,
//                     width: 48.w,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border:
//                       Border.all(width: 2.w, color: AppColors.primaryColor),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.grey,
//                         size: 30.w,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               Text(
//                 '@${widget.parent.user.username}',
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: widget.products?.status == "rejected"
//                       ? Colors.red
//                       : AppColors.lightYellow,
//                   borderRadius: BorderRadius.circular(26.r),
//                 ),
//                 child: Center(
//                   child: Text(
//                     '${widget.products?.status.toTitleCase() ?? ""}',
//                     style: GoogleFonts.roboto(
//                       color: widget.products?.status == "rejected"
//                           ? Colors.white
//                           : AppColors.orange,
//                       fontSize: 11.sp,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10.h),
//
//           /// Product details & actions
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10.w),
//             //height: 189.h,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     CachedNetworkImage(
//                       imageUrl:
//                       widget.products?.product.images.isNotEmpty ?? false
//                           ? widget.products?.product.images[0] ?? ''
//                           : "",
//                       imageBuilder: (context, imageProvider) => ClipRRect(
//                         borderRadius: BorderRadius.circular(8.r),
//                         child: Container(
//                           height: 64.h,
//                           width: 64.w,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       placeholder: (context, url) => Container(
//                         height: 60.h,
//                         width: 60.w,
//                         child: Center(
//                           child: SizedBox(
//                             width: 30.w,
//                             height: 30.h,
//                             child: const CircularProgressIndicator(
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => ClipRRect(
//                         borderRadius: BorderRadius.circular(185.r),
//                         child: Image.asset(
//                           Assets.laptopPowerbank,
//                           height: 60.h,
//                           width: 60.w,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10.w),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${widget.products?.product.name.toTitleCase()}',
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.roboto(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           currencyFormat.format(double.parse(
//                               widget.products?.product.price.toString() ?? '0')),
//                           style: GoogleFonts.roboto(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Order ${widget.parent.orderNumber.toString()??""}',
//                       style: GoogleFonts.roboto(
//                         color: AppColors.grey,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                     Text(
//                       '${formatDate("${widget.parent.createdAt}")}',
//                       style: GoogleFonts.roboto(
//                         color: AppColors.grey,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10.h),
//                 if (widget.products?.price != 2 && widget.products?.status != "accepted") ...[
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomButton(
//                           onPressed: () {
//
//                           },
//                           label: 'Decline',
//                           buttonTextColor: Colors.black,
//                           fillColor: AppColors.greyLight,
//                         ),
//                       ),
//                       SizedBox(width: 5.w),
//
//                       Expanded(
//                         child: CustomButton(
//                           onPressed:(){},
//                           label: 'Accept',
//                           buttonTextColor: Colors.white,
//                           fillColor: AppColors.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:link_go/models/seller_order_model.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/utils/toTitleCase.dart';

import '../../models/negotiation_model.dart';
import '../../providers/product_provider.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../../utils/helpers.dart';
import '../home/widgets/make_offer_dialog.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

enum ProductDecision { none, accepted, rejected }

class SellerNewOrder extends ConsumerStatefulWidget {
  final SellerOrderItem? products;
  final SellerOrderModel parent;
  final Map<String, ProductDecision> decisionMap;

  const SellerNewOrder({
    super.key,
    required this.products,
    required this.parent,
    required this.decisionMap,
  });

  @override
  ConsumerState<SellerNewOrder> createState() => _SellerNewOrderState();
}

String formatYearDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return "";

  try {
    DateTime date = DateTime.parse(dateString);
    return DateFormat("MMMM d, yyyy").format(date); // e.g. August 1, 2025
  } catch (e) {
    return "";
  }
}

final TextEditingController _offerController = TextEditingController();
final TextEditingController _messageController = TextEditingController();

class _SellerNewOrderState extends ConsumerState<SellerNewOrder> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;

  // ✅ Added local decision tracker
  ProductDecision _decision = ProductDecision.none;

  ProductDecision get decision => _decision; // optional public getter

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // corrected method
            spreadRadius: 0.2,
            blurRadius: 0.2,
            offset: Offset(0, 0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.parent?.user?.imagePath?.isNotEmpty ?? false
                    ? widget.parent.user.imagePath ?? ""
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
                  width: 48.w,
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
                '@${widget.parent.user.username}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2),
              //   decoration: BoxDecoration(
              //     color: widget.products?.status == "rejected"
              //         ? Colors.red
              //         : AppColors.lightYellow,
              //     borderRadius: BorderRadius.circular(26.r),
              //   ),
              //   child: Center(
              //     child: Text(
              //       '${widget.products?.status.toTitleCase() ?? ""}',
              //       style: GoogleFonts.roboto(
              //         color: widget.products?.status == "rejected"
              //             ? Colors.white
              //             : AppColors.orange,
              //         fontSize: 11.sp,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2),
                decoration: BoxDecoration(
                  color: widget.products?.status == "pending"
                      ? AppColors.lightYellow
                      :  widget.products?.status == "accepted"
                      ? AppColors.primaryColor
                      : Colors.red,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    '${ widget.products?.status.toTitleCase()}',
                    style: GoogleFonts.roboto(
                      color:  widget.products?.status == 'pending'
                          ? AppColors.orange
                          :  widget.products?.status == "accepted"
                          ? AppColors.white
                          : Colors.white,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Product details & actions
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                          widget.products?.product.images.isNotEmpty ?? false
                              ? widget.products?.product.images[0] ?? ''
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
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.products?.product.name.toTitleCase()}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Quantity: ${widget.products?.quantity.toString()}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          currencyFormat.format(double.parse(
                              widget.products?.product.price.toString() ??
                                  '0')),
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                // Text(
                //   'Delivery Address: ${widget.parent.deliveryAddress ?? ""}',
                //   style: GoogleFonts.roboto(
                //     color: AppColors.grey,
                //     fontSize: 14.sp,
                //   ),
                // ),
                SizedBox(
                  height: 5.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Order ${widget.parent.orderNumber.toString() ?? ""}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          color: AppColors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Text(
                      '${formatDate("${widget.parent.createdAt}")}',
                      style: GoogleFonts.roboto(
                        color: AppColors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                if (widget.products?.status != "accepted" &&
                    widget.products?.status != "rejected") ...[
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            setState(() {
                              _decision = ProductDecision.rejected;
                              widget.decisionMap[widget.products?.id ?? ""] =
                                  ProductDecision.rejected;
                            });
                          },
                          label: 'Decline',
                          buttonTextColor: _decision == ProductDecision.rejected
                              ? Colors.white
                              : Colors.black,
                          fillColor: _decision == ProductDecision.rejected
                              ? Colors.red
                              : AppColors.greyLight,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            setState(() {
                              _decision = ProductDecision.accepted;
                              widget.decisionMap[widget.products?.id ??
                                  ""] = ProductDecision.accepted;
                            });
                          },
                          label: 'Accept',
                          buttonTextColor: _decision == ProductDecision.accepted
                              ? Colors.white
                              : Colors.black,
                          fillColor: _decision == ProductDecision.accepted
                              ? AppColors.primaryColor
                              : AppColors.greyLight,
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
