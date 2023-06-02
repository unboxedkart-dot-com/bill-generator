class BrandModel {
  final String brandName;
  final String imageUrl;
  final String slug;

  BrandModel({this.brandName, this.imageUrl, this.slug});

  factory BrandModel.fromDocument(doc) {
    return BrandModel(
      brandName: doc['brandName'],
      imageUrl: doc['imageUrl'],
      slug: doc['slug']
    );
  }
}
