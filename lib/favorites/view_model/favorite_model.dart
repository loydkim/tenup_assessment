import 'package:flutter/material.dart';
import 'package:local_db/local_db.dart';
import 'package:tenup_project/dashboard/view_model/dashboard_handler.dart';
import 'package:yelp_api/yelp_api.dart';

class FavoriteModel extends DashboardHandler with ChangeNotifier {
  final List<Restaurant> _favoriteRestaurants = [];
  final LocalDB _localDB = LocalDB.instance;

  FavoriteModel({List<Restaurant>? restaurants})
      : super(restaurants: restaurants) {
    if (restaurants == null) {
      fetchRestaurantsFromLocalDB();
    }
  }

  void fetchRestaurantsFromLocalDB() async {
    try {
      final savedRestaurants = await _localDB.readRestaurants();
      if (savedRestaurants != null && savedRestaurants.isNotEmpty) {
        restaurants = (savedRestaurants as List<dynamic>)
            .map((e) => Restaurant.fromJson(e))
            .toList();
      }
      await fetchFavorites();
    } catch (e) {
      print('Error fetching restaurants from local DB: $e');
    }
  }

  fetchFavorites() async {
    try {
      final favoriteList = await _localDB.favoriteList;
      if (favoriteList != null && restaurants.isNotEmpty) {
        _favoriteRestaurants.clear();
        _favoriteRestaurants.addAll(
          restaurants
              .where((restaurant) => favoriteList.contains(restaurant.id)),
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching favorite restaurants: $e');
    }
  }

  Future<void> updateFavorites(String id, bool isFavorite) async {
    try {
      await _localDB.updateFavorite(id, isFavorite);
      if (isFavorite) {
        final restaurant = restaurants.firstWhere(
          (element) => element.id == id,
        );
        _favoriteRestaurants.add(restaurant);
      } else {
        _favoriteRestaurants.removeWhere((element) => element.id == id);
      }
      notifyListeners();
    } catch (e) {
      print('Error updating favorite restaurants: $e');
    }
  }

  List<Restaurant> get favoriteRestaurants =>
      List.unmodifiable(_favoriteRestaurants);
}
