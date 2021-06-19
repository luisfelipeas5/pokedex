import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';
import 'package:pokedex/router/components/MyBackButton.dart';
import 'package:pokedex/screens/detail/PokemonBody.dart';
import 'package:pokedex/screens/detail/PokemonEvent.dart';
import 'package:pokedex/screens/detail/PokemonState.dart';
import 'package:pokedex/screens/detail/components/BasicData.dart';
import 'package:provider/provider.dart';

import 'PokemonBloc.dart';

class PokemonPage extends StatefulWidget {
  factory PokemonPage.fromNumber(int? number) {
    return PokemonPage(
      number: number,
    );
  }

  factory PokemonPage.fromPokemon(Pokemon pokemon) {
    return PokemonPage(
      pokemon: pokemon,
    );
  }

  PokemonPage({this.pokemon, this.number, Key? key}) : super(key: key);

  final Pokemon? pokemon;
  final int? number;

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final _pokemonBloc = PokemonBloc();

  @override
  void initState() {
    super.initState();
    _pokemonBloc.repository = Provider.of<Repository>(context, listen: false);
    _pokemonBloc.add(PokemonLoadEvent(widget.number, widget.pokemon));
  }

  @override
  void dispose() {
    _pokemonBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _pokemonBloc,
      child: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
        if (state is PokemonLoadingState) {
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
                height: 48, width: 48, child: CircularProgressIndicator()),
          );
        }
        final pokemon = _pokemonBloc.pokemon;
        if (pokemon == null) return Container();

        return Scaffold(
          appBar: AppBar(
            leading: MyBackButton(),
            backgroundColor: pokemon.getColor(),
            elevation: 0,
          ),
          body: Container(
            color: pokemon.getColor(),
            child: Column(
              children: [
                BasicData(pokemon),
                PokemonBody(pokemon),
              ],
            ),
          ),
        );
      }),
    );
  }

}
