
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/model/Ability.dart';

import 'Type.dart';

part 'Pokemon.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Pokemon {

  Pokemon(this.id, this.name, {this.image, this.types});

  final int id;
  final String name;
  List<TypeSlot>? types;
  int? height;
  String? image;
  int? weight;
  List<AbilitySlot>? abilities;

  MaterialColor? getColor() {
    switch(types?.first.type.name) {
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

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var pokemon = _$PokemonFromJson(json);
    pokemon.image = json["sprites"]["other"]["dream_world"]["front_default"];
    return pokemon;
  }

  Map<String, dynamic> toJson() => _$PokemonToJson(this);

  factory Pokemon.fromListJson(Map<String, dynamic> json) {
    final pokemonUrl = Uri.parse(json['url']);
    var pathSegments = pokemonUrl.pathSegments;
    final number = int.parse(pathSegments[pathSegments.length - 2]);
    final name = json['name'];
    return Pokemon(number, name);
  }

  String? get abilitiesToString => abilities?.map((e) => e.ability?.name).join(", ");

  String getNumberFormatted() {
    return '#' + id.toString().padLeft(3, '0');
  }

}