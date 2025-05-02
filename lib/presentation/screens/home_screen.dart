import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/data/models/side_menu_item.dart';
import 'package:fci_app_new/data/models/status_model.dart';
import 'package:fci_app_new/presentation/widgets/custom_side_menu.dart';
import 'package:fci_app_new/presentation/widgets/home_widgets.dart';
import 'package:fci_app_new/presentation/widgets/horizontal_line.dart';
import 'package:fci_app_new/presentation/widgets/horizontal_courses_list.dart';
import 'package:fci_app_new/presentation/widgets/side_menu_item.dart';
import 'package:fci_app_new/presentation/widgets/status_bar.dart';
import 'package:fci_app_new/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Status> demoStatuses = [
    Status(
        username: 'محمود',
        imageAsset: 'assets/images/home_screen/Ellipse_25.png',
        isViewed: false),
    Status(
        username: 'أحمد',
        imageAsset: 'assets/images/home_screen/Ellipse_26.png',
        isViewed: true),
    Status(
        username: 'محمود',
        imageAsset: 'assets/images/home_screen/Ellipse_27.png',
        isViewed: true),
  ];

  String selectedGroup = '3.4'.tr;

  void _showGroupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => _buildGroupMenu(),
    );
  }

  Widget _buildGroupMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: ['3.2', '3.3', '3.4', '3.5']
          .map((groupName) => _buildMenuItem(groupName.tr))
          .toList(),
    );
  }

  Widget _buildMenuItem(String groupName) {
    return ListTile(
      title: Center(
        child: Text(
          groupName,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          selectedGroup = groupName;
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to ensure the state is kept alive
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(isDarkMode),
      body: _buildBody(isDarkMode, context),
      extendBody: true,
    );
  }

  SingleChildScrollView _buildBody(bool isDarkMode, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            AppGaping.kGap50,
            _buildTopImages(isDarkMode),
            AppGaping.kGap10,
            _buildGroupSelection(),
            AppGaping.kGap10,
            _buildSideMenu(),
            AppGaping.kGap10,
            HorizontalLine(color: Theme.of(context).dividerColor),
            AppGaping.kGap10,
            _buildSectionTitle('3.12'.tr),
            StatusBar(statuses: demoStatuses),
            AppGaping.kGap10,
            HorizontalLine(color: Theme.of(context).dividerColor),
            AppGaping.kGap10,
            _buildSectionTitle('3.13'.tr),
            AppGaping.kGap10,
            Material(
              type: MaterialType
                  .transparency, // للحفاظ على الشفافية إذا لزم الأمر
              child: HorizontalCoursesList(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDarkMode) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '3.1'.tr,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).cardColor,
          child: Image.asset('assets/images/fci_logo_1.png'),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {},
        ),
      ],
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

  Widget _buildGroupSelection() {
    return GroupSelection(
      selectedGroup: selectedGroup,
      showGroupMenu: _showGroupMenu,
    );
  }

  Widget _buildSideMenu() {
    return CustomSideMenu(
      items: [
        SideMenuItem(
          svgAsset: 'assets/images/home_screen/audience.svg',
          title: '3.6'.tr,
          iconColor: Theme.of(context).cardColor,
          routeName: '/audience_screen',
          arguments: {'from': 'side_menu'}, // مثال لتمرير arguments
        ),
        SideMenuItem(
          svgAsset: 'assets/images/home_screen/calendar.svg',
          title: '3.7'.tr,
          iconColor: Theme.of(context).iconTheme.color,
          routeName: AppRoutes.CHAT,
        ),
        SideMenuItem(
          svgAsset: 'assets/images/home_screen/notes.svg',
          title: '3.8'.tr,
          iconColor: Theme.of(context).iconTheme.color,
          routeName: '/notes_screen',
        ),
        SideMenuItem(
          svgAsset: 'assets/images/home_screen/chat.svg',
          title: '3.9'.tr,
          iconColor: Theme.of(context).iconTheme.color,
          routeName: AppRoutes.CHATS,
        ),
        SideMenuItem(
          svgAsset: 'assets/images/home_screen/settings.svg',
          title: '3.10'.tr,
          iconColor: Theme.of(context).iconTheme.color,
          routeName: '/settings_screen',
        ),
        SideMenuItem(
          svgAsset: 'assets/images/home_screen/add.svg',
          title: '3.11'.tr,
          iconColor: Theme.of(context).iconTheme.color,
          routeName: '/add_screen',
        ),
      ],
      onItemSelected: (index) {
        // يمكنك استخدام هذا إذا كنت بحاجة لتنفيذ شيء إضافي عند الضغط
        debugPrint('Selected item at index: $index');
      },
      // إعدادات إضافية (اختيارية)
      preventDuplicates:
          false, // إذا كنت تريد السماح بفتح نفس الصفحة أكثر من مرة
      transition: Transition.rightToLeft, // تأثير الانتقال
      transitionDuration: const Duration(milliseconds: 300), // مدة الانتقال
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
