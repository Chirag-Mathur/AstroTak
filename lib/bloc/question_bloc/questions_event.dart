import '../../models/question_model.dart';

abstract class QuestionsEvent {}

class FetchAllQuestions extends QuestionsEvent {
  FetchAllQuestions();
}