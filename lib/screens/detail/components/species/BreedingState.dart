import 'package:flutter/foundation.dart';
import 'package:pokedex/model/species/Species.dart';

@immutable
abstract class BreedingState {}

class LoadingBreedingState extends BreedingState {}

class LoadedBreedingState extends BreedingState {
  final Species species;

  LoadedBreedingState(this.species);
}