import 'dart:async';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';

class PokemonsBloc {

  Repository repository;
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

  onIndexBuilt(int index) {
    var threshold = 2;
    if (_pokemons.isNotEmpty && index >= _pokemons.length - threshold) {
      loadMorePokemons();
    }
  }

}