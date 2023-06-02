import 'package:unboxedkart/data_providers/apis/products_page/products.api.dart';
import 'package:unboxedkart/dtos/get-selected-variant.dto.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/models/product_details/product-variants-data.dart';
import 'package:unboxedkart/models/product_details/product_details.model.dart';

class ProductsRepository {
  final ProductsApi productsApi = ProductsApi();

  Future<List<ProductModel>> handleGetBestSellers(
      {String category, String brand, String condition}) async {
    final products =
        await productsApi.getBestSellers(category, brand, condition);
    final List<ProductModel> bestSellers = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return bestSellers;
  }

  Future<List<ProductModel>> handleGetFeaturedProducts(
      String category, String brand, String condition) async {
    final products =
        await productsApi.getFeaturedProducts(category, brand, condition);
    final featuredProducts = await products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();

    return featuredProducts;
  }

  Future<List<ProductModel>> handleGetSearchedProducts(
      bool isExact,
      String title,
      String category,
      String brand,
      String condition,
      String productCode,
      int pageNumber) async {
    final products = await productsApi.getSearchedProducts(
        isExact, title, category, brand, condition, productCode, pageNumber);

    final List<ProductModel> searchedProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();

    return searchedProducts;
  }

  Future handleGetSimilarProducts(String productId) async {
    final response = await productsApi.getSimilarProducts(productId);

    final List<ProductModel> similarProducts = response
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return similarProducts;
  }

  Future handleGetRelatedProducts(String productId) async {
    final response = await productsApi.getRelatedProducts(productId);

    final List<ProductModel> relatedProducts = response
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return relatedProducts;
  }

  Future handleGetProductSpecs(String productId) async {
    final response = await productsApi.getProductSpecs(productId);
    final List<IndividualProductSpecModel> productSpecs = response != null
        ? response
            .map<IndividualProductSpecModel>(
                (e) => IndividualProductSpecModel.fromDocument(e))
            .toList()
        : null;
    return productSpecs;
  }

  Future handleGetProductDescription(String productId) async {
    final response = await productsApi.getProductDescription(productId);
    return response;
  }

  Future handleGetProduct(String productId, {String accessToken}) async {
    final product = await productsApi.getProduct(productId, accessToken: accessToken);
    final ProductModel singleProduct = ProductModel.fromDoc(product);
    return {
      "product": singleProduct,
    };
  }

  Future handleGetProductVariants(String productCode) async {
    final response = await productsApi.getProductVariants(productCode);
    final ProductVariantsData variantsData =
        ProductVariantsData.fromDocument(response);
    return variantsData;
  }

  Future handleGetSelectedProductVariant(
      GetSelectedVariantDto selectedvariant) async {
    final response =
        await productsApi.getSelectedProductVariant(selectedvariant);
    return response;
  }
}
