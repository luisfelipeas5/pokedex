import 'package:json_annotation/json_annotation.dart';

import 'Type.dart';

part 'DamageRelations.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DamageRelations {
  final List<PokeType> noDamageTo;
  final List<PokeType> halfDamageTo;
  final List<PokeType> doubleDamageTo;
  final List<PokeType> noDamageFrom;
  final List<PokeType> halfDamageFrom;
  final List<PokeType> doubleDamageFrom;

  DamageRelations(this.noDamageTo, this.halfDamageTo, this.doubleDamageTo, this.noDamageFrom, this.halfDamageFrom, this.doubleDamageFrom);

  factory DamageRelations.fromJson(Map<String, dynamic> json) => _$DamageRelationsFromJson(json);

  Map<String, dynamic> toJson() => _$DamageRelationsToJson(this);

}