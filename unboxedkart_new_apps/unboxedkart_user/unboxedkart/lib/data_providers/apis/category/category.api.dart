import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class CategoryApi {
  ApiCalls apiCalls = ApiCalls();

  Future getFeaturedProducts(String categoryName) async {
    final url =
        "https://server.unboxedkart.com/products/featured-products?category=$categoryName";
    final response = apiCalls.get(url: url);
    return response;
  }

  Future getBestSellingProducts(String categoryName) async {
    final url = "https://server.unboxedkart.com/products/best-sellers?category=$categoryName";
    final response = apiCalls.get(url: url);
    return response;
  }
}
