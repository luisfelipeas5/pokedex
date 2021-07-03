import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:pokedex/screens/detail/PokemonBloc.dart';
import 'package:pokedex/screens/detail/PokemonState.dart';
import 'package:pokedex/screens/detail/components/species/BreedingView.dart';
import 'package:pokedex/screens/detail/components/subcomponents/LabelValue.dart';

class AboutView extends StatefulWidget {

  final Pokemon pokemon;

  const AboutView(this.pokemon, {Key? key}) : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 8,),
            _buildProgress(),
            _buildBasicAbout(),
            SizedBox(height: 12,),
            BreedingView(widget.pokemon.id),
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicAbout() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (!(state is PokemonLoadedState)) {
          return Container();
        }
        final pokemon = state.pokemon;
        return Column(
          children: [
            LabelValue("Height", pokemon.height.toString() + " cm"),
            LabelValue("Weight", ((pokemon.weight??0) * 100).toString() + " g"),
            LabelValue("Abilities", pokemon.abilitiesToString.toString()),
          ],
        );
      },
    );
  }

  Widget _buildProgress() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoadingState) {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }

}
