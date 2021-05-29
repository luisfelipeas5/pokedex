import 'dart:async';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';

class PokemonsBloc {

  late Repository repository;
  final _pokemons = <Pokemon>[];

  final _pokemonsStreamController = StreamController<List<Pokemon>>();

  Stream<List<Pokemon>> get pokemonsStreamController => _pokemonsStreamController.stream;

  loadMorePokemons() async {
    final newPokemons = await repository.getPokemons(_pokemons.length);
    _pokemons.addAll(newPokemons);
    _pokemonsStreamController.sink.add(_pokemons);
  }

  dispose() {
    _pokemonsStreamController.close();
  }

}