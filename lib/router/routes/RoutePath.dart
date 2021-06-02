
import 'package:pokedex/model/Pokemon.dart';

abstract class RoutePath {
  String get path;
  Object? get state => null;
}

class ListRoutePath extends RoutePath {
  static const KEY = "PokemonsList";
  static const PATH = "/";
  @override
  String get path => PATH;
}

class DetailRoutePath extends RoutePath {
  static const KEY = "PokemonDetail";
  static const PATH = "/pokemon";

  final Pokemon pokemon;

  DetailRoutePath(this.pokemon);

  @override
  String get path => PATH;
  @override
  Object? get state => pokemon;
}