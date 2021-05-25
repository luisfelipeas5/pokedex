import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        });
  }
}

class PokemonList extends StatelessWidget {
  final List<Pokemon>? pokemons;

  PokemonList(this.pokemons) : super();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pokedex",
                style: TextStyle(fontSize: 24),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
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
  PokemonListItem(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: pokemon.getColor(),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Text(pokemon.name),
          ),
          Row(
            children: [
              Expanded(child: PokemonListType(pokemon.types??[])),
              Expanded(
                  child: SvgPicture.network(pokemon.image ?? "", width: 80)
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PokemonListType extends StatelessWidget {
  PokemonListType(this.types, {Key? key}): super(key: key);

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Text(types.first);
  }
}
