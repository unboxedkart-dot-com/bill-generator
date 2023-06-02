part of 'search_bloc.dart';

abstract class SearchPageState extends Equatable {
  const SearchPageState();

  @override
  List<Object> get props => [];
}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageLoadedState extends SearchPageState {
  final List<String> recentSearchTerms;
  final List<String> popularSearchTerms;

  const SearchPageLoadedState({this.recentSearchTerms, this.popularSearchTerms});

  // final List<ProductModel> searchedProducts;
  // const SearchPageLoadedState({this.searchedProducts = const <ProductModel>[]});

  @override
  List<Object> get props => [recentSearchTerms, popularSearchTerms];
}
