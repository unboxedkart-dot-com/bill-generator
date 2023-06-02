import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class BrandApi {
  ApiCalls apiCalls = ApiCalls();

  Future getFeaturedProducts(String brandName) async {
    final url =
        "https://server.unboxedkart.com/products/featured-products?brand=$brandName";
    final response = apiCalls.get(url: url);
    return response;
  }

  Future getBestSellingProducts(String brandName) async {
    final url =
        "https://server.unboxedkart.com/products/best-sellers?brand=$brandName";
    final response = apiCalls.get(url: url);
    return response;
  }
}
