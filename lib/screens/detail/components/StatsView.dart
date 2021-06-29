import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/extensions/StringExtensions.dart';

import '../PokemonBloc.dart';
import '../PokemonState.dart';

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (!(state is PokemonLoadedState) || state.pokemon.stats == null) {
            return Container(
              padding: EdgeInsetsDirectional.only(top: 24),
              child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(strokeWidth: 2.5,)
              ),
            );
          }
          final stats = state.pokemon.stats??[];
          return Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: stats.length,
              itemBuilder: (_, index) {
                final stat = stats[index];
                return Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                            stat.stat.name.replaceFirst("special", "sp.")
                                .replaceFirst("-attack", " atk")
                                .replaceFirst("-defense", " def")
                                .capitalizeFirst()
                        )
                      ),
                      SizedBox(
                        width: 25,
                        child: Text(
                          stat.baseStat.toString(),
                          textAlign: TextAlign.right,
                        )
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          percent: stat.baseStat/200.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
    );
  }
}