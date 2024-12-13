import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tenup_project/app_routes.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';
import 'package:tenup_project/restaurant/view/restaurant_page.dart';
import 'package:yelp_api/yelp_api.dart';

class PopularRestaurantsItem extends StatelessWidget {
  const PopularRestaurantsItem(
      {super.key, this.favoriteModel, required this.restaurant});

  final FavoriteModel? favoriteModel;
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detailView,
            arguments:
                DetailViewArgument(favoriteModel!, restaurant, restaurant.id!));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 160,
          height: 190,
          child: Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Hero(
                      tag: restaurant.id!,
                      child: restaurant.photos?.first != null
                          ? CachedNetworkImage(
                              imageUrl: restaurant.photos!.first,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    // color: Colors.red,
                    height: 40,
                    child: Text(
                      restaurant.name ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Row(
                    children: [
                      Icon(Icons.restaurant, size: 16.0),
                      SizedBox(width: 4),
                      Text(
                        restaurant.categories?.first.title ?? "",
                        style: Theme.of(context).textTheme.titleMedium!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
