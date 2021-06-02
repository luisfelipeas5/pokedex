import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';
import 'package:pokedex/screens/list/PokemonsEvent.dart';
import 'package:pokedex/screens/list/PokemonsState.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {

  late Repository repository;
  final _pokemons = <Pokemon>[];

  PokemonsBloc() : super(PokemonsLoadingState([]));

  @override
  Stream<PokemonsState> mapEventToState(PokemonsEvent event) async* {
    if (event is PokemonsLoadEvent) {
      yield PokemonsLoadingState(_pokemons);
      final newPokemons = await repository.getPokemons(_pokemons.length);
      _pokemons.addAll(newPokemons);
      yield PokemonsLoadedState(_pokemons);
    }
  }

}