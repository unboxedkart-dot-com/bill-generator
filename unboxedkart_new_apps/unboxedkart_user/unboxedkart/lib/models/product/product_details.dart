class ProductDetail {
  String title;
  List<Map<dynamic, String>> productDetails;

  ProductDetail({this.title, this.productDetails});

  factory ProductDetail.fromDocument(doc) {
    return ProductDetail(
        title: doc['title'], productDetails: doc['productDetails']);
  }
}
