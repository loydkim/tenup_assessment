// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hours _$HoursFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Hours',
      json,
      ($checkedConvert) {
        final val = Hours(
          isOpenNow: $checkedConvert('is_open_now', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {'isOpenNow': 'is_open_now'},
    );

Map<String, dynamic> _$HoursToJson(Hours instance) => <String, dynamic>{
      'is_open_now': instance.isOpenNow,
    };
