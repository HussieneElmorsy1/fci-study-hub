import 'package:fci_app_new/data/models/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSideMenu extends StatelessWidget {
  final List<SideMenuItem> items;
  final Function(int)? onItemSelected;
  final double itemWidth;
  final double iconSize;
  final double iconContainerSize;
  final bool preventDuplicates;
  final Transition? transition;
  final Duration? transitionDuration;

  const CustomSideMenu({
    super.key,
    required this.items,
    this.onItemSelected,
    this.itemWidth = 70,
    this.iconSize = 40,
    this.iconContainerSize = 60,
    this.preventDuplicates = true,
    this.transition,
    this.transitionDuration,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          return _SideMenuItemWidget(
            svgAsset: item.svgAsset,
            title: item.title,
            iconColor: item.iconColor,
            isDarkMode: isDarkMode,
            width: itemWidth,
            iconContainerSize: iconContainerSize,
            iconSize: iconSize,
            onTap: () {
              onItemSelected?.call(index);
              Get.toNamed(
                item.routeName,
                arguments: item.arguments,
                preventDuplicates: preventDuplicates,
                // transition: transition,
                // duration: transitionDuration,
              );
            },
          );
        },
      ),
    );
  }
}

class _SideMenuItemWidget extends StatelessWidget {
  final String svgAsset;
  final String title;
  final bool isDarkMode;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double width;
  final double iconContainerSize;
  final double iconSize;

  const _SideMenuItemWidget({
    required this.svgAsset,
    required this.title,
    required this.isDarkMode,
    this.iconColor,
    this.onTap,
    required this.width,
    required this.iconContainerSize,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgAsset,
                  width: iconSize,
                  height: iconSize,
                  // color: iconColor ?? (isDarkMode ? Colors.white : null),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Title
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
