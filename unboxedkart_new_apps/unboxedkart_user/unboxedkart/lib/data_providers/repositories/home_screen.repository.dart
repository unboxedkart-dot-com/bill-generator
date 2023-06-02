import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/carousel_item.dart';

class HomeScreenRepository {
  final brandsData = [
    {
      "brandName": "Apple",
      "imageUrl": "assets/images/brand_logos/apple.webp",
      "slug": "apple"
    },
    {
      "brandName": "Samsung",
      "imageUrl": "assets/images/brand_logos/samsung.webp",
      "slug": "samsung"
    },
    {
      "brandName": "Google",
      "imageUrl": "assets/images/brand_logos/google.webp",
      "slug": "huawei"
    },
    {
      "brandName": "Oneplus",
      "imageUrl": "assets/images/brand_logos/oneplus.webp",
      "slug": "oneplus"
    },
  ];

  final categoriesData = [
    {
      "categoryName": "Phone",
      "imageUrl": "assets/images/categories/apple/mobile-phone.webp",
      "slug": "mobile-phone"
    },
    {
      "categoryName": "Laptop",
      "imageUrl": "assets/images/categories/apple/laptop.webp",
      "slug": "laptop"
    },
    {
      "categoryName": "Earphones",
      "imageUrl": "assets/images/categories/apple/earphones.webp",
      "slug": "earphones"
    },
    {
      "categoryName": "iPad",
      "imageUrl": "assets/images/categories/apple/tablet.webp",
      "slug": "tablet"
    },
    {
      "categoryName": "Watch",
      "imageUrl": "assets/images/categories/apple/watch.webp",
      "slug": "watch"
    },
    {
      "categoryName": "Accessories",
      "imageUrl": "assets/images/categories/apple/accessories.webp",
      "slug": "accessories"
    },
    {
      "categoryName": "Speaker",
      "imageUrl": "assets/images/categories/apple/speaker.webp",
      "slug": "speaker"
    },
  ];

  final conditionsData = [
    {
      "conditionName": "UnBoxed",
      "imageUrl": "assets/images/conditions/home/class-unboxed.png",
      "slug": "unboxed",
    },
    {
      "conditionName": "Grade A",
      "imageUrl": "assets/images/conditions/home/class-a.png",
      "slug": "grade-a",
    },
    {
      "conditionName": "Grade B",
      "imageUrl": "assets/images/conditions/home/class-b.png",
      "slug": "grade-b",
    },
    {
      "conditionName": "Grade C",
      "imageUrl": "assets/images/conditions/home/class-c.png",
      "slug": "grade-c",
    },
  ];

  Future handleGetBrandsData() {
    return json.decode(brandsData.toString());
  }

  Future handleGetCategoriesData() {
    return json.decode(categoriesData.toString());
  }

  Future handleGetConditionsData() {
    return json.decode(conditionsData.toString());
  }

  List<Widget> handleGetHomeScreenCarouselItems() {
    
    
    List<CarouselItemModel> carouselItemModels = [
      CarouselItemModel(
        title: "iPhone 13 Pro",
        productCode: "apple-iphone-13-pro",
        exact : true,
        imageUrl:
            "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/carousels/mobile/main/1.webp",
      ),
      CarouselItemModel(
        categoryCode: "earphones",
        brandCode: "apple",
        imageUrl:
            "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/carousels/mobile/main/2.webp",
      ),
      CarouselItemModel(
        title: "iphone",
        imageUrl:
            "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/carousels/mobile/main/3.webp",
      ),
      CarouselItemModel(
        title: "iphone",
        imageUrl:
            "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/carousels/mobile/main/4.webp",
      ),
      CarouselItemModel(
        title: "iphone",
        imageUrl:
            "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/carousels/mobile/main/5.webp",
      ),
      CarouselItemModel(
        title: "iphone",
        imageUrl:
            "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/carousels/mobile/main/6.webp",
      ),
    ];

    List<Widget> sampleWidgets = [
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        color: Colors.deepOrangeAccent,
      ),
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        color: Colors.green,
      ),
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        color: Colors.black,
      ),
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        color: Colors.orange,
      ),
    ];

    List<Widget> sampleWidgetsNew = [
      Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          color: const Color(0xffffde59)),
      Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          color: const Color(0xff191970)),
      Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          color: const Color(0xff189AB4)),
      Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          color: const Color(0xff75E6DA)),
      Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          color: const Color(0xffD4F1F4)),
    ];

    List<CarouselItem> carouselItems =
        carouselItemModels.map((e) => CarouselItem(carouselItem: e)).toList();
    return carouselItems;
    // return sampleWidgetsNew;
    // return carouselItemModels;
  }
}
