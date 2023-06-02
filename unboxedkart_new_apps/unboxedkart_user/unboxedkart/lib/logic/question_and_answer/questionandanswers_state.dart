part of 'questionandanswers_bloc.dart';

abstract class QuestionandanswersState extends Equatable {
  const QuestionandanswersState();

  @override
  List<Object> get props => [];
}

class QuestionandanswersInitial extends QuestionandanswersState {}

class QuestionAndAnswerLoading extends QuestionandanswersState {}

class QuestionAndAnswersLoaded extends QuestionandanswersState {
  final List<QuestionAndAnswersModel> questionAndAnswers;
  final List<AnswerModel> answers;
  final List<QuestionAndAnswersModel> questionsFeed;

  const QuestionAndAnswersLoaded(
      this.questionAndAnswers, this.answers, this.questionsFeed);

  @override
  get props => [questionAndAnswers];
}

class AnswerAddedState extends QuestionandanswersState {}

class ProductsQandALoading extends QuestionandanswersState {}

class ProductsQandALoaded extends QuestionandanswersState {
  final List<QuestionAndAnswersModel> qAndA;

  const ProductsQandALoaded(this.qAndA);

  @override
  get props => [qAndA];
}
