import 'package:json_annotation/json_annotation.dart';

part 'EggGroup.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EggGroup {
  final String name;

  EggGroup(this.name);

  factory EggGroup.fromJson(Map<String, dynamic> json) => _$EggGroupFromJson(json);
  Map<String, dynamic> toJson() => _$EggGroupToJson(this);

}