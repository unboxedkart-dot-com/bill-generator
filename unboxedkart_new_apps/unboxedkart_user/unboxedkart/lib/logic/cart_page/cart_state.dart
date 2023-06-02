part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItemModel> cartItems;
  final List<SavedLaterModel> saveLaterItems;
  final int cartTotal;
  const CartLoadedState(
      {this.cartItems = const <CartItemModel>[],
      this.cartTotal,
      this.saveLaterItems});

  @override
  List<Object> get props => [cartItems];
}

class SaveLaterLoading extends CartState {}

class SaveLaterLoaded extends CartState {
  final List<SavedLaterModel> products;
  const SaveLaterLoaded({this.products = const <SavedLaterModel>[]});

  @override
  List<Object> get props => [products];
}
