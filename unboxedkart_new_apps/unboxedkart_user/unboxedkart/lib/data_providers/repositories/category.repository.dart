import 'package:unboxedkart/data_providers/apis/category/category.api.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';

import '../../models/product/product.dart';

class CategoryRepository {
  CategoryApi brandApi = CategoryApi();

  List<ConditionModel> handleGetConditionsByCategory(final data) {
    final List<ConditionModel> conditions = data
        .map<ConditionModel>(
            (category) => ConditionModel.fromDocument(category))
        .toList();
    return conditions;
  }

  List<BrandModel> handleGetBrandsByCategory(final data) {
    final List<BrandModel> brands = data
        .map<BrandModel>((condition) => BrandModel.fromDocument(condition))
        .toList();
    return brands;
  }

  Future<List<ProductModel>> handleGetFeaturedProducts(String categoryName) async {
    final products = await brandApi.getFeaturedProducts(categoryName);
    final List<ProductModel> featuredProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return featuredProducts;
  }

  Future<List<ProductModel>> handleGetBestSellingProducts(
      String categoryName) async {
    final products = await brandApi.getBestSellingProducts(categoryName);
    final List<ProductModel> bestSellingProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return bestSellingProducts;
  }
}