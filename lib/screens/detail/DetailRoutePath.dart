import 'package:flutter/cupertino.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:pokedex/router/routes/RoutePath.dart';
import 'package:pokedex/extensions/ListExtensions.dart';

import 'PokemonPage.dart';

class DetailRoutePath extends RoutePath {
  static const KEY = "PokemonDetail";
  static const PATH = "/pokemon";

  final Pokemon? pokemon;
  final int? number;

  factory DetailRoutePath.fromPokemon(Pokemon pokemon) {
    return DetailRoutePath._internal(pokemon: pokemon, number: pokemon.id);
  }

  factory DetailRoutePath.fromNumber(int number) {
    return DetailRoutePath._internal(number: number);
  }

  DetailRoutePath._internal({this.pokemon, this.number});

  @override
  String get path => PATH;
  @override
  Object? get state => pokemon;
  @override
  String get key {
    var number = (this.number??pokemon?.id).toString();
    return KEY + " " + number;
  }
  @override
  Widget get widget {
    var pokemonPage = PokemonPage.fromNumber(number);

    final pokemon = this.pokemon;
    if (pokemon != null) {
      pokemonPage = PokemonPage.fromPokemon(pokemon);
    }

    return pokemonPage;
  }

  factory DetailRoutePath.fromRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location??"");
    var state = routeInformation.state;

    var argument = uri.pathSegments.getOrNull(1);
    if (state is Pokemon) {
      return DetailRoutePath.fromPokemon(state);
    } else if (state is int) {
      return DetailRoutePath.fromNumber(state);
    } else if (argument != null) {
      return DetailRoutePath.fromNumber(int.parse(argument));
    }
    return DetailRoutePath._internal();
  }

}