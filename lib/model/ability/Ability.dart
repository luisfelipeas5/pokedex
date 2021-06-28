
import 'package:json_annotation/json_annotation.dart';

part 'Ability.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AbilitySlot {
  final Ability? ability;

  // AbilitySlot._internal();

  AbilitySlot(this.ability);

  factory AbilitySlot.fromJson(Map<String, dynamic> json) => _$AbilitySlotFromJson(json);

  Map<String, dynamic> toJson() => _$AbilitySlotToJson(this);

  // factory AbilitySlot.fromJson(Map<String, dynamic> json) {
  //   var abilitySlot = AbilitySlot._internal();
  //   abilitySlot.ability = Ability.fromJson(json["ability"]);
  //   return abilitySlot;
  // }

}


@JsonSerializable(fieldRename: FieldRename.snake)
class Ability {
  final String? name;

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);

  Ability(this.name);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);

  // Ability._internal();
  //
  // factory Ability.fromJson(Map<String, dynamic> json) {
  //   var ability = Ability._internal();
  //   ability.name = json["name"];
  //   return ability;
  // }
}