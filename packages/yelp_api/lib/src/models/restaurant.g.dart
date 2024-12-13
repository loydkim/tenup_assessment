// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Restaurant',
      json,
      ($checkedConvert) {
        final val = Restaurant(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          price: $checkedConvert('price', (v) => v as String?),
          rating: $checkedConvert('rating', (v) => (v as num?)?.toDouble()),
          photos: $checkedConvert('photos',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          categories: $checkedConvert(
              'categories',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
                  .toList()),
          hours: $checkedConvert(
              'hours',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Hours.fromJson(e as Map<String, dynamic>))
                  .toList()),
          reviews: $checkedConvert(
              'reviews',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
                  .toList()),
          location: $checkedConvert(
              'location',
              (v) => v == null
                  ? null
                  : Location.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'rating': instance.rating,
      'photos': instance.photos,
      'categories': instance.categories,
      'hours': instance.hours,
      'reviews': instance.reviews,
      'location': instance.location,
    };

RestaurantQueryResult _$RestaurantQueryResultFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RestaurantQueryResult',
      json,
      ($checkedConvert) {
        final val = RestaurantQueryResult(
          total: $checkedConvert('total', (v) => (v as num?)?.toInt()),
          restaurants: $checkedConvert(
              'business',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'restaurants': 'business'},
    );

Map<String, dynamic> _$RestaurantQueryResultToJson(
        RestaurantQueryResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'business': instance.restaurants,
    };
