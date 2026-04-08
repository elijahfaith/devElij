import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/app/widgets/back_button.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/services/navigation/animated_navigation.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/screen_size.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _LoadingHistoryState();
}

String formatRelativeTime(String? dateString) {
  if (dateString == null || dateString.isEmpty) return "";

  try {
    DateTime date = DateTime.parse(dateString).toLocal();
    return timeago.format(date,
        locale: 'en'); // you can change locale if needed
  } catch (e) {
    return "";
  }
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

class _LoadingHistoryState extends ConsumerState<NotificationPage> {
  final AnimatedNavigation _animatedNavigation = AnimatedNavigation();
  TextEditingController emailController = TextEditingController();
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Container();

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       "Notifications",
    //       style: TextStyle(
    //           fontSize: 14.sp,
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.greenText),
    //     ),
    //     centerTitle: false,
    //     backgroundColor: Colors.white,
    //     elevation: 0,
    //     actions: [
    //       if (productProvider.notificationModel?.unreadCount != 0) ...[
    //         InkWell(
    //           onTap: () async {
    //             await productProvider.markAllAsRead();
    //           },
    //           child: Text("Mark all as read",
    //               style: GoogleFonts.roboto(
    //                   fontSize: 12.sp,
    //                   fontWeight: FontWeight.w400,
    //                   color: AppColors.primaryColor)),
    //         ),
    //         SizedBox(width: 20.w),
    //       ],
    //     ],
    //   ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child:
    //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //         productProvider.notificationModel?.notifications?.isNotEmpty ??
    //                 false
    //             ? ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 physics: NeverScrollableScrollPhysics(),
    //                 shrinkWrap: true,
    //                 padding: const EdgeInsets.all(20),
    //                 itemCount: productProvider
    //                     .notificationModel?.notifications?.length,
    //                 itemBuilder: (context, index) {
    //                   final notification = productProvider
    //                       .notificationModel?.notifications?[index];
    //                   return Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       InkWell(
    //                           onTap: () async {
    //                             await productProvider
    //                                 .markAsRead(notification?.id);
    //                             final productId = notification?.data?.productId;
    //                             try {
    //                               switch (notification?.type) {
    //                                 case 'negotiation_new':
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (_) =>
    //                                           MyOrders("sellerOffer"),
    //                                     ),
    //                                   );
    //                                   break;
    //                                 case 'negotiation_response':
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (_) =>
    //                                           MyOrders("orderSellerResponse"),
    //                                     ),
    //                                   );
    //                                   break;
    //                                 case 'product_update':
    //                                   try {
    //                                     await productProvider
    //                                         .setMyDetailedProduct(
    //                                             productId ?? "", context);
    //                                   } catch (e, s) {
    //                                     print(
    //                                         "❌ Error navigating to product detail: $e");
    //                                     print(s);
    //                                   }
    //                                   break;
    //                                 case 'negotiation_rejected':
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (_) => MyOrders("offer"),
    //                                     ),
    //                                   );
    //                                   break;
    //                                 case 'negotiation_accepted':
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (_) => MyOrders("offer"),
    //                                     ),
    //                                   );
    //                                   break;
    //                                 case 'order_items_accepted':
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (_) =>
    //                                           MyOrders("newBuyOrder"),
    //                                     ),
    //                                   );
    //                                   break;
    //                                 case 'order_created':
    //                                   final actionType =
    //                                       notification?.data?.actionType;
    //                                   if (actionType == "buyer_notification") {
    //                                     Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                         builder: (_) =>
    //                                             MyOrders("newBuyOrder"),
    //                                       ),
    //                                     );
    //                                   } else if (actionType ==
    //                                       "seller_notification") {
    //                                     Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                         builder: (_) =>
    //                                             MyOrders("newSellerOrder"),
    //                                       ),
    //                                     );
    //                                   } else {
    //                                     print(
    //                                         "⚠️ Unknown actionType for order_created: $actionType");
    //                                   }
    //                                   break;
    //
    //                                 default:
    //                                   print(
    //                                       "⚠️ Unhandled notification type: ${notification?.type}");
    //                               }
    //                             } catch (e, s) {
    //                               print(
    //                                   "❌ Navigation error for ${notification?.type}: $e");
    //                               print(s);
    //                             }
    //                           },
    //                           child: Container(
    //                             padding: EdgeInsets.all(10),
    //                             decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(16.r)),
    //                                 boxShadow: [
    //                                   BoxShadow(
    //                                       color: Colors.black
    //                                           .withValues(alpha: 0.2),
    //                                       spreadRadius: 0,
    //                                       blurRadius: 2,
    //                                       offset: Offset(0, 0.2))
    //                                 ],
    //                                 border: Border.all(
    //                                     color: notification?.isRead == false
    //                                         ? AppColors.primaryColor
    //                                         : Colors.grey.shade100)),
    //                             width: Responsive.width(context),
    //                             // height: 105,
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   children: [
    //                                     Container(
    //                                       height: 40.h,
    //                                       width: 40.w,
    //                                       decoration: BoxDecoration(
    //                                           shape: BoxShape.circle,
    //                                           color: AppColors.lightPurple),
    //                                       child: Center(
    //                                         child: SvgPicture.asset(
    //                                             "assets/images/cart.svg",
    //                                             color: Colors.purple
    //                                             // width: 10,
    //                                             ),
    //                                       ),
    //                                     ),
    //                                     SizedBox(
    //                                       width: 15,
    //                                     ),
    //                                     Expanded(
    //                                         child: Column(
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.start,
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.start,
    //                                       children: [
    //                                         Text(
    //                                           '${notification?.title ?? ""}',
    //                                           style: GoogleFonts.roboto(
    //                                               fontSize: 14,
    //                                               fontWeight: FontWeight.bold),
    //                                         ),
    //                                         Text(
    //                                           '${notification?.message ?? ""}',
    //                                           style: GoogleFonts.roboto(
    //                                               fontSize: 12.sp,
    //                                               fontWeight: FontWeight.w300),
    //                                         ),
    //                                         SizedBox(
    //                                           height: 2,
    //                                         ),
    //                                         Row(
    //                                           mainAxisAlignment:
    //                                               MainAxisAlignment
    //                                                   .spaceBetween,
    //                                           children: [
    //                                             Text(
    //                                               formatRelativeTime(
    //                                                   notification?.createdAt),
    //                                               style: GoogleFonts.roboto(
    //                                                 color:
    //                                                     const Color(0xff545454),
    //                                                 fontSize: 12,
    //                                                 fontWeight: FontWeight.w400,
    //                                               ),
    //                                             ),
    //                                             Row(
    //                                               spacing: 9,
    //                                               children: [
    //                                                 // notification?.isRead == false
    //                                                 //     ? Text(
    //                                                 //   "Unread",
    //                                                 //   style:
    //                                                 //   GoogleFonts.roboto(
    //                                                 //     color: AppColors.red,
    //                                                 //     fontSize: 12,
    //                                                 //     fontWeight:
    //                                                 //     FontWeight.w400,
    //                                                 //   ),
    //                                                 // )
    //                                                 //     : Text(
    //                                                 //   "Read",
    //                                                 //   style:
    //                                                 //   GoogleFonts.roboto(
    //                                                 //     color: AppColors
    //                                                 //         .primaryColor,
    //                                                 //     fontSize: 12,
    //                                                 //     fontWeight:
    //                                                 //     FontWeight.w400,
    //                                                 //   ),
    //                                                 // ),
    //
    //                                                 InkWell(
    //                                                   onTap: () {
    //                                                     productProvider
    //                                                         .deleteNotificaation(
    //                                                             notification
    //                                                                     ?.id ??
    //                                                                 "");
    //                                                   },
    //                                                   child: Container(
    //                                                     height: 30.h,
    //                                                     width: 30.w,
    //                                                     decoration:
    //                                                         BoxDecoration(
    //                                                             shape: BoxShape
    //                                                                 .circle,
    //                                                             color: AppColors
    //                                                                 .red),
    //                                                     child: Center(
    //                                                       child:
    //                                                           SvgPicture.asset(
    //                                                         "assets/images/delete.svg",
    //                                                         color: Colors.white,
    //                                                         width: 12.w,
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //                                               ],
    //                                             )
    //                                           ],
    //                                         )
    //                                       ],
    //                                     ))
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           )),
    //                       SizedBox(height: 10.h),
    //                     ],
    //                   );
    //                 })
    //             : Center(
    //                 child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: 30.h,
    //                   ),
    //                   Text(
    //                     'No notification yet',
    //                     style: GoogleFonts.roboto(
    //                       fontSize: 13.sp,
    //                     ),
    //                   ),
    //                 ],
    //               )),
    //       ]),
    //     ),
    //   ),
    // );
  }
}
