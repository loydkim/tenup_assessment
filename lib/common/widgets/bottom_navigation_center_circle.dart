import 'package:flutter/material.dart';

class BottomNavigationCenterCircle extends StatelessWidget {
  final TabController tabController;
  const BottomNavigationCenterCircle({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: Opacity(
                    opacity: 1,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: tabController.index == 1
                            ? Colors.red[400]
                            : Colors.red[200],
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        key: const ValueKey('bottomNavCenterCircle'),
                        borderRadius: BorderRadius.circular(500.0),
                        onTap: () {
                          tabController.index = 1;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.5),
                          child: SizedBox(
                              width: 24,
                              height: 24,
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: tabController.index == 1
                                    ? Colors.grey[200]
                                    : Colors.grey[100],
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
