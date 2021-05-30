import 'package:flutter/material.dart';
import 'package:pokedex/bloc/PokemonsBloc.dart';
import 'package:pokedex/model/LoaderState.dart';
import 'package:provider/provider.dart';

class EndPageLoader extends StatefulWidget {
  @override
  _EndPageLoaderState createState() => _EndPageLoaderState();
}

class _EndPageLoaderState extends State<EndPageLoader> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PokemonsBloc>(context, listen: false);
    return StreamBuilder(
        initialData: LoaderState(false, 0),
        stream: bloc.loadingStreamController,
        builder: (_, snapshot) {
          final loaderState = snapshot.data as LoaderState;
          if (loaderState.loading == true && loaderState.listLength > 0) {
            return Expanded(
              child: LinearProgressIndicator(),
            );
          } else {
            return Container();
          }
        });
  }
}