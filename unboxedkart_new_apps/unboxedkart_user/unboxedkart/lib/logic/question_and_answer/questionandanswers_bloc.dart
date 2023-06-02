
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/questions_and_answers.repository.dart';
import 'package:unboxedkart/models/question_and_answers/answer.model.dart';
import 'package:unboxedkart/models/question_and_answers/question_and_answers.model.dart';

part 'questionandanswers_event.dart';
part 'questionandanswers_state.dart';

class QuestionandanswersBloc
    extends Bloc<QuestionandanswersEvent, QuestionandanswersState> {
  final LocalRepository _localRepo = LocalRepository();
  final QuestionsAndAnswersRepository _qAndARepo =
      QuestionsAndAnswersRepository();

  QuestionandanswersBloc() : super(QuestionandanswersInitial()) {
    on<LoadUserQuestionAndAnswers>(_onLoadUserQuestionsAndAnswers);
    on<LoadQuestionAndAnswers>(_onLoadQuestionsAndAnswers);
    on<LoadAllProductQandA>(_onLoadProductQandA);
    on<AddQuestion>(_onAddQuestion);
    on<AddAnswer>(_onAddAnswer);
    on<LoadUserQuestions>(_onLoadUserQuestions);
    on<LoadUserAnswers>(_onLoadUserAnswers);
  }

  void _onLoadQuestionsAndAnswers(LoadQuestionAndAnswers event,
      Emitter<QuestionandanswersState> emit) async {
    emit(QuestionAndAnswerLoading());
    final List<QuestionAndAnswersModel> questionAndAnswers =
        await _qAndARepo.handleGetProductQuestionAndAnswers(event.productId);

    // emit(QuestionAndAnswersLoaded(questionAndAnswers));
  }

  void _onAddQuestion(
      AddQuestion event, Emitter<QuestionandanswersState> emit) async {
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _qAndARepo.handleAddQuestion(
        accessToken, event.question, event.productId);
  }

  void _onLoadUserAnswers(
      LoadUserAnswers event, Emitter<QuestionandanswersState> emit) async {
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _qAndARepo.handleGetUserAnswers(accessToken);
  }

  void _onLoadUserQuestions(
      LoadUserQuestions event, Emitter<QuestionandanswersState> emit) async {
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _qAndARepo.handleGetUserQuestions(accessToken);
  }

  void _onLoadUserQuestionsAndAnswers(LoadUserQuestionAndAnswers event,
      Emitter<QuestionandanswersState> emit) async {
    // 

    emit(QuestionAndAnswerLoading());
    final bloc = QuestionandanswersBloc();
    
    final String accessToken = await _localRepo.getAccessToken();
    final answers = await _qAndARepo.handleGetUserAnswers(accessToken);
    final questions = await _qAndARepo.handleGetUserQuestions(accessToken);
    final questionFeed = await _qAndARepo.handleGetQuestionsFeed(accessToken);
    
    
    
    emit(QuestionAndAnswersLoaded(questions, answers, questionFeed));
    // final bloc2 = QuestionandanswersBloc();
    // 
  }

  void _onAddAnswer(
      AddAnswer event, Emitter<QuestionandanswersState> emit) async {
    
    emit(QuestionAndAnswerLoading());
    final String accessToken = await _localRepo.getAccessToken();
    
    
    final response = await _qAndARepo.handleAddAnswer(
      accessToken,
      event.questionId,
      event.questionTitle,
      event.productTitle,
      event.productId,
      event.answer,
    );
    await _localRepo.addAnsweredQuestionId(event.questionId);
    emit(AnswerAddedState());
  }

  void _onLoadProductQandA(
      LoadAllProductQandA event, Emitter<QuestionandanswersState> emit) async {
    emit(ProductsQandALoading());
    
    
    final List<QuestionAndAnswersModel> questionAndAnswers =
        await _qAndARepo.handleGetProductQuestionAndAnswers(event.productId);
    emit(ProductsQandALoaded(questionAndAnswers));
  }
}
