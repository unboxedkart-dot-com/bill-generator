class FaqModel {
  final String question;
  final String answer;

  FaqModel({this.question, this.answer});

  factory FaqModel.fromDoc(doc) {
    return FaqModel(answer: doc['answer'], question: doc['question']);
  }
}
