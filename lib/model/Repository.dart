import 'dart:convert';

import 'package:pokedex/model/Pokemon.dart';
import 'package:http/http.dart' show get;

class Repository {

  final _pokemons = [
    Pokemon(1, "Bulba"), Pokemon(2, "Ivy"), Pokemon(3, "Venu"), Pokemon(4, "Charmander")
  ];

  Future<List<Pokemon>> getPokemons() async {
    var uri = Uri.https("pokeapi.co", "api/v2/pokemon", { "limit": "100" });
    final response = await get(uri);
    Iterable jsonArrayString = jsonDecode(response.body)["results"];

    return List<Pokemon>.from(
        jsonArrayString.map((e) => Pokemon.fromJson(e))
    );
  }

}