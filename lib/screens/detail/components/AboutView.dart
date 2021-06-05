import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/model/Pokemon.dart';

class AboutView extends StatelessWidget {
  final Pokemon pokemon;

  const AboutView(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: false,
        children: [
          _buildItem(context, "Height", pokemon.height.toString() + " cm"),
          _buildItem(context, "Weight", (pokemon.weight??0 * 100).toString() + " g"),
          _buildItem(context, "Abilities", pokemon.abilitiesToString.toString()),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).hintColor.withAlpha(100)
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2,
            ))
      ],
    );
  }

}
