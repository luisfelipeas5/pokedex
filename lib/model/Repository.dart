import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/model/Pokemon.dart';
import 'package:http/http.dart' as http;

class Repository {

  final client = http.Client();
  final baseUri = "pokeapi.co/api/v2";
  final basePrefix = "/api/v2";

  Future<List<Pokemon>> getPokemons(int offset) async {
    var queryParameters = {
      "limit": "30",
      "offset": offset.toString()
    };

    final response = await _get("pokemon", queryParameters: queryParameters);
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
    final response = await _get("pokemon/$number");
    final responseJsonDecoded = jsonDecode(response.body);

    pokemon.image = responseJsonDecoded["sprites"]["other"]["dream_world"]["front_default"];
    final Iterable typesJson = responseJsonDecoded['types'];
    pokemon.types = List<String>.from(typesJson.map((e) => e["type"]["name"]));

    return pokemon;
  }

  Future<Response> _get(
      String endpoint,
      {
        Map<String, dynamic> queryParameters = const {}
      }
    ) {
    final uri = Uri.https("pokeapi.co", "api/v2/$endpoint", queryParameters);
    return client.get(uri);
  }
}