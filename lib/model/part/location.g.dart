// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      regDateTimestamp: json['regDateTimestamp'] as int?,
      tag: json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
      photoURL: json['photoURL'] as String?,
      name: json['name'],
      description: json['description'],
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'regDateTimestamp': instance.regDateTimestamp,
      'photoURL': instance.photoURL,
      'tag': instance.tag,
      'name': instance.name,
      'description': instance.description,
    };
