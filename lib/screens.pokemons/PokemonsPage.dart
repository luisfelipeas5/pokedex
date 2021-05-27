import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:provider/provider.dart';

import 'components/PokemonItemList.dart';

class PokemonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Pokedex",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
        body: PokemonList());
  }
}

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    bloc.loadMorePokemons();
    return StreamBuilder<List<Pokemon>>(
        stream: bloc.pokemonsStreamController,
        initialData: [],
        builder: (context, snapshot) {
          final pokemons = snapshot.data ?? [];
          return SafeArea(
            child: Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(top: 12, right: 16, left: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
                itemBuilder: (_, index) {
                  bloc.onIndexBuilt(index);
                  return PokemonListItem(pokemons[index]);
                },
                itemCount: pokemons.length,
              ),
            ),
          );
        });
  }
}
