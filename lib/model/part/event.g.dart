// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      regDateTimestamp: json['regDateTimestamp'] as int?,
      tag: json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
      photoURL: json['photoURL'] as String?,
      name: json['name'],
      description: json['description'],
      reminderTimestamp: json['reminderTimestamp'] as int?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'regDateTimestamp': instance.regDateTimestamp,
      'photoURL': instance.photoURL,
      'tag': instance.tag,
      'name': instance.name,
      'description': instance.description,
      'reminderTimestamp': instance.reminderTimestamp,
    };
