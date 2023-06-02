class ReferralModel {
  final String referreName;
  final int cashBackAmount;
  final bool cashBackIsCredited;
  final bool isCompleted;
  final DateTime timestamp;

  ReferralModel(
      {this.referreName,
      this.cashBackAmount,
      this.isCompleted,
      this.cashBackIsCredited,
      this.timestamp});

  factory ReferralModel.fromDocument(doc) {
    return ReferralModel(
        referreName: doc['refereeDetails']['userName'],
        cashBackAmount: doc['cashBackDetails']['cashBackAmount'],
        cashBackIsCredited: doc['cashBackDetails']['isCredited'],
        isCompleted: doc['isCompeleted'],
        timestamp: DateTime.parse(doc['timestamp']));
  }
}
