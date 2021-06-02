
import 'package:flutter/cupertino.dart';
import 'package:pokedex/screens/detail/DetailRoutePath.dart';
import 'package:pokedex/screens/list/ListRoutePath.dart';

import 'routes/RoutePath.dart';

enum RouterAction {
  PUSH, POP, DEEP_LINK
}

class RouterState extends ChangeNotifier {

  var action = RouterAction.PUSH;
  final routePaths = List<RoutePath>.of([ListRoutePath()], growable: true);

  push(RoutePath routePath) {
    action = RouterAction.PUSH;
    _add(routePath);
    notifyListeners();
  }

  bool pop() {
    final canPop = _canPop();
    if (canPop) {
      action = RouterAction.POP;
      routePaths.removeLast();
      notifyListeners();
    }
    return canPop;
  }

  bool _canPop() {
    return routePaths.length > 1;
  }

  void deepLinkPush(RoutePath routePath) {
    action = RouterAction.DEEP_LINK;

    routePaths.clear();
    _buildBackStack(routePath);
    _add(routePath);

    notifyListeners();
  }

  _buildBackStack(RoutePath routePath) {
    if (routePath is DetailRoutePath) {
      _add(ListRoutePath());
    } else if (routePath is ListRoutePath) {
      //Nothing on backstack
    }
  }

  _add(RoutePath routePath) => routePaths.add(routePath);

}