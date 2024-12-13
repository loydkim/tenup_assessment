// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Location',
      json,
      ($checkedConvert) {
        final val = Location(
          formattedAddress:
              $checkedConvert('formatted_address', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'formattedAddress': 'formatted_address'},
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'formatted_address': instance.formattedAddress,
    };
