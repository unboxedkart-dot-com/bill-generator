class QuestionModel {
  final String userId;
  final String userName;
  final String userRole;
  final String productId;
  final bool isApproved;
  final String question;
  final DateTime timestamp;

  QuestionModel(
      {this.userId,
      this.userName,
      this.userRole,
      this.productId,
      this.isApproved,
      this.question,
      this.timestamp});

  factory QuestionModel.fromDocument(doc) {
    return QuestionModel(
      userId: doc['userId'],
      userName: doc['userName'],
      userRole: doc['userRole'],
      productId: doc['productId'],
      isApproved: doc['isApproved'],
      question: doc['question'],
      timestamp: DateTime.tryParse(doc['timestamp']),
    );
  }
}
