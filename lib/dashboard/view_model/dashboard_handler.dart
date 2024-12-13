// import 'package:local_db/local_db.dart';
import 'package:local_db/local_db.dart';
import 'package:yelp_api/yelp_api.dart';

class DashboardHandler {
  List<Restaurant> restaurants = [];

  DashboardHandler({List<Restaurant>? restaurants})
      : restaurants = restaurants ?? [];

  Future<void> fetchRestaurant({YelpApiClient? yelpApiClient}) async {
    final client = yelpApiClient ?? YelpApiClient();
    try {
      restaurants = await client.getRestaurants();
    } catch (e) {
      print('Error fetching restaurants: $e');
    }
  }

  Future<void> saveRestaurants() async {
    try {
      await LocalDB.instance.saveRestaurants(restaurants);
    } catch (e) {
      print('Error saving restaurants: $e');
    }
  }

  Future<void> fetchRestaurantAndSave() async {
    try {
      await fetchRestaurant();
      await saveRestaurants();
    } catch (e) {
      print('Error in fetch and save operation: $e');
    }
  }
}
