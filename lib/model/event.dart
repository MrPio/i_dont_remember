import 'package:i_dont_remember/interface/identifiable.dart';
import 'package:i_dont_remember/interface/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'memory.dart';
import 'tag.dart';

part 'part/event.g.dart';

@JsonSerializable()
class Event extends Memory implements JSONSerializable, Identifiable {
  final int? reminderTimestamp;

  Event(
      {super.regDateTimestamp,
      super.tag,
      super.photoURL,
      super.name,
      super.description,
      this.reminderTimestamp}) {
    assert(tag == null || tag!.tagType == TagType.event);
  }

  @override
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$EventToJson(this);
}
