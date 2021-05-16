import 'package:flutter/material.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:provider/provider.dart';

class PokemonsPage extends StatefulWidget {
  @override
  State createState() => _PokemonsPage();
}

class _PokemonsPage extends State<PokemonsPage> {

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    bloc.loadPokemons();

    return StreamBuilder<List<Pokemon>>(
      stream: bloc.pokemonsStreamController,
      initialData: [],
      builder: (context, snapshot) {
        var pokemons = snapshot.data;
        return PokemonList(pokemons);
      }
    );
  }

}

class PokemonList extends StatelessWidget {

  final List<Pokemon> pokemons;

  PokemonList(this.pokemons): super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Pokedex"),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
              ),
              itemBuilder: (_, index) => PokemonListItem(pokemons[index]),
              itemCount: pokemons.length,
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonListItem extends StatelessWidget {

  PokemonListItem(this.pokemon, {Key key}): super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(pokemon.name),
        SvgPicture.asset(pokemon.image, width: 80, height: 80),
      ],
    );
  }
}