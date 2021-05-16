import 'dart:async';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';

class PokemonsBloc {

  Repository repository;

  final _pokemonsStreamController = StreamController<List<Pokemon>>();

  Stream<List<Pokemon>> get pokemonsStreamController => _pokemonsStreamController.stream;

  loadPokemons() async {
    final pokemons = await repository.getPokemons();
    _pokemonsStreamController.sink.add(pokemons);
  }

  dispose() {
    _pokemonsStreamController.close();
  }

}