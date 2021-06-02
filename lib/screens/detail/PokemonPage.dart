import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/router/RouterState.dart';
import 'package:pokedex/screens/detail/components/BasicData.dart';
import 'package:provider/provider.dart';

import 'components/PokemonDetail.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            final routerState = Provider.of<RouterState>(context, listen: false);
            routerState.pop();
          },
        ),
        backgroundColor: pokemon.getColor(),
        elevation: 0,
      ),
      body: Container(
        color: pokemon.getColor(),
        child: Column(
          children: [
            BasicData(pokemon),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                buildPokeballImage(size),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: PokemonDetail(pokemon),
                ),
                SvgPicture.network(
                  pokemon.image??"",
                  height: size.height * 0.3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Align buildPokeballImage(Size size) {
    return Align(
                alignment: Alignment.lerp(
                    Alignment.topLeft, Alignment.bottomRight, 1.1
                )!,
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  child: Image.asset(
                    "assets/pokeball_logo.jpg",
                    color: pokemon.getColor()?.shade300??Colors.transparent,
                    colorBlendMode: BlendMode.srcIn,
                    height: size.height * 0.28,
                  ),
                ),
              );
  }

}
