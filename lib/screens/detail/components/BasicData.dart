import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:pokedex/extensions/StringExtensions.dart';
import 'package:pokedex/screens/list/components/TypeList.dart';

class BasicData extends StatefulWidget {

  final Pokemon pokemon;

  const BasicData(this.pokemon, {Key? key}) : super(key: key);

  @override
  _BasicDataState createState() => _BasicDataState();
}

class _BasicDataState extends State<BasicData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildName(context),
                  SizedBox(height: 6,),
                  buildListType(),
                ],
              ),
              Align(
                  alignment: Alignment.center,
                  child: buildNumber()
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListType() {
    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.topLeft,
        child: TypeList.fromPokemon(
          widget.pokemon,
          vertical: false,
        ),
      ),
    );
  }

  Text buildName(BuildContext context) {
    return Text(
      widget.pokemon.name.capitalizeFirst(),
      textAlign: TextAlign.start,
      style: Theme.of(context)
          .textTheme
          .headline3
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }

  Widget buildNumber() {
    return Text(
      widget.pokemon.getNumberFormatted(),
      textAlign: TextAlign.end,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 16
      ),
    );
  }
}