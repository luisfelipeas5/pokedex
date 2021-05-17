
import 'package:flutter/material.dart';

class Pokemon {

  Pokemon(this.number, this.name, {this.image, this.types});

  final int number;
  final String? name;
  List<String>? types;
  String? image;

  String? _color;
  set color(String? color) => _color = color;
  Color getColor() {
    switch(_color) {
      case 'black': return Colors.black;
      case 'red': return Colors.red;
      case 'yellow': return Colors.yellow;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'grey': return Colors.grey;
      case 'brown': return Colors.brown;
      case 'purple': return Colors.purple;
      case 'orange': return Colors.orange;
      default: return Colors.transparent;
    }
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemonUrl = Uri.parse(json['url']);
    var pathSegments = pokemonUrl.pathSegments;
    final number = int.parse(pathSegments[pathSegments.length - 2]);
    final name = json['name'];
    return Pokemon(number, name);
  }

  factory Pokemon.fromDetailJson(Map<String, dynamic> json) {
    var pokemon = Pokemon.fromJson(json);



    return pokemon;
  }

}