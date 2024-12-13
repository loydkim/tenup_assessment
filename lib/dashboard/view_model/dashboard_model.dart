import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tenup_project/dashboard/view_model/dashboard_handler.dart';
import 'package:yelp_api/yelp_api.dart';

class DashboardModel extends DashboardHandler with ChangeNotifier {
  bool _isLoading;
  int _listCount;

  DashboardModel({List<Restaurant>? restaurants})
      : _isLoading = restaurants == null,
        _listCount = 7,
        super(restaurants: restaurants) {
    if (restaurants == null) {
      getRestaurants();
    }
  }

  void increaseListCount() {
    _listCount = min(_listCount + 7, restaurants.length);
    notifyListeners();
  }

  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  Future<void> getRestaurants() async {
    setLoading(true);
    await fetchRestaurantAndSave();
    setLoading(false);
  }

  bool get isLoading => _isLoading;

  int get listCount => _listCount;
}
