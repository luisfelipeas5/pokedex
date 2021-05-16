
class Pokemon {

  Pokemon(this.number, this.name);

  final int number;
  final String name;

  final List<String> types = [
    "Grass", "Poison"
  ];

  String get image => "assets/$number.svg";

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemonUrl = Uri.parse(json['url']);
    var pathSegments = pokemonUrl.pathSegments;
    final number = int.parse(pathSegments[pathSegments.length - 2]);

    return Pokemon(number, json['name']);
  }

}