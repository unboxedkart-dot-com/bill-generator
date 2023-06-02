part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartItems extends CartEvent {}

class LoadSaveLater extends CartEvent {}

class RemoveCartItem extends CartEvent {
  final String productId;
  const RemoveCartItem({this.productId});
}

class RemoveSavedLater extends CartEvent {
  final String productId;
  const RemoveSavedLater({this.productId});
}

class AddCartItem extends CartEvent {
  final String productId;
  final int productCount;
  const AddCartItem({this.productId, this.productCount = 1});
}

class AddSavedToLater extends CartEvent {
  final String productId;
  final int productCount;
  const AddSavedToLater({this.productId, this.productCount = 1});
}

class UpdateCartItem extends CartEvent {
  final String productId;
  final int updatedProductCount;
  const UpdateCartItem({this.productId, this.updatedProductCount});
}

class MoveSaveLaterToCart extends CartEvent {
  final String productId;
  final int productCount;
  const MoveSaveLaterToCart({this.productId, this.productCount = 1});
}
