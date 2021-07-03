import 'package:flutter/foundation.dart';

@immutable
abstract class TypeDefensesEvent {}

class LoadTypeDefensesEvent extends TypeDefensesEvent {
  final int pokemonNumber;

  LoadTypeDefensesEvent(this.pokemonNumber);
}