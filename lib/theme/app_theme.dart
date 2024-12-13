import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tenup_project/theme/app_color.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColor.defaultText),
      headlineMedium: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColor.defaultText),
      headlineSmall: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.defaultText),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColor.defaultText),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.defaultText),
      bodySmall: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColor.defaultText),
      titleMedium: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColor.defaultText),
    ),
    appBarTheme: AppBarTheme(
        color: AppColor.surface,
        iconTheme: IconThemeData(
          color: AppColor.primaryFill,
        )),
    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.zero,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColor.primaryFill)),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    primaryColor: AppColor.primaryFill,
  );

  static get restaurantRowDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.2,
          ),
        ],
      );

  static get gradientLoadingDecoration => BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [
          0.2,
          0.4,
          0.6,
          1.0,
        ],
        colors: [
          AppColor.gradientBG,
          AppColor.placeHolder,
          AppColor.placeHolder,
          AppColor.gradientBG,
        ],
      ));
}
