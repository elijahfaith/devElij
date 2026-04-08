// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../models/checkout_model.dart';
//
// class CourierSelectionWidget extends StatefulWidget {
//   final List<ShippingOption> shippingOptions;
//
//   const CourierSelectionWidget({super.key, required this.shippingOptions});
//
//   @override
//   State<CourierSelectionWidget> createState() => _CourierSelectionWidgetState();
// }
//
// class _CourierSelectionWidgetState extends State<CourierSelectionWidget> {
//   // Map of sellerId to selected courierId
//   Map<String, String> selectedCouriers = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.shippingOptions.length,
//       itemBuilder: (context, index) {
//         final option = widget.shippingOptions[index];
//         final sellerId = option.seller.id;
//
//         return Container(
//           margin: const EdgeInsets.all(12),
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Seller: ${option.seller.username}", style: const TextStyle(fontWeight: FontWeight.bold)),
//
//               const SizedBox(height: 10),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: option.couriers.length,
//                 itemBuilder: (context, courierIndex) {
//                   final courier = option.couriers[courierIndex];
//                   final isSelected = selectedCouriers[sellerId] == courier.courierId;
//
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedCouriers[sellerId] = courier.courierId;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.blue.shade100 : Colors.white,
//                         border: Border.all(
//                           color: isSelected ? Colors.blue : Colors.grey,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(courier.courierName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 4),
//                           Text("Delivery Fee: ₦${courier.deliveryFee}"),
//                           Text("Delivery ETA: ${courier.deliveryEta}"),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
