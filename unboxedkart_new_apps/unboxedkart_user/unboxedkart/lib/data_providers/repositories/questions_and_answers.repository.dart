import 'package:unboxedkart/data_providers/apis/questions_and_answers/questions_and_answers.api.dart';
import 'package:unboxedkart/models/question_and_answers/answer.model.dart';
import 'package:unboxedkart/models/question_and_answers/question_and_answers.model.dart';

class QuestionsAndAnswersRepository {
  QuestionsAndAnswersApi qAndAApi = QuestionsAndAnswersApi();

  Future<List<QuestionAndAnswersModel>> handleGetProductQuestionAndAnswers(
      String productId) async {
    final response = await qAndAApi.getProductQuestionsAndAnswers(productId);
    final List<QuestionAndAnswersModel> productQAndA = response
        .map<QuestionAndAnswersModel>(
            (doc) => QuestionAndAnswersModel.fromDoc(doc))
        .toList();
    return productQAndA;
  }

  Future handleAddQuestion(
      String accessToken, String question, String productId) async {
    final response =
        await qAndAApi.addQuestion(accessToken, question, productId);
    return response;
  }

  Future handleGetUserQuestions(String accessToken) async {
    final questions = await qAndAApi.getUserQuestions(accessToken);
    List<QuestionAndAnswersModel> qAndA = questions
        .map<QuestionAndAnswersModel>(
            (qAndA) => QuestionAndAnswersModel.fromDoc(qAndA))
        .toList();
    return qAndA;
  }

  Future handleGetUserAnswers(String accessToken) async {
    final answers = await qAndAApi.getUserAnswers(accessToken);
    List<AnswerModel> qAndA = answers
        .map<AnswerModel>((qAndA) => AnswerModel.fromDoc(qAndA))
        .toList();
    return qAndA;
  }

  Future handleGetQuestionsFeed(String accessToken) async {
    final response = await qAndAApi.getQuestionsFeed(accessToken);

    List<QuestionAndAnswersModel> questions = response
        .map<QuestionAndAnswersModel>(
            (qAndA) => QuestionAndAnswersModel.fromDoc(qAndA))
        .toList();
    return questions;
  }

  Future handleAddAnswer(
    String accessToken,
    String questionId,
    String questionTitle,
    String productTitle,
    String productId,
    String answer,
  ) async {
    final response = await qAndAApi.addAnswer(accessToken, questionId,
        questionTitle, productTitle, productId, answer);
    return response;
  }
}
