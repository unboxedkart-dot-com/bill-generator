import 'package:unboxedkart/data_providers/apis/brand/brand.api.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';
import 'package:unboxedkart/models/category/category.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';

import '../../models/product/product.dart';

class BrandRepository {
  BrandApi brandApi = BrandApi();
  final categories = {"title": "apple", "brand": "apple"};

  final Map<String, dynamic> categoriesData = {
    "apple": [
      {
        "categoryName": "iPhone",
        "imageUrl": "assets/images/categories/phone.webp",
        "slug": "mobile-phone"
      },
      {
        "categoryName": "Macbook",
        "imageUrl": "assets/images/categories/laptop.webp",
        "slug": "laptop"
      },
      {
        "categoryName": "Airpods",
        "imageUrl": "assets/images/categories/earphones.webp",
        "slug": "earphones"
      },
      {
        "categoryName": "iPad",
        "imageUrl": "assets/images/categories/tablet.webp",
        "slug": "tablet"
      },
      {
        "categoryName": "HomePod",
        "imageUrl": "assets/images/categories/speaker.webp",
        "slug": "speaker"
      },
      {
        "categoryName": "Accesories",
        "imageUrl": "assets/images/categories/accessory.webp",
        "slug": "accessory"
      },
    ],
    "samsung": [],
    "huawei": [],
    "oneplus": []
  };

  final conditionsData = {
    "apple": [
      {
        "conditionName": "Unboxed",
        "imageUrl": "assets/images/conditions/unboxed.webp",
        "slug": "unboxed",
      },
      {
        "conditionName": "Grade-a",
        "imageUrl": "assets/images/conditions/grade-a.webp",
        "slug": "grade-a",
      },
      {
        "conditionName": "Grade-b",
        "imageUrl": "assets/images/conditions/grade-b.webp",
        "slug": "grade-b",
      },
      {
        "conditionName": "Grade-c",
        "imageUrl": "assets/images/conditions/grade-c.webp",
        "slug": "grade-c",
      }
    ],
  };

  List<ConditionModel> handleGetConditionsByBrand(final data) {
    final List<ConditionModel> conditionsByBrand = data
        .map<ConditionModel>(
            (condition) => ConditionModel.fromDocument(condition))
        .toList();
    return conditionsByBrand;
  }

  List<CategoryModel> handleGetCategoriesByBrand(final data) {
    final List<CategoryModel> categoriesByBrand = data
        .map<CategoryModel>((category) => CategoryModel.fromDocument(category))
        .toList();
    return categoriesByBrand;
  }

  Future<List<ProductModel>> handleGetFeaturedProducts(String brandName) async {
    final products = await brandApi.getFeaturedProducts(brandName);
    final List<ProductModel> featuredProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return featuredProducts;
  }

  Future<List<ProductModel>> handleGetBestSellingProducts(
      String brandName) async {
    final products = await brandApi.getBestSellingProducts(brandName);
    final List<ProductModel> bestSellingProducts = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    return bestSellingProducts;
  }
}
