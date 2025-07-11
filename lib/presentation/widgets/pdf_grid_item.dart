// // lib/presentation/widgets/pdf_grid_item.dart
// import 'package:fci_app_new/data/models/pdf_document.dart';
// import 'package:fci_app_new/data/providers/document_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import '../screens/pdf_viewer_screen.dart';

// class PdfGridItem extends StatelessWidget {
//   final PdfDocument document;
//   final String collectionId;

//   const PdfGridItem({
//     Key? key,
//     required this.document,
//     required this.collectionId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // عند النقر على العنصر، سيتم تحديث آخر صفحة تم قراءتها
//       onTap: () {
//         // تحديث آخر صفحة تم قراءتها باستخدام DocumentProvider
//         Provider.of<DocumentProvider>(context, listen: false)
//             .updateLastRead(collectionId, document.id);

//         // الانتقال إلى شاشة عرض PDF
//         Get.to(() => PdfViewerScreen(
//               document: document,
//               collectionId: collectionId,
//             ));
//       },
//       child: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // رمز PDF الأساسي
//                 Container(
//                   width: 60,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(6),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.picture_as_pdf,
//                         color: Colors.red[700],
//                         size: 32,
//                       ),
//                       const SizedBox(height: 4),
//                       const Text(
//                         'PDF',
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // أيقونة المفضلة إذا كان المستند مفضل
//                 if (document.isFavorite == true)
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                         size: 14,
//                       ),
//                     ),
//                   ),

//                 // أيقونة التنزيل إذا كان المستند تم تنزيله
//                 if (document.isDownloaded == true)
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.download_done,
//                         color: Colors.green,
//                         size: 14,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           // عرض عنوان المستند مع تحديد المحاذاة والتنسيق
//           Text(
//             document.title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             maxLines: 2, // عرض العنوان في سطرين كحد أقصى
//             overflow: TextOverflow.ellipsis, // إظهار "..." إذا كان النص طويل
//           ),
//         ],
//       ),
//     );
//   }
// }
