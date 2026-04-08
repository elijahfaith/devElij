import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/seller_order_model.dart';
import '../../utils/app_colors.dart';

class SellerOrderTile extends StatelessWidget {
  final SellerOrderModel order;
  final VoidCallback onTap;

  const SellerOrderTile({
    Key? key,
    required this.order,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${order.orderNumber ?? ""}",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.primaryColor),
            ),
            SizedBox(height: 6),
            Text(
              "Items: ${order.items.length ?? ""}",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Total: ₦${order.subtotal.toStringAsFixed(2)}",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
