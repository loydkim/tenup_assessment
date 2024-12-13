import 'package:flutter/material.dart';
import 'package:tenup_project/theme/app_color.dart';

class Rating extends StatelessWidget {
  final double? rating;

  const Rating(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = 14.0;
    if (rating != null) {
      List<Widget> children = [];
      for (var i = 0; i < rating! ~/ 1; i++) {
        children.add(Icon(
          Icons.star,
          color: AppColor.star,
          size: iconSize,
        ));
      }
      if (rating! % 1 == 0.5) {
        children.add(Icon(
          Icons.star_half,
          color: AppColor.star,
          size: iconSize,
        ));
      }
      return Row(
        children: children,
      );
    } else {
      return Container();
    }
  }
}
