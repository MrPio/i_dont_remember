import 'package:flutter/material.dart';
import 'package:i_dont_remember/interface/identifiable.dart';
import 'package:i_dont_remember/interface/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part/tag.g.dart';

enum TagType { location, event }

@JsonSerializable()
class Tag implements JSONSerializable, Identifiable {
  final int regDateTimestamp;
  final String name;
  final int iconCodePoint;
  final String? authorUID;
  final TagType tagType;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  Tag({int? regDateTimestamp, name, iconCodePoint, this.authorUID, tagType})
      : regDateTimestamp =
            regDateTimestamp ?? DateTime.now().millisecondsSinceEpoch,
        name = name ?? 'Default',
        iconCodePoint = iconCodePoint ?? Icons.home_rounded.codePoint,
        tagType = tagType ?? TagType.location;

  get dateReg => DateTime.fromMillisecondsSinceEpoch(regDateTimestamp);

  get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  @override
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$TagToJson(this);
}
