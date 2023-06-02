class CategoryModel {
  final String categoryName;
  final String imageUrl;
  final String slug;

  CategoryModel({this.categoryName, this.imageUrl, this.slug});

  factory CategoryModel.fromDocument(doc) {
    return CategoryModel(
      categoryName: doc['categoryName'],
      imageUrl: doc['imageUrl'],
      slug: doc['slug']
    );
  }
}
