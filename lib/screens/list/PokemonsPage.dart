import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';
import 'package:pokedex/screens/list/PokemonsBloc.dart';
import 'package:pokedex/screens/list/PokemonsEvent.dart';
import 'package:pokedex/screens/list/PokemonsState.dart';
import 'package:provider/provider.dart';

import '../../screens/list/components/PokemonItemList.dart';

class PokemonsPage extends StatefulWidget {
  @override
  _PokemonsPageState createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  final _bloc = PokemonsBloc();

  final _targetElevation = 6.0;
  var _elevation = 0.0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _bloc.repository = Provider.of<Repository>(context, listen: false);

    _scrollController.addListener(() {
      double newElevation = _scrollController.offset > 1 ? _targetElevation : 0;
      if (_elevation != newElevation) {
        setState(() {
          _elevation = newElevation;
        });
      }
    });

    _scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        _bloc.add(PokemonsLoadEvent());
      }
    });

    _bloc.add(PokemonsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: _elevation,
          title: Text(
            "Pokedex",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
        body: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<PokemonsBloc, PokemonsState>(
            listener: (_, state) {
              if (state is PokemonsLoadedFailedState && state.pokemonsLength > 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: _buildFailedText())
                );
              }
            },
            child: BlocBuilder<PokemonsBloc, PokemonsState>(
              builder: (context, state) {
                return Stack(children: [
                  if (state is PokemonsLoadedFailedState && state.pokemonsLength == 0)
                    _buildFailed(),
                  if (state is PokemonsLoadingState && state.pokemonsLength == 0)
                    _buildLoader(),
                  if (state is PokemonsLoadedState)
                    buildList(state.pokemons),
                  if (state is PokemonsLoadingState && state.pokemonsLength > 0)
                    _buildEndPageLoader(),
                ]);
              },
            ),
          ),
        ));
  }

  Row _buildFailed() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(24),
          child: _buildFailedText(),
        )),
      ],
    );
  }

  Text _buildFailedText() {
    return Text(
          "Houve um erro no carregamento da lista de pokemons",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        );
  }

  Row _buildLoader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Align _buildEndPageLoader() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Expanded(
          child: LinearProgressIndicator(),
        ));
  }

  Widget buildList(List<Pokemon> pokemons) {
    return SafeArea(
      child: Expanded(
        child: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 12, right: 16, left: 16, bottom: 16),
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
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    super.dispose();
  }
}
