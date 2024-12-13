import 'dart:io';

import 'package:hive/hive.dart';
import 'package:local_db/src/db_keys.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:yelp_api/yelp_api.dart';

class LocalDB {
  final Future<Box> _box = Hive.openBox('tenup_project');

  static final LocalDB instance = LocalDB._internal();

  LocalDB._internal();

  static Future<void> init({bool isTestMode = false}) async {
    final path;
    if (isTestMode) {
      path = Directory.current.path;
    } else {
      path = (await getApplicationDocumentsDirectory()).path;
    }
    Hive.init(path);
  }

  saveRestaurants(List<Restaurant> restaurants) async =>
      (await _box).put(DBKey.restaurantList, json.encode(restaurants));

  readRestaurants() async {
    final restaurantList = (await _box).get(DBKey.restaurantList);
    if (restaurantList != null) {
      return json.decode(restaurantList);
    }
  }

  updateFavorite(String id, bool newFavorite) async {
    Box box = await _box;
    List<String>? favoriteList = box.get(DBKey.favoriteList);

    if (favoriteList == null) {
      favoriteList = [];
      if (newFavorite) {
        favoriteList.add(id);
      }
    } else {
      if (newFavorite) {
        favoriteList.add(id);
      } else {
        favoriteList.removeWhere((element) => element == id);
      }
    }
    box.put(DBKey.favoriteList, favoriteList);
  }

  get favoriteList async => (await _box).get(DBKey.favoriteList);

  isFavorite(String id) async {
    List<String>? favoriteList = (await _box).get(DBKey.favoriteList);
    return favoriteList?.contains(id) ?? false;
  }
}
