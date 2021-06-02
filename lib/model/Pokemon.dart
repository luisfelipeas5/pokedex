
import 'package:flutter/material.dart';

class Pokemon {

  Pokemon(this.number, this.name, {this.image, this.types});

  final int number;
  final String name;
  List<String>? types;
  String? image;

  MaterialColor? getColor() {
    switch(types?.first) {
      case 'grass':
      case 'bug':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'electric':
        return Colors.yellow;
      case 'water':
      case 'ice':
      case 'dragon':
        return Colors.blue;
      case 'fighting':
      case 'normal':
      case 'steel':
      case 'flying':
        return Colors.grey;
      case 'rock':
      case 'ground':
        return Colors.brown;
      case 'shadow':
      case 'dark':
        return Colors.blueGrey;
      case 'ghost':
      case 'poison':
        return Colors.purple;
      case 'psychic':
        return Colors.orange;
      case 'fairy':
        return Colors.pink;
      default:
        return null;
    }
  }

  factory Pokemon.fromListJson(Map<String, dynamic> json) {
    final pokemonUrl = Uri.parse(json['url']);
    var pathSegments = pokemonUrl.pathSegments;
    final number = int.parse(pathSegments[pathSegments.length - 2]);
    final name = json['name'];
    return Pokemon(number, name);
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final number = json["id"];
    final name = json['name'];

    var pokemon = Pokemon(number, name);
    pokemon.image = json["sprites"]["other"]["dream_world"]["front_default"];
    final Iterable typesJson = json['types'];
    pokemon.types = List<String>.from(typesJson.map((e) => e["type"]["name"]));

    return pokemon;
  }

  String getNumberFormatted() {
    return '#' + number.toString().padLeft(3, '0');
  }

}