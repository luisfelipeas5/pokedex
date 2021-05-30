import 'dart:async';
import 'package:pokedex/model/LoaderState.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:pokedex/model/Repository.dart';

class PokemonsBloc {

  late Repository repository;
  final _pokemons = <Pokemon>[];
  var _loading = false;

  final _pokemonsStreamController = StreamController<List<Pokemon>>();
  final _loadingStreamController = StreamController<LoaderState>.broadcast();
  final _failedStreamController = StreamController<int?>();

  Stream<List<Pokemon>> get pokemonsStreamController => _pokemonsStreamController.stream;
  Stream<LoaderState> get loadingStreamController => _loadingStreamController.stream;
  Stream<int?> get failedStreamController => _failedStreamController.stream;

  loadMorePokemons() async {
    if (!_loading) {
      _setLoading(true);

      try {
        final newPokemons = await repository.getPokemons(_pokemons.length);
        _pokemons.addAll(newPokemons);
        _pokemonsStreamController.sink.add(_pokemons);
        _failedStreamController.sink.add(null);
      } on Exception catch(_) {
        _failedStreamController.sink.add(_pokemons.length);
      }

      _setLoading(false);
    }
  }

  _setLoading(bool loading) {
    _loading = loading;
    var loaderState = LoaderState(loading, _pokemons.length);
    _loadingStreamController.sink.add(loaderState);
  }

  dispose() {
    _pokemonsStreamController.close();
    _loadingStreamController.close();
    _failedStreamController.close();
  }

}