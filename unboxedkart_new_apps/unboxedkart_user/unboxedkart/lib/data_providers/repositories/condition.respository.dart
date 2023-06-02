import 'package:unboxedkart/data_providers/apis/condition/condition.api.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/category/category.model.dart';

import '../../models/product/product.dart';

class ConditionRepository {
  ConditionApi conditionApi = ConditionApi();

  List<BrandModel> handleGetBrandsByCondition(final data) {
    final List<BrandModel> brands = data
        .map<BrandModel>(
            (brand) => BrandModel.fromDocument(brand))
        .toList();
    return brands;
  }

  List<CategoryModel> handleGetCategoriesByCondition(final data) {
    final List<CategoryModel> categories = data
        .map<CategoryModel>((category) => CategoryModel.fromDocument(category))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> handleGetFeaturedProducts(String categoryName) async {
    final products = await conditionApi.getFeaturedProducts(categoryName);
    final List<ProductModel> featuredProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return featuredProducts;
  }

  Future<List<ProductModel>> handleGetBestSellingProducts(
      String categoryName) async {
    final products = await conditionApi.getBestSellingProducts(categoryName);
    final List<ProductModel> bestSellingProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return bestSellingProducts;
  }
}