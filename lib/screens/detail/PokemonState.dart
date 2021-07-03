
import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';

@immutable
abstract class PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {

  final Pokemon pokemon;

  PokemonLoadedState(this.pokemon);

}