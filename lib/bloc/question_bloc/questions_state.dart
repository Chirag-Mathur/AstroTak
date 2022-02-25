import '../../models/question_model.dart';

abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class FetchingQuestions extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;
  QuestionsLoaded({required this.questions});
}
