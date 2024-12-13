import 'package:flutter/material.dart';

class NoFavorites extends StatelessWidget {
  const NoFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imgWidth = size.width * 0.9;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You don't have any favorites yet.\n\nPlease tab the Heart icon to add a restaurant to your favorites in Restaurant page.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          width: imgWidth,
          height: imgWidth * 0.8,
          child: Image.asset(
            "assets/imgs/favorite_empty.png",
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
