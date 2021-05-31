import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/screens/list/components/PokemonListType.dart';

class PokemonPage extends StatelessWidget {

  const PokemonPage(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: pokemon.getColor(),
        elevation: 0,
      ),
      body: Container(
        color: pokemon.getColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(pokemon.name),
            PokemonListType(pokemon, vertical: false,),
            Text(pokemon.getNumberFormatted()),
          ],
        ),
      ),
    );
  }
}