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
    final routePath = currentConfiguration;
    if (routePath is DetailRoutePath) {
      return _buildDetailPages(routePath);
    } else {
      return _buildListPages();
    }
  }

  List<Page> _buildListPages() {
    return [_buildListPage()];
  }

  List<Page> _buildDetailPages(DetailRoutePath routePath) {
    return [
      _buildListPage(),
      MaterialPage(
          key: ValueKey(DetailRoutePath.KEY),
          name: DetailRoutePath.PATH,
          child: PokemonPage(routePath.pokemon))
    ];
  }

  MaterialPage _buildListPage() {
    return MaterialPage(
      key: ValueKey(ListRoutePath.KEY),
      name: ListRoutePath.PATH,
      child: PokemonsPage()
    );
  }
}