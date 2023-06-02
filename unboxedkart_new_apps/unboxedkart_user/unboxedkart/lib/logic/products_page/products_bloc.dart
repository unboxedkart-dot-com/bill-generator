import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:unboxedkart/data_providers/repositories/products.repository.dart';
import 'package:unboxedkart/logic/products_page/products_event.dart';
import 'package:unboxedkart/logic/products_page/products_state.dart';
import 'package:unboxedkart/models/product/product.dart';

class ProductsPageBloc extends Bloc<ProductsPageEvent, ProductsPageState> {
  int page = 1;
  List<ProductModel> products = [];
  final ProductsRepository productsRepository = ProductsRepository();
  ProductsPageBloc() : super(const ProductsPageLoadingState()) {
    on<LoadProductsPage>(_onLoadProducts);
    on<LoadFeaturedProducts>(_onLoadFeaturedProducts);
    on<LoadBestSellerProducts>(_onLoadBestSellers);
  }

  void _onLoadProducts(
      LoadProductsPage event, Emitter<ProductsPageState> emit) async {
    page == 1
        ? emit(const ProductsPageLoadingState(isFirstFetch: true))
        : emit(ProductsPageLoadingState(
            oldProducts: this.products, isFirstFetch: false));
    print("page to fetch $page");
    final List<ProductModel> products =
        await productsRepository.handleGetSearchedProducts(
            event.isExact,
            event.title,
            event.category,
            event.brand,
            event.condition,
            event.productCode,
            page);
    page++;
    print("new page $page");

    this.products.addAll(products);

    emit(ProductsPageLoadedState(searchedProducts: this.products));

    final bloc = ProductsPageBloc();
  }

  FutureOr<void> _onLoadFeaturedProducts(
      LoadFeaturedProducts event, Emitter<ProductsPageState> emit) async {
    emit(const ProductsPageLoadingState());
    final List<ProductModel> products =
        await productsRepository.handleGetFeaturedProducts(
            event.category, event.brand, event.condition);
    emit(ProductsPageLoadedState(searchedProducts: products));
  }

  FutureOr<void> _onLoadBestSellers(
      LoadBestSellerProducts event, Emitter<ProductsPageState> emit) async {
    emit(const ProductsPageLoadingState());
    final List<ProductModel> products =
        await productsRepository.handleGetBestSellers(
            category: event.category,
            brand: event.brand,
            condition: event.condition);
    emit(ProductsPageLoadedState(searchedProducts: products));
  }
}
