import 'package:flutter/material.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:pokedex/model/Repository.dart';
import 'package:pokedex/screens.pokemons/PokemonsPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ],
        child: MaterialApp(
          title: 'Pokedex',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: PokemonsPage(),
        )
    );
  }
}