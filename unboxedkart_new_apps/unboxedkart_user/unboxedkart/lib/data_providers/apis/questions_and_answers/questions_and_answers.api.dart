import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class QuestionsAndAnswersApi {
  ApiCalls apiCalls = ApiCalls();

  Future getUserQuestions(String accessToken) async {
    
    
    const url = "https://server.unboxedkart.com/q-and-a/questions";
    final questions = await apiCalls.get(accessToken: accessToken, url: url);
    return questions;
  }

  Future getUserAnswers(String accessToken) async {
    
    
    const url = "https://server.unboxedkart.com/q-and-a/answers";
    final answers = await apiCalls.get(accessToken: accessToken, url: url);
    return answers;
  }

  Future getProductQuestionsAndAnswers(String productId) async {
    final url = "http://192.168.1.11:4000/q-and-a/product/$productId";
    final qAndA = await apiCalls.get(url: url);

    return qAndA;
  }

  Future addQuestion(
      String accessToken, String question, String productId) async {
    const url = "http://192.168.1.11:4000/q-and-a/create/question";
    final postBody = {"productId": productId, "question": question};
    final response = await apiCalls.post(
        url: url, postBody: postBody, accessToken: accessToken);
    return response;
  }

  Future addAnswer(
    String accessToken,
    String questionId,
    String questionTitle,
    String productTitle,
    String productId,
    String answer,
  ) async {
    const url = "https://server.unboxedkart.com/q-and-a/create/answer";
    final postBody = {
      "questionId": questionId,
      "questionTitle": questionTitle,
      "productTitle": productTitle,
      "productId": productId,
      "answer": answer
    };
    final response = await apiCalls.post(
        url: url, postBody: postBody, accessToken: accessToken);
    
    

    return response;
  }

  Future getQuestionsFeed(String accessToken) async {
    const url = "https://server.unboxedkart.com/q-and-a/feed";
    final response = await apiCalls.get(url: url, accessToken: accessToken);
    return response;
  }

  Future getProductQAndA(String productId) async {
    final url = "https://server.unboxedkart.com/q-and-a/product/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future getAllProductQAndA(String productId) async {
    final url =
        "https://server.unboxedkart.com/q-and-a/product/all/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }
}
