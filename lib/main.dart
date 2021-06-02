import 'package:flutter/material.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:pokedex/model/Repository.dart';
import 'package:pokedex/router/MyRouterDelegate.dart';
import 'package:pokedex/router/RouterState.dart';
import 'package:provider/provider.dart';

import 'router/MyRouteInformationParser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routeInformationParser = MyRouteInformationParser();
  final RouterState routerState;
  late final MyRouterDelegate routerDelegate;

  MyApp(): routerState = RouterState() {
    routerDelegate = MyRouterDelegate(routerState);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: Repository()),
          ProxyProvider<Repository, PokemonsBloc>(
            create: (_) => PokemonsBloc(),
            update: (context, repository, pokemonsBloc) {
              pokemonsBloc!.repository = repository;
              return pokemonsBloc;
            },
            dispose: (_, __) {
              final bloc = Provider.of<PokemonsBloc>(context, listen: false);
              bloc.dispose();
            }),
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
          routerDelegate: routerDelegate,
        )
    );
  }
}