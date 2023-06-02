part of 'questionandanswers_bloc.dart';

abstract class QuestionandanswersEvent extends Equatable {
  const QuestionandanswersEvent();

  @override
  List<Object> get props => [];
}

class LoadQuestionAndAnswers extends QuestionandanswersEvent {
  final String productId;

  const LoadQuestionAndAnswers(this.productId);
}

class LoadUserQuestionAndAnswers extends QuestionandanswersEvent {}

class AddQuestion extends QuestionandanswersEvent {
  final String productId;
  final String question;

  const AddQuestion(this.productId, this.question);
}

class AddAnswer extends QuestionandanswersEvent {
  final String questionTitle;
  final String answer;
  final String productTitle;
  final String productId;
  final String questionId;

  const AddAnswer(
      {this.questionTitle, this.answer, this.productTitle, this.productId,this.questionId});
}

class LoadUserQuestions extends QuestionandanswersEvent {}

class LoadUserAnswers extends QuestionandanswersEvent {}


class LoadAllProductQandA extends QuestionandanswersEvent {
  final String productId;

  const LoadAllProductQandA(this.productId);
}
