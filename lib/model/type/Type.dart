import 'package:json_annotation/json_annotation.dart';

part 'Type.g.dart';

@JsonSerializable()
class TypeSlot {
  final PokeType type;

  TypeSlot(this.type);

  factory TypeSlot.fromJson(Map<String, dynamic> json) => _$TypeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TypeSlotToJson(this);
}

@JsonSerializable()
class PokeType {
  final String name;

  PokeType(this.name);

  factory PokeType.fromJson(Map<String, dynamic> json) => _$PokeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PokeTypeToJson(this);
}