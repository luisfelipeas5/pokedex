import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/extensions/StringExtensions.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:pokedex/screens/detail/components/type_defenses/TypeDefenses.dart';

import '../PokemonBloc.dart';
import '../PokemonState.dart';

class StatsView extends StatefulWidget {

  final Pokemon pokemon;

  const StatsView(this.pokemon, {Key? key}) : super(key: key);

  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 12),
        child: ListView(
          children: [
            _buildLoader(),
            _buildBarsList(),
            Align(
              alignment: Alignment.center,
              child: TypeDefenses(widget.pokemon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
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
        return Container();
      },
    );
  }

  Widget _buildBarsList() {
    return BlocBuilder<PokemonBloc, PokemonState>(
        buildWhen: (previous, current) {
          return current is PokemonLoadedState;
        },
        builder: (context, state) {
          final stats = (state as PokemonLoadedState).pokemon.stats??[];
          final colors = [Colors.red, Colors.green];
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: stats.length,
            itemBuilder: (_, index) {
              final stat = stats[index];
              return Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                        width: 75,
                        child: Text(
                          stat.stat.name
                              .replaceFirst("special", "sp.")
                              .replaceFirst("hp", "HP")
                              .replaceFirst("-attack", " atk")
                              .replaceFirst("-defense", " def")
                              .capitalizeFirst(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                              color: Theme
                                  .of(context)
                                  .hintColor
                                  .withAlpha(100)),
                        )),
                    SizedBox(
                        width: 25,
                        child: Text(
                          stat.baseStat.toString(),
                          textAlign: TextAlign.right,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2,
                        )),
                    Expanded(
                      child: LinearPercentIndicator(
                        percent: stat.baseStat / 200.0,
                        progressColor: colors[index % 2],
                        lineHeight: 3,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }
}