// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // إذا كنت تستخدم SVG للأيقونات

// // class SideMenuItem extends StatelessWidget {
// //   final String svgAsset; // مسار الأيقونة
// //   final String title; // عنوان العنصر
// //   final VoidCallback onTap; // الدالة التي سيتم استدعاؤها عند النقر

// //   // المُنشئ مع معلمات مثل الأيقونة، العنوان، والدالة عند النقر
// //   const SideMenuItem({
// //     Key? key,
// //     required this.svgAsset,
// //     required this.title,
// //     required this.onTap,
// //   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onTap, // عند النقر يتم استدعاء onTap
//       leading: SvgPicture.asset(
//         svgAsset, // عرض الأيقونة باستخدام SVG
//         width: 24, // يمكنك تعديل الحجم حسب الحاجة
//         height: 24,
//       ),
//       title: Text(
//         title, // النص الذي سيتم عرضه
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }
