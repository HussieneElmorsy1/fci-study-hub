// // lib/presentation/screens/pdf_screen.dart
// import 'package:fci_app_new/app_pages/app_routes.dart';
// import 'package:fci_app_new/data/models/document_collection.dart';
// import 'package:fci_app_new/data/models/pdf_document.dart';
// import 'package:fci_app_new/data/providers/document_provider.dart';
// import 'package:fci_app_new/presentation/widgets/custom_tab_bar.dart';
// import 'package:fci_app_new/presentation/widgets/pdf_grid_item.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// class PdfScreen extends StatefulWidget {
//   final String title;

//   const PdfScreen({Key? key, required this.title}) : super(key: key);

//   @override
//   State<PdfScreen> createState() => _PdfScreenState();
// }

// class _PdfScreenState extends State<PdfScreen> {
//   int _selectedIndex = 0;
//   final List<String> _tabTitles = ['محاضرة', 'سكشن', 'فيديو', 'الواجبات'];

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         appBar: _buildAppBar(isDarkMode),
//         body: Consumer<DocumentProvider>(
//           builder: (context, documentProvider, child) {
//             if (documentProvider.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (documentProvider.error != null) {
//               return Center(
//                 child: Text(
//                   documentProvider.error!,
//                   style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
//                 ),
//               );
//             }

//             final collections = documentProvider.collections;

//             if (collections.isEmpty) {
//               return Center(
//                 child: Text(
//                   'لا توجد مستندات متاحة',
//                   style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
//                 ),
//               );
//             }

//             final documents = (_selectedIndex < collections.length)
//                 ? collections[_selectedIndex].documents
//                 : <PdfDocument>[];

//             return _buildBody(collections, documents, isDarkMode);
//           },
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar(bool isDarkMode) {
//     return AppBar(
//       centerTitle: true,
//       title: Text(
//         widget.title,
//         style: TextStyle(
//           color: Theme.of(context).textTheme.bodyLarge?.color,
//           fontWeight: FontWeight.bold,
//           fontSize: 18,
//         ),
//       ),
//       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       elevation: 0.5,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_forward,
//           color: Theme.of(context).iconTheme.color,
//         ),
//         onPressed: () => Get.back(),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.search,
//             color: Theme.of(context).iconTheme.color,
//           ),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   Widget _buildBody(
//     List<DocumentCollection> collections,
//     List<PdfDocument> documents,
//     bool isDarkMode,
//   ) {
//     return Column(
//       children: [
//         CustomTabBar(
//           tabs: _tabTitles,
//           selectedIndex: _selectedIndex,
//           onTabSelected: (index) {
//             if (index == 2) {
//               Get.toNamed(AppRoutes.VIDEO_SCREEN);
//             } else {
//               setState(() => _selectedIndex = index);
//             }
//           },
//         ),
//         Expanded(
//           child: GridView.builder(
//             padding: const EdgeInsets.all(16.0),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               childAspectRatio: 0.7,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 16.0,
//             ),
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               return PdfGridItem(
//                 document: documents[index],
//                 collectionId: collections[_selectedIndex].id,
//                 // isDarkMode: isDarkMode,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }