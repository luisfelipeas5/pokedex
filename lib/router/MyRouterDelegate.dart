import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/router/routes/RoutePath.dart';
import 'package:pokedex/extensions/ListExtensions.dart';
import 'package:pokedex/screens/list/ListRoutePath.dart';

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
    routerState.deepLinkPush(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _buildPages(),
      onPopPage: (router, result) {
        return routerState.pop();
      },
    );
  }

  List<Page> _buildPages() {
    return routerState.routePaths.map((e) => _getMaterialPage(e)).toList();
  }

  MaterialPage _getMaterialPage(RoutePath routePath) {
    return MaterialPage(
        key: ValueKey(routePath.key),
        name: routePath.path,
        child: routePath.widget
    );
  }
}