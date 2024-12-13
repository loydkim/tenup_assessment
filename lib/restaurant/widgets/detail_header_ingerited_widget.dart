import 'package:flutter/material.dart';
import 'package:tenup_project/restaurant/widgets/detail_view_app_bar.dart';

class DetailHeaderInheritedWidget extends InheritedWidget {
  final DetailViewAppBarState data;

  const DetailHeaderInheritedWidget(
      {required this.data, super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
