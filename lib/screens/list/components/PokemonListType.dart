import 'package:flutter/material.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/extensions/StringExtensions.dart';

class PokemonListType extends StatelessWidget {

  PokemonListType(this.pokemon, {this.vertical = true, Key? key}) : super(key: key);

  final Pokemon pokemon;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final types = pokemon.types??[];
    final backgroundColor = pokemon.getColor()?.shade300;

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: vertical? Axis.vertical : Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) => SizedBox(height: 10, width: 10,),
      itemBuilder: (_, index) {
        var type = types[index].type.name;
        return PokemonListTypeItem(type, backgroundColor, vertical);
      },
      itemCount: types.length,
    );
  }
}

class PokemonListTypeItem extends StatelessWidget {
  const PokemonListTypeItem(this.type, this.backgroundColor, this.vertical, {Key? key}) : super(key: key);

  final Color? backgroundColor;
  final String type;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    var container = Container(
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
          );

    if (vertical) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [container],
      );
    } else {
      return Column(
        children: [container,],
      );
    }
  }

}