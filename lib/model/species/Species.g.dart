// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Species.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Species _$SpeciesFromJson(Map<String, dynamic> json) {
  return Species(
    (json['egg_groups'] as List<dynamic>)
        .map((e) => EggGroup.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['gender_rate'] as int,
  );
}

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
      'egg_groups': instance.eggGroups,
      'gender_rate': instance.genderRate,
    };
