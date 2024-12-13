import 'package:flutter/material.dart';
import 'package:tenup_project/restaurant/widgets/detail_view_app_bar.dart';
import 'package:tenup_project/theme/app_color.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';

class FavoriteButton extends StatefulWidget {
  final FavoriteModel favoriteModel;
  final String restaurantId;
  final bool isShrink;

  const FavoriteButton(
      {super.key,
      required this.favoriteModel,
      required this.restaurantId,
      required this.isShrink});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DetailViewAppBarState data = DetailViewAppBar.of(context);
    isFavorite = data.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 30,
          color: isFavorite
              ? Colors.red
              : widget.isShrink
                  ? AppColor.primaryFill
                  : AppColor.surface),
      onPressed: () async {
        DetailViewAppBar.of(context).setFavorite();
      },
    );
  }
}
