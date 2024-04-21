import 'package:i_dont_remember/interface/identifiable.dart';
import 'package:i_dont_remember/interface/json_serializable.dart';
import 'package:i_dont_remember/model/event.dart';
import 'package:i_dont_remember/model/tag.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location.dart';
import 'memory.dart';

part 'part/user.g.dart';

@JsonSerializable()
class User implements JSONSerializable, Identifiable {
  final String nickname, email;
  final int regDateTimestamp;
  final List<String> locationUIDs, eventUIDs, tagUIDs;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Memory> memories = [];

  get locations => memories.whereType<Location>() as List<Event>;

  get events => memories.whereType<Event>() as List<Event>;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Tag> tags = [];

  User(
      {this.nickname = 'Anonimo',
      this.email = '',
      int? regDateTimestamp,
      locationUIDs,
      eventUIDs,
      tagUIDs})
      : regDateTimestamp =
            regDateTimestamp ?? DateTime.now().millisecondsSinceEpoch,
        locationUIDs = locationUIDs ?? [],
        eventUIDs = eventUIDs ?? [],
        tagUIDs = tagUIDs ?? [];

  get dateReg => DateTime.fromMillisecondsSinceEpoch(regDateTimestamp);

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$UserToJson(this);
}
