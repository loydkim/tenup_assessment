import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yelp_api/src/models/restaurant.dart';

/// Yelp API Errors
/// https://docs.developer.yelp.com/docs/api-errors
class APIRequestFieldRequiredFailure implements Exception {}

class APIUnauthorizedFailure implements Exception {}

class APIInternalServerErrorFailure implements Exception {}

/// Exception thrown when RestaurantRequest fails.
class RestaurantRequestFailure implements Exception {}

// From yelp for developers.
const _apiKey =
    'pFOpoemAaDeXkHTfJ1lxZXEL1MGobTl_TXm71fKyT4HfZm9Lw52jTR9Ko2Ds37yWsNz3vWWCO2gI8C1vbOy3SjEuL8ltOltuEaSHmCaRxoYM6TEcTGrN_uf0qcajYnYx';

/// {@template yelp_api_client}
/// Dart API Client which wraps the [Yelp API](https://www.yelp.com/developers/v3/manage_app).
/// {@endtemplate}
class YelpApiClient {
  late Dio dio;

  YelpApiClient({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer $_apiKey',
                  'Content-Type': 'application/graphql'
                },
              ),
            );

  Future<List<Restaurant>> getRestaurants({int offset = 0}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );

      /// Yelp API Errors
      /// https://docs.developer.yelp.com/docs/api-errors
      if (response.statusCode == 400) {
        throw APIRequestFieldRequiredFailure();
      }

      if (response.statusCode == 401) {
        throw APIUnauthorizedFailure();
      }

      if (response.statusCode == 401) {
        throw APIInternalServerErrorFailure();
      }

      if (response.statusCode != 200) {
        throw RestaurantRequestFailure();
      }

      if (response.data == null) return [];

      return RestaurantQueryResult.fromJson(response.data?['data']['search'])
              .restaurants ??
          [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String _getQuery(int offset) {
    //Las Vegas
    return '''
query getRestaurants {
  search(location: "Roseville", limit: 10, offset: $offset) {
    total    
    business {
      id
      name
      price
      rating
      photos
      reviews {
        id
        rating
        user {
          id
          image_url
          name
        }
      }
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
      location {
        formatted_address
      }
    }
  }
}
''';
  }
}
