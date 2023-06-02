part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWishlistItems extends WishlistEvent {}

class RemoveWishlistItem extends WishlistEvent {
  final String productId;

  const RemoveWishlistItem(this.productId);

}

class AddWishlistItem extends WishlistEvent {
  final String productId;

  const AddWishlistItem(this.productId);

}
