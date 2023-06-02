import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class WishlistApi {
  ApiCalls apiCalls = ApiCalls();
  Future getWishlistItems(String accessToken) async {
    const url = "https://server.unboxedkart.com/wishlist";
    final response = await apiCalls.get(url: url, accessToken: accessToken);
    return response;
  }

  Future addWishlistItem(String accessToken, String productId) async {
    const url = "https://server.unboxedkart.com/wishlist/add";
    final postBody = {"productId": productId};
    final response = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: postBody);
    const String usagePostUrl =
        "https://server.unboxedkart.com/usage-tracking/add-wishlist-item";
    final usagePostBody = {
      "productId": productId,
    };
    final usageResponse = await apiCalls.post(
        url: usagePostUrl, accessToken: accessToken, postBody: usagePostBody);
    return response;
  }

  Future removeWishlistItem(String accessToken, String productId) async {
    final url = "https://server.unboxedkart.com/wishlist/delete/$productId";
    final response = await apiCalls.delete(url: url, accessToken: accessToken);
    const String usagePostUrl =
        "https://server.unboxedkart.com/usage-tracking/remove-wishlist-item";
    final usagePostBody = {
      "productId": productId,
    };
    final usageResponse = await apiCalls.post(
        url: usagePostUrl, accessToken: accessToken, postBody: usagePostBody);
    return response;
  }
}
