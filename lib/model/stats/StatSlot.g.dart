// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatSlot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatSlot _$StatSlotFromJson(Map<String, dynamic> json) {
  return StatSlot(
    json['base_stat'] as int,
    Stat.fromJson(json['stat'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StatSlotToJson(StatSlot instance) => <String, dynamic>{
      'base_stat': instance.baseStat,
      'stat': instance.stat,
    };

Stat _$StatFromJson(Map<String, dynamic> json) {
  return Stat(
    json['name'] as String,
  );
}

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'name': instance.name,
    };
