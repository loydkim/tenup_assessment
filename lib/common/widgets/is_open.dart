import 'package:flutter/material.dart';
import 'package:tenup_project/theme/app_color.dart';

class IsOpen extends StatelessWidget {
  final bool isOpen;

  const IsOpen(this.isOpen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isOpen ? "Open Now" : "Closed",
            style: Theme.of(context).textTheme.titleMedium!),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.circle,
            color: isOpen ? AppColor.open : AppColor.closed,
            size: 8.0,
          ),
        ),
      ],
    );
  }
}
