import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/pokemon/Pokemon.dart';
import 'package:pokedex/model/type/Type.dart';
import 'package:pokedex/screens/detail/components/type_defenses/TypeDefensesEvent.dart';
import 'package:pokedex/screens/detail/components/type_defenses/TypeDefensesState.dart';
import 'package:pokedex/screens/list/components/TypeList.dart';

import 'TypeDefensesBloc.dart';

class TypeDefenses extends StatefulWidget {

  final Pokemon pokemon;

  const TypeDefenses(this.pokemon, {Key? key}) : super(key: key);

  @override
  _TypeDefensesState createState() => _TypeDefensesState();
}

class _TypeDefensesState extends State<TypeDefenses> {

  late TypeDefensesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TypeDefensesBloc(context.read());
    _bloc.add(LoadTypeDefensesEvent(widget.pokemon.id));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Type defenses", style: Theme.of(context).textTheme.headline6,),
        SizedBox(height: 8,),
        Text(
            "The effectiveness of each type on ${widget.pokemon.name}",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Theme.of(context).hintColor.withAlpha(100),
            ),
        ),
        SizedBox(height: 12,),
        _buildList(),
      ],
    );
  }

  BlocProvider<TypeDefensesBloc> _buildList() {
    return BlocProvider<TypeDefensesBloc>(
      create: (_) => _bloc,
      child: BlocBuilder<TypeDefensesBloc, TypeDefensesState>(
        builder: (context, state) {
          if (state is LoadingTypeDefensesState) {
            return Container(
              padding: EdgeInsetsDirectional.only(top: 24),
              child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(strokeWidth: 2.5,)
              ),
            );
          }
          final damageRelations = (state as LoadedTypeDefensesState).damageRelations;
          return Column(
            children: [
              _buildItem("No damage to:", damageRelations.noDamageTo),
              _buildItem("Half damage to:", damageRelations.halfDamageTo),
              _buildItem("Double damage to:", damageRelations.doubleDamageTo),
              _buildItem("No damage from:", damageRelations.noDamageFrom),
              _buildItem("Half damage from:", damageRelations.halfDamageFrom),
              _buildItem("Double damage from:", damageRelations.doubleDamageFrom)
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(String label, List<PokeType> types) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 8,),
        Expanded(
          child: SizedBox(
            height: 30,
            child: TypeList(
              types,
              widget.pokemon.getColor()?.shade300,
              vertical: false,
            ),
          ),
        ),
      ],
    );
  }

}