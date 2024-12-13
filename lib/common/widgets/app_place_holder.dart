import 'package:flutter/material.dart';
import 'package:tenup_project/theme/app_color.dart';

/// Placeholder Layout, if the width value is null, the width is infinite.
class AppPlaceHolder extends StatelessWidget {
  final double height;
  final double? width;

  const AppPlaceHolder({super.key, required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColor.placeHolder,
      ),
    );
  }
}
