class SearchTermModel {
  String searchTerm;

  SearchTermModel({this.searchTerm});

  factory SearchTermModel.fromDocument(doc) {
    return SearchTermModel(searchTerm: doc['searchTerm']);
  }
}
