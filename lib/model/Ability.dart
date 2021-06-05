class AbilitySlot {
  Ability? ability;

  AbilitySlot._internal();

  factory AbilitySlot.fromJson(Map<String, dynamic> json) {
    var abilitySlot = AbilitySlot._internal();
    abilitySlot.ability = Ability.fromJson(json["ability"]);
    return abilitySlot;
  }

}

class Ability {
  String? name;

  Ability._internal();

  factory Ability.fromJson(Map<String, dynamic> json) {
    var ability = Ability._internal();
    ability.name = json["name"];
    return ability;
  }
}