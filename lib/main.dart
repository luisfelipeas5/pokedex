import 'package:flutter/material.dart';
import 'package:pokedex/screens/list/PokemonsBloc.dart';
import 'package:pokedex/repositories/Repository.dart';
import 'package:pokedex/router/MyRouterDelegate.dart';
import 'package:pokedex/router/RouterState.dart';
import 'package:provider/provider.dart';

import 'router/MyBackButtonDispatcher.dart';
import 'router/MyRouteInformationParser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routeInformationParser = MyRouteInformationParser();
  final RouterState routerState;
  late final MyRouterDelegate routerDelegate;
  late final MyBackButtonDispatcher backButtonDispatcher;

  MyApp(): routerState = RouterState() {
    routerDelegate = MyRouterDelegate(routerState);
    backButtonDispatcher = MyBackButtonDispatcher(routerState);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: Repository()),
          ChangeNotifierProvider.value(value: routerState)
        ],
        child: MaterialApp.router(
          title: 'Pokedex',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
              headline3: TextStyle(color: Colors.white, fontSize: 36)
            )
          ),
          routeInformationParser: routeInformationParser,
          backButtonDispatcher: backButtonDispatcher,
          routerDelegate: routerDelegate,
        )
    );
  }
}