import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/apis/wishlist/wishlist.api.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/wishlist.repository.dart';
import 'package:unboxedkart/models/product/product.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistApi _wishlistApi = WishlistApi();
  WishlistRepository wishlistRepository = WishlistRepository();
  List<ProductModel> wishlistItems = [];

  final LocalRepository localRepo = LocalRepository();
  WishlistBloc() : super(WishlistLoadingState()) {
    on<LoadWishlistItems>(_onLoadWishlistItems);
    on<AddWishlistItem>(_onAddWishlistItem);
    on<RemoveWishlistItem>(_onRemoveWishlistItem);
  }

  _onLoadWishlistItems(
      LoadWishlistItems event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    final String accessToken = await localRepo.getAccessToken();
    if (accessToken != null) {
      final products =
          await wishlistRepository.handleGetWishlistItems(accessToken);
      wishlistItems = products;
    }
    emit(WishlistLoadedState(products: wishlistItems));
  }

  _onAddWishlistItem(AddWishlistItem event, Emitter<WishlistState> emit) async {
    // emit(WishlistLoadingState());
    final String accessToken = await localRepo.getAccessToken();
    final products = await wishlistRepository.handleAddWishlistItem(
        accessToken, event.productId);
    emit(WishlistLoadedState(products: products));
  }

  _onRemoveWishlistItem(
      RemoveWishlistItem event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    final String accessToken = await localRepo.getAccessToken();
    final response = await wishlistRepository.handleRemoveWishlistItem(
        accessToken, event.productId);
    
    
    final deletedItemIndex =
        wishlistItems.indexWhere((element) => element.id == event.productId);
    wishlistItems.removeAt(deletedItemIndex);
    emit(WishlistLoadedState(
      products: wishlistItems
      ));
  }
}
