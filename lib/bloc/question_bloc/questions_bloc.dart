import 'package:astrotak/repository/api_repository.dart';
import 'package:astrotak/services/logger.dart';

import '../../models/question_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'questions_event.dart';
import 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final ApiRepository apiRepository;

  QuestionsBloc(this.apiRepository) : super(QuestionsInitial()) {
    on<FetchAllQuestions>((event, emit) async {
      emit(FetchingQuestions());
      List<Question> questions = [];
      questions = await apiRepository.getAllQuestions();
      logger.i(questions.length);
      emit(QuestionsLoaded(questions: questions));
    });
  }

  // QuestionsBloc(this.apiRepository) : super(QuestionsInitial());

  // @override
  // Stream<QuestionsState> mapEventToState(QuestionsEvent event) async* {
  //   yield FetchingQuestions();
  //   try {
  //     if (event is FetchAllQuestions) {
  //       yield FetchingQuestions();
  //       List<Question> questions = [];
  //       questions = await apiRepository.getAllQuestions();
  //       yield QuestionsLoaded(questions: questions);
  //     }
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
}
