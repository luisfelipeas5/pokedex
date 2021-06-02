import 'package:flutter/material.dart';
import 'package:pokedex/model/Pokemon.dart';

@immutable
abstract class PokemonsState {}

class PokemonsLoadingState extends PokemonsLoadedState {
  final List<Pokemon> pokemons;
  int get pokemonsLength => pokemons.length;

  PokemonsLoadingState(this.pokemons): super(pokemons);
}

class PokemonsLoadedState extends PokemonsState {
  final List<Pokemon> pokemons;

  PokemonsLoadedState(this.pokemons);
}

class PokemonsLoadedFailedState extends PokemonsState {

}