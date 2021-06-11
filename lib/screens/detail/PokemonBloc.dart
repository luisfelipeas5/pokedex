import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';
import 'package:pokedex/model/species/Species.dart';

import 'PokemonEvent.dart';
import 'PokemonState.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {

  late Repository repository;
  Pokemon? pokemon;
  Species? species;

  PokemonBloc() : super(PokemonLoadingState());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonLoadEvent) {
      var pokemon = event.pokemon;
      var number = event.number ?? 1;
      if (pokemon == null) {
        pokemon = await repository.getPokemon(number);
        this.pokemon = pokemon;
      }
      yield PokemonLoadedState(pokemon);

      yield SpeciesLoadingState();
      this.species = await repository.getSpecies(number);
      yield SpeciesLoaded();
    }
  }
}