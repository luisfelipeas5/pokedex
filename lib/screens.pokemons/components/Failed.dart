import 'package:flutter/material.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:provider/provider.dart';

class Failed extends StatefulWidget {
  @override
  _FailedState createState() => _FailedState();
}

class _FailedState extends State<Failed> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    return StreamBuilder(
        initialData: null,
        stream: bloc.failedStreamController,
        builder: (context, snapshot) {
          var pokemonLength = snapshot.data as int?;
          if (pokemonLength == null || pokemonLength > 0) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "Houve um erro no carregamento da lista de pokemons",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            );
          }
        }
    );
  }
}
