// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../memory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memory _$MemoryFromJson(Map<String, dynamic> json) => Memory(
      regDateTimestamp: json['regDateTimestamp'] as int?,
      tag: json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
      photoURL: json['photoURL'] as String?,
      name: json['name'],
      description: json['description'],
    );

Map<String, dynamic> _$MemoryToJson(Memory instance) => <String, dynamic>{
      'regDateTimestamp': instance.regDateTimestamp,
      'photoURL': instance.photoURL,
      'tag': instance.tag,
      'name': instance.name,
      'description': instance.description,
    };
