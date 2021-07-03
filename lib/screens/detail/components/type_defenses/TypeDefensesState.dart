import 'package:flutter/foundation.dart';
import 'package:pokedex/model/type/DamageRelations.dart';

@immutable
abstract class TypeDefensesState {}

class LoadingTypeDefensesState extends TypeDefensesState {}

class LoadedTypeDefensesState extends TypeDefensesState {
  final DamageRelations damageRelations;

  LoadedTypeDefensesState(this.damageRelations);
}