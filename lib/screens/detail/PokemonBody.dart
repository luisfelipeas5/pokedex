import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';

import 'components/PokemonDetailTabs.dart';

class PokemonBody extends StatelessWidget {

  final Pokemon pokemon;

  const PokemonBody(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var imageHeight = size.height * 0.34;
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                buildPokeballImage(size),
                PokemonDetailTabs(pokemon),
                SvgPicture.network(
                  pokemon.image ?? "",
                  height: imageHeight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align buildPokeballImage(Size size) {
    return Align(
      alignment: Alignment.lerp(Alignment.topLeft, Alignment.topRight, 1.1)!,
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.04),
        child: Image.asset(
          "assets/pokeball_logo.jpg",
          color: pokemon.getColor()?.shade300 ?? Colors.transparent,
          colorBlendMode: BlendMode.srcIn,
          height: size.height * 0.28,
        ),
      ),
    );
  }

}