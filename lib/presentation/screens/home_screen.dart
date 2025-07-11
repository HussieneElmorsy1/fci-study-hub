// import 'package:fci_app_new/app_pages/app_routes.dart';
// import 'package:fci_app_new/data/models/side_menu_item.dart';
// import 'package:fci_app_new/data/models/status_model.dart';
// import 'package:fci_app_new/presentation/widgets/custom_side_menu.dart';
// import 'package:fci_app_new/presentation/widgets/home_widgets.dart';
// import 'package:fci_app_new/presentation/widgets/horizontal_line.dart';
// import 'package:fci_app_new/presentation/widgets/horizontal_courses_list.dart';
// import 'package:fci_app_new/presentation/widgets/side_menu_item.dart';
// import 'package:fci_app_new/presentation/widgets/status_bar.dart';
// import 'package:fci_app_new/styles/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with AutomaticKeepAliveClientMixin {
//   final List<Status> demoStatuses = [
//     Status(
//         username: 'محمود',
//         imageAsset: 'assets/images/home_screen/Ellipse_25.png',
//         isViewed: false),
//     Status(
//         username: 'أحمد',
//         imageAsset: 'assets/images/home_screen/Ellipse_26.png',
//         isViewed: true),
//     Status(
//         username: 'محمود',
//         imageAsset: 'assets/images/home_screen/Ellipse_27.png',
//         isViewed: true),
//   ];

//   String selectedGroup = '3.4'.tr;

//   void _showGroupMenu(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).cardColor,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//       builder: (context) => _buildGroupMenu(),
//     );
//   }

//   Widget _buildGroupMenu() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: ['3.2', '3.3', '3.4', '3.5']
//           .map((groupName) => _buildMenuItem(groupName.tr))
//           .toList(),
//     );
//   }

//   Widget _buildMenuItem(String groupName) {
//     return ListTile(
//       title: Center(
//         child: Text(
//           groupName,
//           style: TextStyle(
//             fontSize: 18,
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           selectedGroup = groupName;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // Call super.build to ensure the state is kept alive
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: _buildAppBar(isDarkMode),
//       body: _buildBody(isDarkMode, context),
//       extendBody: true,
//     );
//   }

//   SingleChildScrollView _buildBody(bool isDarkMode, BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(
//           children: [
//             AppGaping.kGap50,
//             _buildTopImages(isDarkMode),
//             AppGaping.kGap10,
//             // _buildGroupSelection(),
//             // AppGaping.kGap10,
//             // _buildSideMenu(),
//             // AppGaping.kGap10,
//             // HorizontalLine(color: Theme.of(context).dividerColor),
//             // AppGaping.kGap10,
//             // _buildSectionTitle('3.12'.tr),
//             // StatusBar(statuses: demoStatuses),
//             // AppGaping.kGap10,
//             HorizontalLine(color: Theme.of(context).dividerColor),
//             AppGaping.kGap10,
//             _buildSectionTitle('Departments'.tr),
//             AppGaping.kGap10,
//             Material(
//               type: MaterialType
//                   .transparency, // للحفاظ على الشفافية إذا لزم الأمر
//               child: HorizontalCoursesList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar(bool isDarkMode) {
//     return AppBar(
//       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       elevation: 0,
//       title: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: Text(
//           '3.1'.tr,
//           style: TextStyle(
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//         ),
//       ),
//       centerTitle: true,
//       leading: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CircleAvatar(
//           backgroundColor: Theme.of(context).cardColor,
//           child: Image.asset('assets/images/fci_logo_1.png'),
//         ),
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

// Widget _buildTopImages(bool isDarkMode) {
//   return Center(
//     child: Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: 125,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             gradient: const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xFF074F83), Color(0xFF0C8CE9)],
//             ),
//           ),
//         ),
//         Positioned(
//           top: -18,
//           left: 0,
//           right: 0,
//           child: Center(
//             child: Center(
//               child: SvgPicture.asset('assets/images/home_screen/bro.svg'),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget _buildGroupSelection() {
//     return GroupSelection(
//       selectedGroup: selectedGroup,
//       showGroupMenu: _showGroupMenu,
//     );
//   }

//   Widget _buildSideMenu() {
//     return CustomSideMenu(
//       items: [
//         SideMenuItem(
//           svgAsset: 'assets/images/home_screen/audience.svg',
//           title: '3.6'.tr,
//           iconColor: Theme.of(context).cardColor,
//           routeName: '/audience_screen',
//           arguments: {'from': 'side_menu'}, // مثال لتمرير arguments
//         ),
//         SideMenuItem(
//           svgAsset: 'assets/images/home_screen/calendar.svg',
//           title: '3.7'.tr,
//           iconColor: Theme.of(context).iconTheme.color,
//           routeName: AppRoutes.CHAT,
//         ),
//         SideMenuItem(
//           svgAsset: 'assets/images/home_screen/notes.svg',
//           title: '3.8'.tr,
//           iconColor: Theme.of(context).iconTheme.color,
//           routeName: '/notes_screen',
//         ),
//         SideMenuItem(
//           svgAsset: 'assets/images/home_screen/chat.svg',
//           title: '3.9'.tr,
//           iconColor: Theme.of(context).iconTheme.color,
//           routeName: AppRoutes.CHATS,
//         ),
//         SideMenuItem(
//           svgAsset: 'assets/images/home_screen/settings.svg',
//           title: '3.10'.tr,
//           iconColor: Theme.of(context).iconTheme.color,
//           routeName: '/settings_screen',
//         ),
//         SideMenuItem(
//           svgAsset: 'assets/images/home_screen/add.svg',
//           title: '3.11'.tr,
//           iconColor: Theme.of(context).iconTheme.color,
//           routeName: '/add_screen',
//         ),
//       ],
//       onItemSelected: (index) {
//         // يمكنك استخدام هذا إذا كنت بحاجة لتنفيذ شيء إضافي عند الضغط
//         debugPrint('Selected item at index: $index');
//       },
//       // إعدادات إضافية (اختيارية)
//       preventDuplicates:
//           false, // إذا كنت تريد السماح بفتح نفس الصفحة أكثر من مرة
//       transition: Transition.rightToLeft, // تأثير الانتقال
//       transitionDuration: const Duration(milliseconds: 300), // مدة الانتقال
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Row(
//       children: [
//         Text(
//           title,
//           textAlign: TextAlign.right,
//           style: GoogleFonts.cairo(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//         ),
//       ],
//     );
//   }
// }

// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart'; //
import 'package:fci_app_new/presentation/controllers/majors_controller.dart'; // // استيراد متحكم التخصصات
import 'package:fci_app_new/data/models/major_model.dart'; // // استيراد نموذج التخصص
import 'package:fci_app_new/core/utils/app_theme.dart'; // // For AppColors, AppTextStyles
import 'package:fci_app_new/presentation/widgets/custom_app_bar.dart'; // // إذا كنت تستخدم App bar مخصص
import 'package:fci_app_new/styles/styles.dart'; // // For AppTextStyles, AppColors if defined there

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller inside build method to ensure dependencies are registered
    final MajorsController controller = Get.find<MajorsController>();

    return Scaffold(
      appBar: AppBar(
        // يمكنك استخدام CustomAppBar إذا كانت موجودة لديك
        title: Text('كلية الحاسبات والمعلومات'.tr), //
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // منطق البحث العام
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('حدث خطأ: ${controller.errorMessage.value}'.tr),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.fetchMajors,
                  child: Text('إعادة المحاولة'.tr),
                ),
              ],
            ),
          );
        } else if (controller.majors.isEmpty) {
          return Center(child: Text('لا توجد أقسام لعرضها'.tr));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصورة العلوية الكبيرة
                _buildTopImages(
                    Theme.of(context).brightness == Brightness.dark),

                const SizedBox(height: 20),
                Text('الأقسام'.tr,
                    style: AppTextStyles.headline3), // عنوان الأقسام
                const SizedBox(height: 10),
                // عرض الأقسام في Grid View
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // لمنع التمرير المزدوج
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عمودين
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.9, // نسبة العرض إلى الارتفاع للبطاقات
                  ),
                  itemCount: controller.majors.length,
                  itemBuilder: (context, index) {
                    final major = controller.majors[index];
                    return MajorCard(
                        major: major); // // Widget مخصص لبطاقة القسم
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildTopImages(bool isDarkMode) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF074F83), Color(0xFF0C8CE9)],
              ),
            ),
          ),
          Positioned(
            top: -18,
            left: 0,
            right: 0,
            child: Center(
              child: Center(
                child: SvgPicture.asset('assets/images/home_screen/bro.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget مخصص لبطاقة القسم (Major Card)
class MajorCard extends StatelessWidget {
  final MajorModel major; //

  const MajorCard({super.key, required this.major});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على القسم، انتقل إلى شاشة عرض المقررات الدراسية
        // تم تعديل تمرير الـ arguments ليصبح Map
        Get.toNamed(AppRoutes.COURSES_LIST, arguments: {
          //
          'majorId': major.id,
          'majorName': major.title,
        });
      },
      child: Card(
        elevation: 4, //
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), //
        child: Column(
          //
          mainAxisAlignment: MainAxisAlignment.center, //
          children: [
            //
            // يمكنك إضافة صورة رمزية للقسم هنا إذا كانت لديك
            // مثلاً: Image.asset('assets/images/majors/${major.id}.png', height: 80),
            Icon(Icons.computer, size: 60, color: AppColors.primary), //
            const SizedBox(height: 10), //
            Text(
              major.title, //
              style: AppTextStyles.headline3, //
              textAlign: TextAlign.center, //
              maxLines: 2, //
              overflow: TextOverflow.ellipsis, //
            ),
          ],
        ),
      ),
    );
  }
}
