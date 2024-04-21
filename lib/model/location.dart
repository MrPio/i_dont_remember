import 'package:i_dont_remember/interface/identifiable.dart';
import 'package:i_dont_remember/interface/json_serializable.dart';
import 'package:i_dont_remember/model/memory.dart';
import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';

part 'part/location.g.dart';

@JsonSerializable()
class Location extends Memory implements JSONSerializable, Identifiable  {

  Location({super.regDateTimestamp, super.tag, super.photoURL, super.name, super.description}){
    assert(tag == null || tag!.tagType == TagType.location);
  }

  @override
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$LocationToJson(this);
}
