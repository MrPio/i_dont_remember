// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      nickname: json['nickname'] as String? ?? 'Anonimo',
      email: json['email'] as String? ?? '',
      regDateTimestamp: json['regDateTimestamp'] as int?,
      locationUIDs: json['locationUIDs'],
      eventUIDs: json['eventUIDs'],
      tagUIDs: json['tagUIDs'],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'email': instance.email,
      'regDateTimestamp': instance.regDateTimestamp,
      'locationUIDs': instance.locationUIDs,
      'eventUIDs': instance.eventUIDs,
      'tagUIDs': instance.tagUIDs,
    };
