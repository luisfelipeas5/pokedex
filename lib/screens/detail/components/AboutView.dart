import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/model/species/Species.dart';
import 'package:pokedex/screens/detail/PokemonBloc.dart';
import 'package:pokedex/screens/detail/PokemonState.dart';

class AboutView extends StatefulWidget {

  const AboutView({Key? key}) : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        var bloc = context.read<PokemonBloc>();
        final pokemon = bloc.pokemon;
        final species = bloc.species;
        if (pokemon == null) {
          return CircularProgressIndicator();
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 8
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: false,
              children: [
                _buildItem("Height", pokemon.height.toString() + " cm"),
                _buildItem("Weight", (pokemon.weight??0 * 100).toString() + " g"),
                _buildItem("Abilities", pokemon.abilitiesToString.toString()),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Breeding",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                if (state is SpeciesLoadingState) CircularProgressIndicator(),
                if (species != null) _buildGenderItem(species),
                if (species != null) _buildItem("Egg Groups", species.eggGroupsToString),
                if (species != null) _buildItem("Egg Cycle", "Grass"),
                SizedBox(height: 80,),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(String label, String? value) {
    return Padding(
      padding: _itemPadding(),
      child: Row(
        children: [
          _buildLabel(label, context),
          Expanded(
              flex: 3,
              child: Text(
                value??"",
                style: Theme.of(context).textTheme.bodyText2,
              ))
        ],
      ),
    );
  }

  EdgeInsets _itemPadding() {
    return const EdgeInsets.symmetric(
      vertical: 8
    );
  }

  _buildGenderItem(Species species) {
    return Padding(
      padding: _itemPadding(),
      child: Row(
        children: [
          _buildLabel("Gender", context),
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/male.svg",
                    width: 12,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 4,),
                  Text("${species.maleRate}%"),
                  SizedBox(width: 16,),
                  SvgPicture.asset(
                    "assets/female.svg",
                    width: 12,
                    color: Colors.pink,
                  ),
                  SizedBox(width: 4,),
                  Text("${species.femaleRate}%"),
                ],
              ))
        ],
      ),
    );
  }

  Expanded _buildLabel(String label, BuildContext context) {
    return Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).hintColor.withAlpha(100)
            ),
          ),
        );
  }
}
