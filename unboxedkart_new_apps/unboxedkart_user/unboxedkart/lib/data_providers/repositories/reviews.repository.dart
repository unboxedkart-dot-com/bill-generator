import 'package:unboxedkart/data_providers/apis/reviews/reviews.api.dart';
import 'package:unboxedkart/models/reviews/review.model.dart';
import 'package:unboxedkart/models/reviews/reviews_data.model.dart';

class ReviewsRepository {
  ReviewsApi reviewsApi = ReviewsApi();

  Future<List<ReviewModel>> handleGetUserReviews(String accessToken) async {
    final reviews = await reviewsApi.getUserReviews(accessToken);

    final List<ReviewModel> userReviews = reviews
        .map<ReviewModel>((product) => ReviewModel.fromDoc(product))
        .toList();
    return userReviews;
  }

  Future handleGetUserReview(String accessToken, String reviewId) async {
    final review = await reviewsApi.getUserReview(accessToken, reviewId);
    ReviewModel reviewData =
        review == null ? null : ReviewModel.fromDoc(review);
    return reviewData;
  }

  Future handleCreateReview(
      {String accessToken,
      String productId,
      String productTitle,
      String imageUrl,
      int rating,
      String reviewTitle,
      String reviewContent}) async {
    final response = await reviewsApi.createReview(
        accessToken: accessToken,
        productId: productId,
        productTitle: productTitle,
        imageUrl: imageUrl,
        rating: rating,
        reviewTitle: reviewTitle,
        reviewContent: reviewContent);
    return response;
  }

  Future handleUpdateReview(
      {String accessToken,
      String reviewId,
      int rating,
      String reviewTitle,
      String reviewContent}) async {
    final response = await reviewsApi.updateReview(
        accessToken: accessToken,
        rating: rating,
        reviewId: reviewId,
        reviewTitle: reviewTitle,
        reviewContent: reviewContent);
    return response;
  }

  Future handleDeleteReview({String accessToken, String reviewId}) async {
    final response = await reviewsApi.deleteReview(
        reviewId: reviewId, accessToken: accessToken);
    return response;
  }

  Future handleGetProductReviews(String productId) async {
    final response = await reviewsApi.getProductReviews(productId);
    final List<ReviewModel> productReviews = response['reviews']
        .map<ReviewModel>((doc) => ReviewModel.fromDoc(doc))
        .toList();
    print("getting product reviews");
    print(productReviews);
    final ReviewsDataModel reviewsData = productReviews.isNotEmpty
        ? ReviewsDataModel.fromDoc(response['reviewsData'])
        : null;
    
    return {"reviews": productReviews, "reviewsData": reviewsData};
  }
}
