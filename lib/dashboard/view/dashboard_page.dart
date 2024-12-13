import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenup_project/common/widgets/restaurant_row_item.dart';
import 'package:tenup_project/dashboard/widgets/feature_list.dart';
import 'package:tenup_project/dashboard/widgets/popular_restaurants_item.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';
import 'package:tenup_project/dashboard/view_model/dashboard_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    DashboardModel restaurant = context.watch<DashboardModel>();
    if (restaurant.restaurants.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeatureList(
            restaurants: restaurant.restaurants.getRange(0, 3).toList(),
            favoriteModel: context.read<FavoriteModel>(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text("Popular Restaurants",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 24)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              child: Row(
                children: restaurant.restaurants
                    .getRange(3, 8)
                    .toList()
                    .map((restaurant) => PopularRestaurantsItem(
                        favoriteModel: context.read<FavoriteModel>(),
                        restaurant: restaurant))
                    .toList(),
              ),
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              key: const Key('AllRestaurantListView'),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
              itemCount: restaurant.listCount,
              itemBuilder: (BuildContext context, int index) {
                if (restaurant.isLoading) {
                  return RestaurantRowItem(isLoading: restaurant.isLoading);
                }
                // Restaurant row item with View More button list tile.
                if (index == restaurant.listCount - 1 &&
                    restaurant.listCount < restaurant.restaurants.length) {
                  return Column(
                    children: [
                      restaurantItem(restaurant, index),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              restaurant.increaseListCount();
                            },
                            child: Text(
                              "View More",
                            )),
                      ),
                    ],
                  );
                }
                return restaurantItem(restaurant, index);
              })
        ],
      ),
    );
  }

  restaurantItem(DashboardModel restaurant, int index) {
    return Consumer<FavoriteModel>(builder: (context, favoriteModel, child) {
      return RestaurantRowItem(
        isLoading: restaurant.isLoading,
        favoriteModel: favoriteModel,
        restaurant: restaurant.restaurants[index],
        index: index,
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
