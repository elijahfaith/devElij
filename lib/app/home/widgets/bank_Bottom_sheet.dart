// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../models/storage/bank_model.dart';
//
// class BankPickerBottomSheet extends StatefulWidget {
//   final List<BankModel> banks;
//   final ValueChanged<BankModel> onSelect;
//
//   const BankPickerBottomSheet({
//     super.key,
//     required this.banks,
//     required this.onSelect,
//   });
//
//   @override
//   State<BankPickerBottomSheet> createState() => _BankPickerBottomSheetState();
// }
//
// class _BankPickerBottomSheetState extends State<BankPickerBottomSheet> {
//   String search = '';
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredBanks = widget.banks
//         .where((bank) => bank.name.toLowerCase().contains(search.toLowerCase()))
//         .toList();
//
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         top: 16.h,
//         left: 16.w,
//         right: 16.w,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             onChanged: (value) => setState(() => search = value),
//             decoration: InputDecoration(
//               hintText: 'Search bank...',
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredBanks.length,
//               itemBuilder: (_, index) {
//                 final bank = filteredBanks[index];
//                 return ListTile(
//                   title: Text(bank.name),
//                   onTap: () => widget.onSelect(bank),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
