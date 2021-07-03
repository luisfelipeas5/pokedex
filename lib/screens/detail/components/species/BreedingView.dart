
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/model/species/Species.dart';
import 'package:pokedex/screens/detail/components/species/BreedingBloc.dart';
import 'package:pokedex/screens/detail/components/species/BreedingEvent.dart';
import 'package:pokedex/screens/detail/components/species/BreedingState.dart';
import 'package:pokedex/screens/detail/components/subcomponents/Label.dart';
import 'package:pokedex/screens/detail/components/subcomponents/LabelValue.dart';

class BreedingView extends StatefulWidget {

  final int pokemonNumber;

  const BreedingView(this.pokemonNumber, {Key? key}) : super(key: key);

  @override
  _BreedingViewState createState() => _BreedingViewState();
}

class _BreedingViewState extends State<BreedingView> {
  late BreedingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BreedingBloc(context.read());
    _bloc.add(LoadBreedingEvent(widget.pokemonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreedingBloc>(
      create: (_) => _bloc,
      child: BlocBuilder<BreedingBloc, BreedingState>(
        builder: (_, state) {
          if (state is LoadingBreedingState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(strokeWidth: 2.5,)
                ),
              ],
            );
          }
          final species = state is LoadedBreedingState? state.species : null;
          return Column(
            children: [
              Row(
                children: [
                  Text("Breeding", style: Theme.of(context).textTheme.headline6,),
                ],
              ),
              SizedBox(height: 8,),
              if (species != null) _buildGenderItem(species),
              if (species != null) LabelValue("Egg Groups", species.eggGroupsToString),
              if (species != null) LabelValue("Egg Cycle", "Grass"),
            ],
          );
        },
      ),
    );
  }

  _buildGenderItem(Species species) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Label("Gender"),
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

}