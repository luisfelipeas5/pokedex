import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:provider/provider.dart';

import 'components/PokemonItemList.dart';

class PokemonsPage extends StatefulWidget {
  @override
  _PokemonsPageState createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> with SingleTickerProviderStateMixin {

  late Animation<double> _elevationAnimation;
  late AnimationController _elevationAnimationController;

  final _targetElevation = 6.0;
  var _elevation = 0.0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _elevationAnimationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _elevationAnimation = Tween<double>(begin: 0.0, end: _targetElevation).animate(_elevationAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _scrollController.addListener(() {
      double newElevation = _scrollController.offset > 1 ? _targetElevation : 0;
      if (_elevation != newElevation) {
        if (newElevation == 0) {
          _elevationAnimationController.reverse();
        } else if (newElevation > 0) {
          _elevationAnimationController.forward();
        }
        _elevation = newElevation;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: _elevationAnimation.value,
          title: Text(
            "Pokedex",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
        body: buildList(context));
  }

  Widget buildList(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);

    _scrollController.addListener(() {
      var triggerFetchMoreSize = 0.9 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        bloc.loadMorePokemons();
      }
    });

    bloc.loadMorePokemons();
    return StreamBuilder<List<Pokemon>>(
        stream: bloc.pokemonsStreamController,
        initialData: [],
        builder: (context, snapshot) {
          final pokemons = snapshot.data ?? [];
          return SafeArea(
            child: Expanded(
              child: GridView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(top: 12, right: 16, left: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.3,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (_, index) {
                  return PokemonListItem(pokemons[index]);
                },
                itemCount: pokemons.length,
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _elevationAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

}
