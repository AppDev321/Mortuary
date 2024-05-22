// import 'package:flutter/material.dart';
// import '../styles/colors.dart';
//
// customBottomSheet(context) {
//   showModalBottomSheet(
//       backgroundColor: AppColors.whiteAccent,
//       isScrollControlled: true,
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       builder: (BuildContext context) {
//         return DraggableScrollableSheet(
//           expand: false,
//           builder: (context, scrollController) {
//             return SingleChildScrollView(
//               controller: scrollController,
//               child: GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).unfocus();
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                   padding: const EdgeInsets.all(20),
//                 ),
//               ),
//             );
//           },
//         );
//       });
// }
