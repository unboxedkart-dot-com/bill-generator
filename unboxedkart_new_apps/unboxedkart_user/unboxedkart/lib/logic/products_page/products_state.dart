// part of 'products_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:unboxedkart/models/product/product.dart';

abstract class ProductsPageState extends Equatable {
  const ProductsPageState();

  @override
  List<Object> get props => [];
}

class ProductsPageLoadingState extends ProductsPageState {
  final bool isFirstFetch;
  final List<ProductModel> oldProducts;

  const ProductsPageLoadingState({this.isFirstFetch = true, this.oldProducts});

  @override
  List<Object> get props => [isFirstFetch, oldProducts];
}

class ProductsPageLoadedState extends ProductsPageState {
  final List<ProductModel> searchedProducts;
  const ProductsPageLoadedState(
      {this.searchedProducts = const <ProductModel>[]});

  @override
  List<Object> get props => [searchedProducts];
}

/*


*/