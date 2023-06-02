class ReviewModel {
  final String userName;
  final String reviewId;
  final int rating;
  final String reviewTitle;
  final String reviewContent;
  final String productTitle;
  final String imageUrl;
  final String productId;
  final DateTime timestamp;

  ReviewModel(
      {this.userName,
      this.reviewId,
      this.rating,
      this.reviewTitle,
      this.reviewContent,
      this.productTitle,
      this.imageUrl,
      this.productId,
      this.timestamp});

  factory ReviewModel.fromDoc(doc) {
    return ReviewModel(
      userName: doc['userName'],
      reviewId: doc['_id'],
      rating: doc['rating'],
      reviewTitle: doc['reviewTitle'],
      reviewContent: doc['reviewContent'],
      productTitle: doc['productTitle'],
      imageUrl: doc['imageUrl'],
      productId: doc['productId'],
      timestamp: DateTime.tryParse(doc['timestamp']),
    );
  }
}
