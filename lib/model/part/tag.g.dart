// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      regDateTimestamp: json['regDateTimestamp'] as int?,
      name: json['name'],
      iconCodePoint: json['iconCodePoint'],
      authorUID: json['authorUID'] as String?,
      tagType: json['tagType'],
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'regDateTimestamp': instance.regDateTimestamp,
      'name': instance.name,
      'iconCodePoint': instance.iconCodePoint,
      'authorUID': instance.authorUID,
      'tagType': _$TagTypeEnumMap[instance.tagType]!,
    };

const _$TagTypeEnumMap = {
  TagType.location: 'location',
  TagType.event: 'event',
};
