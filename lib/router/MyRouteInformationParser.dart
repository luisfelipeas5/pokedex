import 'package:flutter/cupertino.dart';
import 'package:pokedex/model/Pokemon.dart';

import 'routes/RoutePath.dart';
import 'package:pokedex/extensions/ListExtensions.dart';

class MyRouteInformationParser extends RouteInformationParser<RoutePath> {

  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location??"");

    var page = uri.pathSegments.first;

    switch ("/" + page) {
      case ListRoutePath.PATH:
        return ListRoutePath();

      case DetailRoutePath.PATH:
        var state = routeInformation.state;
        var argument = uri.pathSegments.getOrNull(1);
        if (state is Pokemon) {
          return DetailRoutePath.fromPokemon(state);
        } else if (state is int) {
          return DetailRoutePath.fromNumber(state);
        } else if (argument != null) {
          return DetailRoutePath.fromNumber(int.parse(argument));
        }
        break;
    }

    return ListRoutePath();
  }

  @override
  RouteInformation? restoreRouteInformation(RoutePath configuration) {
    return RouteInformation(location: configuration.path, state: configuration.state);
  }

}