import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/router/routes/RoutePath.dart';
import 'package:pokedex/extensions/ListExtensions.dart';
import 'package:pokedex/screens/list/ListRoutePath.dart';

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
    routerState.deepLinkPush(configuration);
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
      case RouterAction.POP:
        _onPopAction();
        break;
      case RouterAction.PUSH:
      case RouterAction.DEEP_LINK:
        _onDeepLinkAction();
        break;
    }
    return List.of(_pages);
  }

  _onPopAction() {
    _pages.removeLast();
  }

  _onPushAction() {
    final routePath = currentConfiguration ?? ListRoutePath();
    MaterialPage page = _getMaterialPage(routePath);
    _pages.add(page);
  }

  _onDeepLinkAction() {
    final pages = routerState.routePaths.map(
            (routePath) => _getMaterialPage(routePath)
    );

    _pages.clear();
    _pages.addAll(pages);
  }

  MaterialPage _getMaterialPage(RoutePath routePath) {
    return MaterialPage(
        key: ValueKey(routePath.key),
        name: routePath.path,
        child: routePath.widget
    );
  }
}