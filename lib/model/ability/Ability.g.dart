// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbilitySlot _$AbilitySlotFromJson(Map<String, dynamic> json) {
  return AbilitySlot(
    json['ability'] == null
        ? null
        : Ability.fromJson(json['ability'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AbilitySlotToJson(AbilitySlot instance) =>
    <String, dynamic>{
      'ability': instance.ability,
    };

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return Ability(
    json['name'] as String?,
  );
}

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
    };
