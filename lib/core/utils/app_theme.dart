// import 'package:flutter/material.dart';

// class AppTheme {
//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: Colors.blue,
//       scaffoldBackgroundColor: Colors.white,
//       fontFamily: 'Cairo', // Arabic font
//       textTheme: const TextTheme(
//         displayLarge: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//         displayMedium: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//         displaySmall: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//         bodyLarge: TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: 14,
//           color: Colors.black87,
//         ),
//       ),
//       appBarTheme: const AppBarTheme(
//         color: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         titleTextStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Cairo',
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//       colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'Cairo',
    brightness: Brightness.light,
  );

  static ThemeData get darkTheme => ThemeData(
    primarySwatch: Colors.blueGrey,
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
  );
}