import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';

import 'AboutView.dart';
import 'StatsView.dart';

class PokemonDetailTabs extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailTabs(this.pokemon, {Key? key}) : super(key: key);

  @override
  _PokemonDetailTabsState createState() => _PokemonDetailTabsState();
}

class _PokemonDetailTabsState extends State<PokemonDetailTabs> {
  final _tabs = ["About", "Base Stats", "Evolution", "Moves"];
  final _tabSelectionPositions = [0.0, 0.33, 0.67, 1.0];
  var _tabSelected = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingHorizontal = 12.0;
    final tabWidth = (size.width/_tabs.length) - paddingHorizontal/2;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.3),
      padding: EdgeInsets.only(
          top: 30, left: paddingHorizontal, right: paddingHorizontal
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: [
          _buildTabs(),
          _buildTabIndicator(tabWidth),
          if (_tabSelected == 0) AboutView(widget.pokemon),
          if (_tabSelected == 1) StatsView(widget.pokemon),
        ],
      ),
    );
  }

  Widget _buildTabIndicator(double tabWidth) {
    return Stack(
      children: [
        Container(
          height: 1.5,
          color: Theme.of(context).hintColor.withAlpha(10),
          margin: EdgeInsets.symmetric(horizontal: 12),
        ),
        Align(
              alignment: Alignment.lerp(
                  Alignment.centerLeft,
                  Alignment.centerRight,
                  _tabSelectionPositions[_tabSelected]
              )!,
              child: SizedBox(
                height: 1.5,
                width: tabWidth,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildTabs() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _tabs.length,
          childAspectRatio: 2.3
        ),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Ink(
            child: InkWell(
              onTap: () {
                setState(() {
                  _tabSelected = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: index == _tabSelected
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.bodyText2
                          ?.copyWith(color: Theme.of(context).hintColor),
                ),
              ),
            ),
          );
        },
        itemCount: _tabs.length);
  }
}
