
import 'package:flutter/cupertino.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';

@immutable
abstract class PokemonEvent {}

class PokemonLoadEvent extends PokemonEvent {
  final Pokemon? pokemon;
  final int? number;

  PokemonLoadEvent(this.number, this.pokemon);
}