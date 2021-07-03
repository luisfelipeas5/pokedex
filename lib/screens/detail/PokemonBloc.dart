import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:pokedex/repositories/Repository.dart';

import 'PokemonEvent.dart';
import 'PokemonState.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {

  Repository repository;
  Pokemon? pokemon;

  PokemonBloc(this.repository) : super(PokemonLoadingState());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonLoadEvent) {
      this.pokemon = event.pokemon;
      if (pokemon != null) {
        yield PokemonLoadedState(pokemon!);
      }

      final number = event.number ?? event.pokemon?.id ?? 1;
      pokemon = await repository.getPokemon(number);
      this.pokemon = pokemon;
      yield PokemonLoadedState(pokemon!);
    }
  }
}