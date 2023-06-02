part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();
  
  @override
  List<Object> get props => [];
}

class HomePageLoadingState extends HomepageState {}

class HomePageLoadedState extends HomepageState {
  final List<ProductModel> featuredProducts;
  final List<ProductModel> bestSellers;
  const HomePageLoadedState(
      {this.featuredProducts = const <ProductModel>[],
      this.bestSellers = const <ProductModel>[]});

  @override
  List<Object> get props => [featuredProducts, bestSellers];}
