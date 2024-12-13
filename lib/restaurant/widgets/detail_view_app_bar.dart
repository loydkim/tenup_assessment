import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:local_db/local_db.dart';
import 'package:tenup_project/restaurant/widgets/detail_header_ingerited_widget.dart';
import 'package:tenup_project/restaurant/widgets/favorite_button.dart';
import 'package:tenup_project/theme/app_color.dart';
import 'package:tenup_project/theme/app_theme.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';
import 'package:yelp_api/yelp_api.dart';

class DetailViewAppBar extends StatefulWidget {
  final FavoriteModel favoriteModel;
  final Restaurant restaurant;
  final bool isShrink;
  final String heroTag;

  const DetailViewAppBar(
      this.favoriteModel, this.restaurant, this.isShrink, this.heroTag,
      {super.key});

  static DetailViewAppBarState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DetailHeaderInheritedWidget>()!
        .data;
  }

  @override
  State<DetailViewAppBar> createState() => DetailViewAppBarState();
}

class DetailViewAppBarState extends State<DetailViewAppBar> {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  @override
  void initState() {
    super.initState();
    initFavorite();
  }

  initFavorite() async {
    // Check the restaurant is favorite or not.
    final checkFavorite =
        await LocalDB.instance.isFavorite(widget.restaurant.id!);
    if (checkFavorite) {
      setState(() {
        _isFavorite = checkFavorite;
      });
    }
  }

  setFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    widget.favoriteModel.updateFavorites(widget.restaurant.id!, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DetailHeaderInheritedWidget(
      data: this,
      child: SliverAppBar(
        pinned: true,
        expandedHeight: 260.0,
        flexibleSpace: FlexibleSpaceBar(
          title: SizedBox(
            width: size.width * 0.7,
            child: Text(widget.restaurant.name ?? "",
                overflow: widget.isShrink ? TextOverflow.ellipsis : null,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: widget.isShrink
                        ? AppColor.primaryFill
                        : AppColor.surface)),
          ),
          titlePadding:
              widget.isShrink ? null : const EdgeInsets.fromLTRB(24, 0, 24, 16),
          background: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Hero(
                tag: widget.heroTag,
                child: CachedNetworkImage(
                  imageUrl: widget.restaurant.photos!.first,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    decoration: AppTheme.gradientLoadingDecoration,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ),
          centerTitle: false,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: widget.isShrink ? AppColor.primaryFill : AppColor.surface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FavoriteButton(
                favoriteModel: widget.favoriteModel,
                restaurantId: widget.restaurant.id!,
                isShrink: widget.isShrink),
          ),
        ],
      ),
    );
  }
}
