import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/extensions/StringExtensions.dart';
import 'package:pokedex/router/RouterState.dart';
import 'package:pokedex/router/routes/RoutePath.dart';
import 'package:provider/provider.dart';

import 'PokemonListType.dart';

class PokemonListItem extends StatelessWidget {
  PokemonListItem(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: pokemon.getColor(),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        onTap: () {
          final routerState = Provider.of<RouterState>(context, listen: false);
          routerState.push(DetailRoutePath.fromPokemon(pokemon));
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 10,),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: buildImage(),
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildNumber(pokemon),
                    buildName(),
                    SizedBox(height: 10,),
                    PokemonListType(pokemon),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      padding: EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.topLeft,
          colorFilter: ColorFilter.mode(
              pokemon.getColor()?.shade300??Colors.transparent, BlendMode.srcIn
          ),
          image: AssetImage("assets/pokeball_logo.jpg"),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SvgPicture.network(
          pokemon.image ?? "",
          fit: BoxFit.contain,
          placeholderBuilder: (context) {
            return Expanded(child: Container());
          },
        ),
      ),
    );
  }

  Padding buildName() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        pokemon.name.capitalizeFirst(),
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Padding buildNumber(Pokemon pokemon) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        pokemon.getNumberFormatted(),
        textAlign: TextAlign.end,
        style: TextStyle(color: pokemon.getColor()?.shade700, fontSize: 14),
      ),
    );
  }
}
