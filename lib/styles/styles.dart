import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

//*********TEXT********** */

class AppTextStyles {
  static TextStyle headline1 = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 // سمك الخط لإعطاء تأثير الظل الداخلي
      ..color = Colors.black.withOpacity(0.25), // لون الظل الداخلي
  );

  static TextStyle headline1Fill = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0C8CE9), // اللون الأساسي للنص
  );

  static TextStyle bodyText = GoogleFonts.cairo(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Color(0xFF0C8CE9),
  );

  static const TextStyle caption = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    color: Colors.grey,
  );
}
//*********COLORS********** */

class AppColors {
  static const Color kPrimaryColor = Color(0xFF1E88E5);
  static const Color accentColor = Color(0xFFF5C33B);
  static const Color backgroundColor = Color(0xFFF7F8FA);
  static const Color textColor = Color.fromARGB(255, 255, 219, 219);
  static const Color white = Colors.white;
}
//*********Spacing********** */

class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;
}

class AppGaping {
  static const kGap0 = Gap(0);
  static const kGap5 = Gap(5);
  static const kGap8 = Gap(8);
  static const kGap10 = Gap(10);
  static const kGap15 = Gap(15);
  static const kGap20 = Gap(20);
  static const kGap25 = Gap(25);
  static const kGap30 = Gap(30);
  static const kGap32 = Gap(32);
  static const kGap40 = Gap(40);
  static const kGap50 = Gap(50);
  static const kGap60 = Gap(60);
  static const kGap100 = Gap(100);
  static const kGap125 = Gap(125);
  static const kGap150 = Gap(150);
  static const kGap200 = Gap(200);
  static const kGapLine1 = Gap(1, color: Colors.white, crossAxisExtent: 200);
}

//*********Borders and Shadows********** */

class AppBorders {
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(8));
  static const Border cardBorder = Border(
    top: BorderSide(color: Colors.grey, width: 1),
    bottom: BorderSide(color: Colors.grey, width: 1),
  );
}
