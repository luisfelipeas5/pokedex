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
    bloc.loadMorePokemons();

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

  final List<Pokemon>? pokemons;

  PokemonList(this.pokemons): super();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pokedex", style: TextStyle(fontSize: 24),),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2
                  ),
                  itemBuilder: (_, index) {
                    bloc.onIndexBuilt(index);
                    return PokemonListItem(pokemons![index]);
                  },
                  itemCount: pokemons!.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonListItem extends StatelessWidget {

  PokemonListItem(this.pokemon, {Key? key}): super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pokemon.getColor(),
      child: Column(
        children: [
          Text(pokemon.name!),
          SvgPicture.network(pokemon.image!, width: 80, height: 80),
        ],
      ),
    );
  }
}