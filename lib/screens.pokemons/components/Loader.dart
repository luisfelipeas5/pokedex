import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:pokedex/model/LoaderState.dart';
import 'package:provider/provider.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    return StreamBuilder(
        initialData: LoaderState(true, 0),
        stream: bloc.loadingStreamController,
        builder: (_, snapshot) {
          final loaderState = snapshot.data as LoaderState;
          if (loaderState.loading == true && loaderState.listLength == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}