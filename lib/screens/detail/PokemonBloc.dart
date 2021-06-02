import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/Repository.dart';

import 'PokemonEvent.dart';
import 'PokemonState.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {

  late Repository repository;

  PokemonBloc() : super(PokemonLoadingState());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonLoadEvent) {
      var pokemon = event.pokemon;
      if (pokemon == null) {
        pokemon = await repository.getPokemon(event.number ?? 1);
      }
      yield PokemonLoadedState(pokemon);
    }
  }
}