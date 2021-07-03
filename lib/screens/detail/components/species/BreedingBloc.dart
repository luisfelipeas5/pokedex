import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repositories/Repository.dart';
import 'package:pokedex/screens/detail/components/species/BreedingEvent.dart';
import 'package:pokedex/screens/detail/components/species/BreedingState.dart';

class BreedingBloc extends Bloc<BreedingEvent, BreedingState> {

  Repository repository;

  BreedingBloc(this.repository) : super(LoadingBreedingState());

  @override
  Stream<BreedingState> mapEventToState(BreedingEvent event) async* {
    if (event is LoadBreedingEvent) {
      final number = event.pokemonNumber;
      final species = await repository.getSpecies(number);
      yield LoadedBreedingState(species);
    }
  }

}