import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/router/RouterState.dart';

class MyBackButtonDispatcher extends RootBackButtonDispatcher {
  // 2
  final RouterState routerState;

  MyBackButtonDispatcher(this.routerState) : super();

  // 3
  Future<bool> didPopRoute() {
    routerState.pop();
    return SynchronousFuture(true);
  }
}