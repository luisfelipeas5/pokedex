// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeSlot _$TypeSlotFromJson(Map<String, dynamic> json) {
  return TypeSlot(
    PokeType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TypeSlotToJson(TypeSlot instance) => <String, dynamic>{
      'type': instance.type,
    };

PokeType _$PokeTypeFromJson(Map<String, dynamic> json) {
  return PokeType(
    json['name'] as String,
  );
}

Map<String, dynamic> _$PokeTypeToJson(PokeType instance) => <String, dynamic>{
      'name': instance.name,
    };
