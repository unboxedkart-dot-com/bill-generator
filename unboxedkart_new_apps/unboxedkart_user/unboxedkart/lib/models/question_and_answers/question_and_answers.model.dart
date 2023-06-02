import 'package:unboxedkart/models/cart_item/cart_item.model.dart';

class QuestionDetails {
  final String questionId;
  final bool isApproved;
  final String question;
  final DateTime timestamp;

  QuestionDetails(
      {this.questionId, this.isApproved, this.question, this.timestamp});

  factory QuestionDetails.fromDoc(doc) {
    return QuestionDetails(
      question: doc['question'],
      isApproved: doc['isApproved'],
      questionId: doc['questionId'],
      timestamp: DateTime.tryParse(
        doc['timestamp'],
      ),
    );
  }
}

class AnswerDetails {
  final String userId;
  final String userName;
  final String userRole;
  final String questionId;
  final bool isApproved;
  final String answer;
  final DateTime timestamp;

  AnswerDetails(
      {this.userId,
      this.userName,
      this.userRole,
      this.questionId,
      this.isApproved,
      this.answer,
      this.timestamp});

  factory AnswerDetails.fromDoc(doc) {
    return AnswerDetails(
      userName: doc['userName'],
      userRole: doc['userRole'],
      questionId: doc['questionId'],
      answer: doc['answer'],
      timestamp: DateTime.tryParse(doc['timestamp']),
    );
  }
}

class OnlyAnswerModel {
  final String userId;
  final String userName;
  final String userRole;
  final String questionId;
  final bool isApproved;
  final String productTitle;
  final String questionTitle;
  final String answer;
  final DateTime timestamp;

  OnlyAnswerModel(
      {this.userId,
      this.userName,
      this.userRole,
      this.questionId,
      this.isApproved,
      this.productTitle,
      this.questionTitle,
      this.answer,
      this.timestamp});

  factory OnlyAnswerModel.fromDoc(doc) {
    return OnlyAnswerModel(
      userName: doc['userName'],
      userRole: doc['userRole'],
      questionId: doc['questionId'],
      answer: doc['answer'],
      questionTitle: doc['questionDetails']['questionTitle'],
      productTitle: doc['questionDetails']['productTitle'],
      timestamp: DateTime.tryParse(doc['timestamp']),
    );
  }
}

class QuestionAndAnswersModel {
  final String userId;
  final String userName;
  final String userRole;
  final String productId;
  final ProductDetails productDetails;
  final QuestionDetails questionDetails;
  final List<AnswerDetails> answers;

  QuestionAndAnswersModel(
      {this.userId,
      this.userName,
      this.userRole,
      this.productId,
      this.productDetails,
      this.questionDetails,
      this.answers});
  factory QuestionAndAnswersModel.fromDoc(doc) {
    return QuestionAndAnswersModel(
        userId: doc['userId'],
        userName: doc['userName'],
        userRole: doc['userRole'],
        productId: doc['productId'],
        questionDetails: QuestionDetails.fromDoc(doc['questionDetails']),
        productDetails: ProductDetails.fromDocument(doc['productDetails']),
        answers: doc['answers']
            .map<AnswerDetails>(
              (answer) => AnswerDetails.fromDoc(answer),
            )
            .toList());
  }
}
