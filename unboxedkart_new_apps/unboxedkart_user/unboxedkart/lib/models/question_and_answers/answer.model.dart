class AnswerModel {
  final String userId;
  final String userName;
  final String userRole;
  // final String productId;
  final bool isApproved;
  final String answer;
  final DateTime timestamp;
  final String productTitle;
  final String questionTitle;

  AnswerModel(
      {this.userId,
      this.userName,
      this.userRole,
      // this.productId,
      this.isApproved,
      this.answer,
      this.timestamp,
      this.productTitle,
      this.questionTitle});

  factory AnswerModel.fromDoc(doc) {
    return AnswerModel(
        userId: doc['userId'],
        userName: doc['userName'],
        userRole: doc['userRole'],
        // productId: doc['productId'],
        isApproved: doc['isApproved'],
        answer: doc['answer'],
        questionTitle: doc['questionDetails']['questionTitle'],
        productTitle: doc['questionDetails']['productTitle'],
        timestamp: DateTime.tryParse(doc['timestamp']));
  }
}
