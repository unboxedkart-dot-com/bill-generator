import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class ReviewsApi {
  ApiCalls apiCalls = ApiCalls();

  Future getUserReviews(String accessToken) async {
    const url = "https://server.unboxedkart.com/reviews";
    final reviews = await apiCalls.get(url: url, accessToken: accessToken);

    return reviews;
  }

  Future getUserReview(String accessToken, String reviewId) async {
    final url = "https://server.unboxedkart.com/reviews/$reviewId";
    final reviews = await apiCalls.get(url: url, accessToken: accessToken);

    return reviews;
  }

  Future createReview({
    String accessToken,
    int rating,
    String reviewTitle,
    String reviewContent,
    String productId,
    String productTitle,
    String imageUrl,
  }) async {
    const url = "https://server.unboxedkart.com/reviews/create";
    final postBody = {
      "rating": rating,
      "reviewTitle": reviewTitle,
      "reviewContent": reviewContent,
      "productId": productId,
      "productTitle": productTitle,
      "imageUrl": imageUrl,
    };
    final response = await apiCalls.post(
        url: url, postBody: postBody, accessToken: accessToken);
    return response;
  }

  Future updateReview({
    String accessToken,
    String reviewId,
    int rating,
    String reviewTitle,
    String reviewContent,
  }) async {
    const url = "https://server.unboxedkart.com/reviews/update";
    final updateBody = {
      "reviewId": reviewId,
      "rating": rating,
      "reviewTitle": reviewTitle,
      "reviewContent": reviewContent,
    };
    final response = await apiCalls.update(
        url: url, updateBody: updateBody, accessToken: accessToken);
    return response;
  }

  Future deleteReview({String accessToken, String reviewId}) async {
    final url =
        "https://server.unboxedkart.com/reviews/delete/$reviewId";
    final response = await apiCalls.delete(url: url, accessToken: accessToken);
    return response;
  }

  Future getProductReviews(String productId) async {
    final url = "https://server.unboxedkart.com/reviews/product/$productId";
    final response = await apiCalls.get(url: url);

    return response;
  }

  Future getAllProductReviews(String productId) async {
    final url =
        "https://server.unboxedkart.com/reviews/product/all/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }
}
