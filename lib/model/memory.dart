import 'package:i_dont_remember/interface/identifiable.dart';
import 'package:i_dont_remember/interface/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';

part 'part/memory.g.dart';

@JsonSerializable()
class Memory implements JSONSerializable, Identifiable {
  final int regDateTimestamp;
  final String? photoURL;
  final Tag? tag;
  final String name, description;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  Memory({int? regDateTimestamp, this.tag, this.photoURL, name, description})
      : regDateTimestamp =
      regDateTimestamp ?? DateTime.now().millisecondsSinceEpoch,
        name = name ?? 'none',
        description = description ?? '';

  get dateReg => DateTime.fromMillisecondsSinceEpoch(regDateTimestamp);

  @override
  factory Memory.fromJson(Map<String, dynamic> json) =>
      _$MemoryFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$MemoryToJson(this);
}
