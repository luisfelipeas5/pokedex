import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/router/routes/RoutePath.dart';
import 'package:pokedex/screens/detail/PokemonPage.dart';
import 'package:pokedex/screens/list/PokemonsPage.dart';
import 'package:pokedex/extensions/ListExtensions.dart';

import 'RouterState.dart';

class MyRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {

  final List<MaterialPage> _pages = [];
  RouterState routerState;

  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate(this.routerState) : navigatorKey = GlobalKey<NavigatorState>() {
    routerState.addListener(() {
      notifyListeners();
    });
  }

  @override
  RoutePath? get currentConfiguration => routerState.routePaths.lastOrNull;

  @override
  Future<void> setNewRoutePath(RoutePath configuration) {
    routerState.push(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _buildPages(),
    );
  }

  List<Page> _buildPages() {
    switch (routerState.action) {
      case RouterAction.PUSH:
        final routePath = currentConfiguration;
        if (routePath is DetailRoutePath) {
          _pages.add(_buildDetailPages(routePath));
        } else {
          _pages.add(_buildListPage());
        }
        break;
      case RouterAction.POP:
        _pages.removeLast();
        break;
    }

    return List.of(_pages);
  }

  MaterialPage _buildDetailPages(DetailRoutePath routePath) {
    final pokemon = routePath.pokemon;
    final number = routePath.number;

    var pokemonPage = pokemon != null ?
              PokemonPage.fromPokemon(pokemon) : PokemonPage.fromNumber(number);

    return MaterialPage(
        key: ValueKey(DetailRoutePath.KEY),
        name: DetailRoutePath.PATH,
        child: pokemonPage
    );
  }

  MaterialPage _buildListPage() {
    return MaterialPage(
      key: ValueKey(ListRoutePath.KEY),
      name: ListRoutePath.PATH,
      child: PokemonsPage()
    );
  }
}