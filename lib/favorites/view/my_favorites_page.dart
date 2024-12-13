import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenup_project/common/widgets/restaurant_row_item.dart';
import 'package:tenup_project/favorites/widgets/no_favorites.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({super.key});

  @override
  State<MyFavoritesPage> createState() => MyFavoritesPageState();
}

class MyFavoritesPageState extends State<MyFavoritesPage>
    with AutomaticKeepAliveClientMixin<MyFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<FavoriteModel>(
      builder: (context, favoriteModel, child) {
        return favoriteModel.favoriteRestaurants.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                itemCount: favoriteModel.favoriteRestaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return RestaurantRowItem(
                    isLoading: false,
                    parentRoute: ParentRoute.myFavorite,
                    favoriteModel: favoriteModel,
                    restaurant: favoriteModel.favoriteRestaurants[index],
                    index: index,
                  );
                })
            : const NoFavorites();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
