import 'package:flutter/cupertino.dart';
import 'package:pokedex/router/routes/RoutePath.dart';

import 'PokemonsPage.dart';

class ListRoutePath extends RoutePath {
  static const KEY = "PokemonsList";
  static const PATH = "/";
  @override
  String get path => PATH;
  @override
  String get key => KEY;

  @override
  Widget get widget => PokemonsPage();

}