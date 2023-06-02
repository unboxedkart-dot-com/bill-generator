class ConditionModel {
  final String conditionName;
  final String imageUrl;
  final String slug;

  ConditionModel({this.conditionName, this.imageUrl, this.slug});

  factory ConditionModel.fromDocument(doc) {
    return ConditionModel(
        conditionName: doc['conditionName'],
        imageUrl: doc['imageUrl'],
        slug: doc['slug']);
  }
}
