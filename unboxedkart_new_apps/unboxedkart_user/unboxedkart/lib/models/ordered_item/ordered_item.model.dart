class OrderedItemModel {
  final int pricePerItem;
  final int productCount;
  final int total;
  final String imageUrl;
  final String title;
  final String color;
  final String condition;
  final String brand;
  final String category;
  final String productId;

  OrderedItemModel(
      {this.pricePerItem,
      this.productCount,
      this.total,
      this.imageUrl,
      this.title,
      this.color,
      this.condition,
      this.brand,
      this.productId,
      this.category});

  factory OrderedItemModel.fromDocument(doc) {
    return OrderedItemModel(
      productCount: doc['productCount'],
      pricePerItem: doc['pricePerItem'],
      productId: doc['productId'],
      total: doc['total'],
      imageUrl: doc['productDetails']['imageUrl'],
      title: doc['productDetails']['title'],
      color: doc['productDetails']['color'],
      condition: doc['productDetails']['condition'],
      brand: doc['productDetails']['brand'],
      category: doc['productDetails']['category'],
    );
  }
}
