// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:unboxedkart/data_providers/apis/api_calls.dart';
import 'package:unboxedkart/dtos/get-selected-variant.dto.dart';

class ProductsApi {
  ApiCalls apiCalls = ApiCalls();
  Future getBestSellers(String category, String brand, String condition) async {
    final url =
        "https://server.unboxedkart.com/products/best-sellers?category$category&condition=$condition&brand=$brand";
    final response = await apiCalls.get(url: url);

    return response;
  }

  Future getFeaturedProducts(
      String category, String brand, String condition) async {
    const url = "https://server.unboxedkart.com/products/featured-products";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future getSearchedProducts(
      bool isExact,
      String title,
      String category,
      String brand,
      String condition,
      String productCode,
      int pageNumber) async {
    final String url =
        "https://server.unboxedkart.com/search?productCode=$productCode&title=$title&category=$category&brand=$brand&condition=$condition&p=$pageNumber";
    print("getting more products $url");
    final response = await apiCalls.get(url: url);

    return response;
  }

  Future getProduct(String productId, {String accessToken}) async {
    final String url = "https://server.unboxedkart.com/products?q=$productId";
    final response = await apiCalls.get(url: url);
    // const String postUrl =
    //     "https://server.unboxedkart.com/usage-tracking/viewed-product";
    // final postBody = {R
    //   "productId": productId,
    // };
    // print("post urk");
    // print(postBody);
    // final postResponse =
    //     await apiCalls.post(accessToken: accessToken, postBody: productId);
    // print("product response");
    // print(response);
    return response;
  }

  Future getSimilarProducts(String productId) async {
    final String url =
        "https://server.unboxedkart.com/products/similar-products/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future getRelatedProducts(String productId) async {
    final String url =
        "https://server.unboxedkart.com/products/related-products/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future getProductSpecs(String productId) async {
    final String url =
        "https://server.unboxedkart.com/product-details/specs/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future getProductDescription(String productId) async {
    final String url =
        "https://server.unboxedkart.com/product-details/description/$productId";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future getProductVariants(String productCode) async {
    final String url =
        "https://server.unboxedkart.com/product-details/variants?id=$productCode";
    print("getting variants data");
    final response = await apiCalls.get(url: url);
    print(response);
    return response;
  }

  Future getSelectedProductVariant(
      GetSelectedVariantDto selectedVariant) async {
    final String url =
        "https://server.unboxedkart.com/products/variant?product=${selectedVariant.productCode}&condition=${selectedVariant.conditionCode}&storage=${selectedVariant.storageCode}&color=${selectedVariant.colorCode}&processor=${selectedVariant.processorCode}&ram=${selectedVariant.ramCode}&combination=${selectedVariant.combinationCode}&screenSize=${selectedVariant.screenSizeCode}";
    final response = await apiCalls.get(url: url);

    return response;
  }
}
