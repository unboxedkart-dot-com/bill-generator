// part of 'products_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class ProductsPageEvent extends Equatable {
  const ProductsPageEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsPage extends ProductsPageEvent {
  final String title;
  final String category;
  final String brand;
  final String condition;
  final String productCode;
  final int pageNumber;
  final bool isExact;

  const LoadProductsPage(
      {this.brand,
      this.category,
      this.condition,
      this.pageNumber,
      this.title,
      this.productCode,
      this.isExact});

  @override
  List<Object> get props => [];
}

class LoadFeaturedProducts extends ProductsPageEvent {
  final String category;
  final String brand;
  final String condition;

  const LoadFeaturedProducts(this.category, this.brand, this.condition);
}

class LoadBestSellerProducts extends ProductsPageEvent {
  final String category;
  final String brand;
  final String condition;

  const LoadBestSellerProducts(this.category, this.brand, this.condition);
}
