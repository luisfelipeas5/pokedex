import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/species/Species.dart';
import 'package:pokedex/model/type/DamageRelations.dart';

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
          var pokemonFromList = Pokemon.fromListJson(jsonElement);
          return await getPokemon(pokemonFromList.id);
        })
    );
    return Future.wait(futures);
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

  Future<Pokemon> getPokemon(int number) async {
    final response = await _get("pokemon/$number");
    final responseJsonDecoded = jsonDecode(response.body);
    return Pokemon.fromJson(responseJsonDecoded);
  }

  Future<Species> getSpecies(int number) async {
    final response = await _get("pokemon-species/$number");
    return Species.fromJson(jsonDecode(response.body));
  }

  Future<DamageRelations> getDamageRelations(int number) async {
    final pokemon = await getPokemon(number);

    final allDamageRelations = DamageRelations(
      List.empty(growable: true), List.empty(growable: true), List.empty(growable: true),
        List.empty(growable: true), List.empty(growable: true), List.empty(growable: true)
    );
    pokemon.types?.forEach((typeSlot) async {
      final response = await _get("type/${typeSlot.type.name}");
      final typeDamageRelation = DamageRelations.fromJson(
          jsonDecode(response.body)["damage_relations"]);
      allDamageRelations
        ..noDamageTo.addAll(typeDamageRelation.noDamageTo)
        ..halfDamageTo.addAll(typeDamageRelation.halfDamageTo)
        ..doubleDamageTo.addAll(typeDamageRelation.doubleDamageTo)
        ..noDamageFrom.addAll(typeDamageRelation.noDamageFrom)
        ..halfDamageFrom.addAll(typeDamageRelation.halfDamageFrom)
        ..doubleDamageFrom.addAll(typeDamageRelation.doubleDamageFrom);
    });

    return allDamageRelations;
  }
}