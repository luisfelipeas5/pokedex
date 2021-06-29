
import 'package:json_annotation/json_annotation.dart';

part 'StatSlot.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StatSlot {
  final int baseStat;
  final Stat stat;

  StatSlot(this.baseStat, this.stat);

  factory StatSlot.fromJson(Map<String, dynamic> json) => _$StatSlotFromJson(json);

  Map<String, dynamic> toJson() => _$StatSlotToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Stat {
  final String name;

  Stat(this.name);

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);
}