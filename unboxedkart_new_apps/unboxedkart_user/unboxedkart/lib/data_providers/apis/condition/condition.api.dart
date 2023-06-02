import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class ConditionApi {
  ApiCalls apiCalls = ApiCalls();

  Future getFeaturedProducts(String conditionName) async {
    final url =
        "https://server.unboxedkart.com/products/featured-products?condition=$conditionName";
    final response = apiCalls.get(url: url);
    return response;
  }

  Future getBestSellingProducts(String conditionName) async {
    final url = "https://server.unboxedkart.com/products/best-sellers?condition=$conditionName";
    final response = apiCalls.get(url: url);
    return response;
  }
}
