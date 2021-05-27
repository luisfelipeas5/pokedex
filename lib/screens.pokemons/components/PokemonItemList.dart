import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/model/Pokemon.dart';

class PokemonListItem extends StatelessWidget {
  PokemonListItem(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final numberFormatted = '#' + pokemon.number.toString().padLeft(3, '0');

    return Container(
      decoration: BoxDecoration(
        color: pokemon.getColor(),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            numberFormatted,
            textAlign: TextAlign.end,
          ),
          Text(
            pokemon.name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: PokemonListType(pokemon.types ?? [])),
                Expanded(
                  child: SvgPicture.network(
                    pokemon.image ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonListType extends StatelessWidget {
  PokemonListType(this.types, {Key? key}) : super(key: key);

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20 * types.length.toDouble(),
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Text(types[index]);
        },
        itemCount: types.length,
      ),
    );
  }
}
