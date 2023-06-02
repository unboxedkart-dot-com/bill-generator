class ReviewsDataModel {
  // final String productId;
  final num averageRating;
  final int fiveStarCount;
  final int fourStarCount;
  final int threeStarCount;
  final int twoStarCount;
  final int oneStarCount;
  final int totalReviewsCount;

  ReviewsDataModel(
      {this.averageRating,
      this.fiveStarCount,
      this.fourStarCount,
      this.threeStarCount,
      this.twoStarCount,
      this.oneStarCount,
      this.totalReviewsCount});

  factory ReviewsDataModel.fromDoc(doc) {
    print(doc);
    bool reviewsIsEmpty = doc == null ? true : false;
    print("reviews status");
    print(reviewsIsEmpty);
    print(doc);
    return ReviewsDataModel(
      // averageRating: 3.705,
      // fiveStarCount: 20,
      // fourStarCount: 80,
      // threeStarCount: 50,
      // twoStarCount: 2,
      // oneStarCount: 4,
      // totalReviewsCount: 156,
      averageRating: reviewsIsEmpty ? 0 : doc['averageRating'],
      fiveStarCount: reviewsIsEmpty ? 0 : doc['fiveStarCount'],
      fourStarCount: reviewsIsEmpty ? 0 : doc['fourStarCount'],
      threeStarCount: reviewsIsEmpty ? 0 : doc['threeStarCount'],
      twoStarCount: reviewsIsEmpty ? 0 : doc['twoStarCount'],
      oneStarCount: reviewsIsEmpty ? 0 : doc['oneStarCount'],
      totalReviewsCount: reviewsIsEmpty ? 0 : doc['totalReviewsCount'],
    );
  }
}
