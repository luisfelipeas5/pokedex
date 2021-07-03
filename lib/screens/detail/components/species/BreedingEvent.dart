
import 'package:flutter/foundation.dart';

@immutable
abstract class BreedingEvent {}

class LoadBreedingEvent extends BreedingEvent {
  final int pokemonNumber;

  LoadBreedingEvent(this.pokemonNumber);
}