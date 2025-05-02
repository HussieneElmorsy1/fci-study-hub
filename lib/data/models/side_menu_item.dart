import 'package:flutter/material.dart';

class SideMenuItem {
  final String svgAsset;
  final String title;
  final Color? iconColor;
  final String routeName;
  final dynamic arguments;

  const SideMenuItem({
    required this.svgAsset,
    required this.title,
    this.iconColor,
    required this.routeName,
    this.arguments,
  });
}