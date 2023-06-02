// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:http/http.dart' as http;
import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class CartApi {
  ApiCalls apiCall = ApiCalls();
  Future getCartItems(String accessToken) async {
    const url = "https://server.unboxedkart.com/cart";
    final response = await apiCall.get(url: url, accessToken: accessToken);
    return response;
  }

  Future getSavedLaterItems(String accessToken) async {
    const url = "https://server.unboxedkart.com/cart/save-later";
    final response = await apiCall.get(url: url, accessToken: accessToken);

    return response;
  }

  Future deleteCartItem(String accessToken, String cartItemId) async {
    final url = "https://server.unboxedkart.com/cart/delete/${cartItemId}";

    http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );
    // String usagePostUrl = "https://server.unboxedkart.com/usage-tracking/add-cart-item";
    // final usagePostBody = {
    //   "productId": productId,
    // };
    // final usageResponse = await apiCall.post(
    //     url: usagePostUrl, accessToken: accessToken, postBody: usagePostBody);
    return response.body;
  }

  Future removeProductFromSaveLater(
      String accessToken, String cartItemId) async {
    final url = "https://server.unboxedkart.com/cart/save-later/delete/${cartItemId}";
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );
    return response.body;
  }

  Future addCartItem(
      String accessToken, String productId, int productCount) async {
    const url = "https://server.unboxedkart.com/cart/add";

    final postBody = {"productId": productId, "productCount": productCount};
    var response = await apiCall.post(
        url: url, accessToken: accessToken, postBody: postBody);
    String usagePostUrl = "https://server.unboxedkart.com/usage-tracking/add-cart-item";
    final usagePostBody = {
      "productId": productId,
    };
    final usageResponse = await apiCall.post(
        url: usagePostUrl, accessToken: accessToken, postBody: usagePostBody);
    return response;
  }

  Future addProductToSaveLater(
      String accessToken, String productId, int productCount) async {
    const url = "https://server.unboxedkart.com/cart/save-later/add";
    final postBody = {"productId": productId, "productCount": productCount};
    var response = await apiCall.post(
        url: url, accessToken: accessToken, postBody: postBody);
    return response;
  }

  Future updateCartItem(
      String accessToken, String productId, int productCount) async {
    const url = "https://server.unboxedkart.com/cart/update";

    final updateBody = {"productId": productId, "productCount": productCount};

    var response = await apiCall.update(
        url: url, accessToken: accessToken, updateBody: updateBody);
    return response;
  }
}
