import 'package:flutter/material.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/extensions/StringExtensions.dart';

class PokemonListType extends StatelessWidget {

  PokemonListType(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final types = pokemon.types??[];
    final backgroundColor = pokemon.getColor()?.shade300;

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) => SizedBox(height: 10,),
      itemBuilder: (_, index) {
        var type = types[index];
        return PokemonListTypeItem(type, backgroundColor);
      },
      itemCount: types.length,
    );
  }
}

class PokemonListTypeItem extends StatelessWidget {
  const PokemonListTypeItem(this.type, this.backgroundColor, {Key? key}) : super(key: key);

  final Color? backgroundColor;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            child: Text(
              type.capitalizeFirst(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12
              ),
              textAlign: TextAlign.center,
            )
        ),
      ],
    );
  }

}