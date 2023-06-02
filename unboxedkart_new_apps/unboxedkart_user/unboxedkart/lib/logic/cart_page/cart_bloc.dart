import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/cart.repository.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/models/cart_item/cart_item.model.dart';
import 'package:unboxedkart/models/save_later/save_later.model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();
  final LocalRepository localRepo = LocalRepository();
  List<CartItemModel> cartItems;
  List<SavedLaterModel> saveLaterItems;
  int cartTotal = 0;

  CartBloc() : super(CartLoading()) {
    on<LoadCartItems>(_onLoadCartItems);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<AddCartItem>(_onAddCartItem);
    on<AddSavedToLater>(_onAddSaveLater);
    on<RemoveSavedLater>(_onRemoveSaveLater);
    on<MoveSaveLaterToCart>(_onMoveToCart);
    on<UpdateCartItem>(_onUpdateCartItem);
  }

  void _onLoadCartItems(LoadCartItems event, Emitter<CartState> emit) async {
    final accessToken = await localRepo.getAccessToken();
    if (accessToken != null) {
      emit(CartLoading());
      final List<CartItemModel> cartItems =
          await _cartRepository.handleGetCartItems(accessToken);
      final List<SavedLaterModel> saveLaterProducts =
          await _cartRepository.handleGetSaveLaterItems(accessToken);
      this.cartItems = cartItems;
      saveLaterItems = saveLaterProducts;
      cartTotal = _getCartTotal();
      emit(CartLoadedState(
          cartItems: this.cartItems,
          cartTotal: cartTotal,
          saveLaterItems: saveLaterProducts));
    }
  }

  void _onLoadSaveLater(LoadSaveLater event, Emitter<CartState> emit) async {
    final accessToken = await localRepo.getAccessToken();
    if (accessToken != null) {
      emit(SaveLaterLoading());
      final List<SavedLaterModel> saveLaterProducts =
          await _cartRepository.handleGetCartItems(accessToken);
      saveLaterItems = saveLaterProducts;
      emit(SaveLaterLoaded(products: saveLaterItems));
    }
  }

  void _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final accessToken = await localRepo.getAccessToken();
    await _cartRepository.handleDeleteCartItem(accessToken, event.productId);
    final deletedItemIndex =
        cartItems.indexWhere((element) => element.productId == event.productId);
    cartItems.removeAt(deletedItemIndex);
    cartTotal = _getCartTotal();
    await localRepo.removeCartItem(event.productId);
    emit(CartLoadedState(
        cartItems: cartItems,
        cartTotal: cartTotal,
        saveLaterItems: saveLaterItems));
  }

  void _onAddCartItem(AddCartItem event, Emitter<CartState> emit) async {
    final accessToken = await localRepo.getAccessToken();
    await localRepo.addCartItem(event.productId);
    await _cartRepository.handleAddCartItem(
        accessToken, event.productId, event.productCount);
  }

  void _onAddSaveLater(AddSavedToLater event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final accessToken = await localRepo.getAccessToken();
    await _cartRepository.handleAddSaveLater(
        accessToken, event.productId, event.productCount);
    final deletedItemIndex =
        cartItems.indexWhere((element) => element.productId == event.productId);
    cartItems.removeAt(deletedItemIndex);
    await _cartRepository.handleDeleteCartItem(accessToken, event.productId);
    await localRepo.removeCartItem(event.productId);
    saveLaterItems = await _cartRepository.handleGetSaveLaterItems(accessToken);
    emit(CartLoadedState(saveLaterItems: saveLaterItems, cartItems: cartItems));
  }

  void _onRemoveSaveLater(
      RemoveSavedLater event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final accessToken = await localRepo.getAccessToken();
    await _cartRepository.handleRemoveSaveLater(accessToken, event.productId);
    final deletedItemIndex = saveLaterItems
        .indexWhere((element) => element.productId == event.productId);
    saveLaterItems.removeAt(deletedItemIndex);
    cartItems = cartItems;
    cartTotal = _getCartTotal();
    emit(CartLoadedState(
        cartItems: cartItems,
        cartTotal: cartTotal,
        saveLaterItems: saveLaterItems));
  }

  void _onMoveToCart(MoveSaveLaterToCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final String accessToken = await localRepo.getAccessToken();
     
    final deletedItemIndex = saveLaterItems
        .indexWhere((element) => element.productId == event.productId);
    saveLaterItems.removeAt(deletedItemIndex);
    await localRepo.addCartItem(event.productId);
    await _cartRepository.handleAddCartItem(
        accessToken, event.productId, event.productCount);
    final List<CartItemModel> cartItems =
        await _cartRepository.handleGetCartItems(accessToken);
    this.cartItems = cartItems;
    cartTotal = _getCartTotal();
    emit(CartLoadedState(
        saveLaterItems: saveLaterItems,
        cartItems: cartItems,
        cartTotal: cartTotal));
  }

  void _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final accessToken = await localRepo.getAccessToken();

    final updatedItemIndex =
        cartItems.indexWhere((element) => element.productId == event.productId);

    await _cartRepository.handleUpdateCartItem(
        accessToken, event.productId, event.updatedProductCount);

    cartItems[updatedItemIndex].productCount = event.updatedProductCount;

    cartTotal = _getCartTotal();

    emit(CartLoadedState(
        cartItems: cartItems,
        cartTotal: cartTotal,
        saveLaterItems: saveLaterItems));
  }

  int _getCartTotal() {
    int total = 0;
    for (var item in cartItems) {
      int itemPrice = item.pricingDetails.sellingPrice * item.productCount;
      total += itemPrice;
    }

    return total;
  }
}