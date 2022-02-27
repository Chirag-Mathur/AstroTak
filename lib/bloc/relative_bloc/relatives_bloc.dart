import 'package:astrotak/bloc/relative_bloc/relatives_event.dart';
import 'package:astrotak/bloc/relative_bloc/relatives_state.dart';
import 'package:astrotak/models/relative_model.dart';
import 'package:astrotak/repository/api_repository.dart';
import 'package:astrotak/services/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelativesBloc extends Bloc<RelativesEvent, RelativesState> {
  final ApiRepository apiRepository;

  RelativesBloc(this.apiRepository) : super(InitialRelativesState()) {
    on<FetchAllRelatives>((event, emit) async {
      emit(FetchingRelativesState());
      List<Relative> relatives = [];
      relatives = await apiRepository.getAllRelatives();

      logger.i('${relatives.length} Fetched State Called --->');
      emit(FetchedRelativesState(relatives));
    });
    on<AddRelative>((event, emit) async {
      emit(AddingRelativeState());
      await apiRepository.addRelative(event.relative);
      List<Relative> relatives = [];
      relatives = await apiRepository.getAllRelatives();
      logger.i("${relatives.length}----------length");
      emit(FetchedRelativesState(relatives));
    });
    on<UpdateRelative>((event, emit) async {
      emit(UpdatingRelativeState());
      await apiRepository.updateRelative(event.relative);
      List<Relative> relatives = [];
      relatives = await apiRepository.getAllRelatives();
      logger.i("${relatives.length}----------length");
      emit(FetchedRelativesState(relatives));
    });
    on<DeleteRelative>((event, emit) async {
      emit(FetchingRelativesState());
      await apiRepository.deleteRelative(event.uuid);
      logger.i("Helllooooooo");
      List<Relative> relatives = [];
      relatives = await apiRepository.getAllRelatives();
      logger.i("${relatives.length}----------length");
      emit(FetchedRelativesState(relatives));
    });
  }
}
