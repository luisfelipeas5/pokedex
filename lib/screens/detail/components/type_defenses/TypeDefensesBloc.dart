import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repositories/Repository.dart';
import 'package:pokedex/screens/detail/components/type_defenses/TypeDefensesEvent.dart';
import 'package:pokedex/screens/detail/components/type_defenses/TypeDefensesState.dart';

class TypeDefensesBloc extends Bloc<TypeDefensesEvent, TypeDefensesState> {

  final Repository repository;

  TypeDefensesBloc(this.repository): super(LoadingTypeDefensesState());

  @override
  Stream<TypeDefensesState> mapEventToState(TypeDefensesEvent event) async* {
    if (event is LoadTypeDefensesEvent) {
      final damageRelations = await repository.getDamageRelations(event.pokemonNumber);
      yield LoadedTypeDefensesState(damageRelations);
    }
  }

}