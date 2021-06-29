// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
    json['id'] as int,
    json['name'] as String,
    image: json['image'] as String?,
    types: (json['types'] as List<dynamic>?)
        ?.map((e) => TypeSlot.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..height = json['height'] as int?
    ..weight = json['weight'] as int?
    ..abilities = (json['abilities'] as List<dynamic>?)
        ?.map((e) => AbilitySlot.fromJson(e as Map<String, dynamic>))
        .toList()
    ..stats = (json['stats'] as List<dynamic>?)
        ?.map((e) => StatSlot.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'types': instance.types,
      'height': instance.height,
      'image': instance.image,
      'weight': instance.weight,
      'abilities': instance.abilities,
      'stats': instance.stats,
    };
