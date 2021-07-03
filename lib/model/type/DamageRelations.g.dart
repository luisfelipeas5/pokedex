// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DamageRelations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DamageRelations _$DamageRelationsFromJson(Map<String, dynamic> json) {
  return DamageRelations(
    (json['no_damage_to'] as List<dynamic>)
        .map((e) => PokeType.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['half_damage_to'] as List<dynamic>)
        .map((e) => PokeType.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['double_damage_to'] as List<dynamic>)
        .map((e) => PokeType.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['no_damage_from'] as List<dynamic>)
        .map((e) => PokeType.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['half_damage_from'] as List<dynamic>)
        .map((e) => PokeType.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['double_damage_from'] as List<dynamic>)
        .map((e) => PokeType.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DamageRelationsToJson(DamageRelations instance) =>
    <String, dynamic>{
      'no_damage_to': instance.noDamageTo,
      'half_damage_to': instance.halfDamageTo,
      'double_damage_to': instance.doubleDamageTo,
      'no_damage_from': instance.noDamageFrom,
      'half_damage_from': instance.halfDamageFrom,
      'double_damage_from': instance.doubleDamageFrom,
    };
