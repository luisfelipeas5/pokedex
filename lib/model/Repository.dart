import 'dart:convert';

import 'package:pokedex/model/Pokemon.dart';
import 'package:http/http.dart' show get;

class Repository {

  Future<List<Pokemon>> getPokemons(int offset) async {
    var queryParameters = {
      "limit": "20",
      "offset": offset.toString()
    };
    var uri = Uri.https("pokeapi.co", "api/v2/pokemon", queryParameters);
    final response = await get(uri);
    Iterable jsonArrayString = jsonDecode(response.body)["results"];

    return List<Pokemon>.from(
        jsonArrayString.map((e) => Pokemon.fromJson(e))
    );
  }

}