import 'dart:convert';

import 'package:pokedex/model/Pokemon.dart';
import 'package:http/http.dart' show get;

class Repository {

  Future<List<Pokemon>> getPokemons(int offset) async {
    var queryParameters = {
      "limit": "40",
      "offset": offset.toString()
    };
    final uri = Uri.https("pokeapi.co", "api/v2/pokemon", queryParameters);
    final response = await get(uri);
    Iterable jsonArrayString = jsonDecode(response.body)["results"];

    var futures = List<Future<Pokemon>>.from(
        jsonArrayString.map((jsonElement) async {
          var pokemonFromList = Pokemon.fromJson(jsonElement);
          await _inflatePokemonDetail(pokemonFromList);
          return pokemonFromList;
        })
    );
    return Future.wait(futures);
  }
  
  Future<Pokemon> _inflatePokemonDetail(Pokemon pokemon) async {
    final number = pokemon.number;
    final uri = Uri.https("pokeapi.co", "api/v2/pokemon/$number");
    final response = await get(uri);
    final responseJsonDecoded = jsonDecode(response.body);

    pokemon.image = responseJsonDecoded["sprites"]["other"]["dream_world"]["front_default"];
    final Iterable typesJson = responseJsonDecoded['types'];
    pokemon.types = List<String>.from(typesJson.map((e) => e["type"]["name"]));

    return pokemon;
  }

}