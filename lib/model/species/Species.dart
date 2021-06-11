import 'package:json_annotation/json_annotation.dart';
import 'EggGroup.dart';

part 'Species.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Species {

  final List<EggGroup> eggGroups;
  final int genderRate;

  Species(this.eggGroups, this.genderRate);

  factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesToJson(this);
  
  String? get eggGroupsToString => eggGroups.map((e) => e.name).join(", ");
  
  double get femaleRate => genderRate * (100.0/8.0);
  double get maleRate => 100.0 - femaleRate;

}