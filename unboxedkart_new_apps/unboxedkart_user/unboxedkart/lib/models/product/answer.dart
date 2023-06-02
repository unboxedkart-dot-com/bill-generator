class Answer {
  String answer;
  String userId;
  String authorName;

  Answer({this.answer, this.authorName, this.userId});

  factory Answer.fromDocument(doc) {
    return (Answer(
        answer: doc['answer'],
        userId: doc['userId'],
        authorName: doc['authorName']));
  }
}
