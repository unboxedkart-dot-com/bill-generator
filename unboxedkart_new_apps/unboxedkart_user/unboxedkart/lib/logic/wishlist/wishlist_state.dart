part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedState extends WishlistState {
  final List<ProductModel> products;

  const WishlistLoadedState({this.products = const <ProductModel>[]});

}
