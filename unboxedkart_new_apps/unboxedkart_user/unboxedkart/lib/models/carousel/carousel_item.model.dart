class CarouselItemModel {
  final String carouselId;
  final String imageUrl;
  final String title;
  final bool exact;
  final String categoryCode;
  final String conditionCode;
  final String brandCode;
  final String routeName;
  final String productCode;
  final String productId;
  final int startingPrice;
  final int endingPrice;
  final String seriesCode;
  final String processorCode;
  final String screenSizeCode;

  CarouselItemModel(
      {this.carouselId,
      this.imageUrl,
      this.title,
      this.exact,
      this.brandCode,
      this.categoryCode,
      this.routeName,
      this.productCode,
      this.conditionCode,
      this.endingPrice,
      this.processorCode,
      this.productId,
      this.screenSizeCode,
      this.seriesCode,
      this.startingPrice});

  factory CarouselItemModel.fromDoc(doc) {
    return CarouselItemModel(
      carouselId: doc['_id'],
      imageUrl: doc['imageUrl'],
      title: doc['title'],
      exact: doc['isExact'],
      categoryCode: doc['categoryCode'],
      conditionCode: doc['conditionCode'],
      brandCode: doc['brandCode'],
      routeName: doc['routeName'],
      productCode: doc['productCode'],
      screenSizeCode: doc['screenSizeCode'],
      seriesCode: doc['seriesCode'],
      startingPrice: doc['startingPrice'],
      endingPrice: doc['endingPrice'],
      processorCode: doc['processorCode'],
      productId: doc['productId'],
    );
  }
}
