
import 'package:flutter/cupertino.dart';

import 'routes/RoutePath.dart';

enum RouterAction {
  PUSH, POP
}

class RouterState extends ChangeNotifier {

  var action = RouterAction.PUSH;
  final routePaths = List<RoutePath>.empty(growable: true);

  push(RoutePath routePath) {
    action = RouterAction.PUSH;
    routePaths.add(routePath);

    notifyListeners();
  }

  void pop() {
    action = RouterAction.POP;
    routePaths.removeLast();
    notifyListeners();
  }

}