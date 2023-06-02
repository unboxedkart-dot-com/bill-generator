import 'package:unboxedkart/data_providers/apis/cart_page/cart_api.dart';
import 'package:unboxedkart/models/save_later/save_later.model.dart';

import '../../models/cart_item/cart_item.model.dart';

class CartRepository {
  final CartApi cartApi = CartApi();

  Future handleGetCartItems(String accessToken) async {
    final response = await cartApi.getCartItems(accessToken);

    final List<CartItemModel> cartItems = response
        .map<CartItemModel>((cartItem) => CartItemModel.fromDocument(cartItem))
        .toList();
    return cartItems;
  }

  Future handleGetSaveLaterItems(String accessToken) async {
    final response = await cartApi.getSavedLaterItems(accessToken);
    final List<SavedLaterModel> cartItems = response
        .map<SavedLaterModel>(
            (cartItem) => SavedLaterModel.fromDocument(cartItem))
        .toList();
    return cartItems;
  }

  Future handleDeleteCartItem(String accessToken, String cartItemId) async {
    final response = await cartApi.deleteCartItem(accessToken, cartItemId);

    return response;
  }

  Future handleAddCartItem(
      String accessToken, String cartItemId, int productCount) async {
    final response =
        await cartApi.addCartItem(accessToken, cartItemId, productCount);

    return response;
  }

  Future handleAddSaveLater(
      String accessToken, String productId, int productCount) async {
    final response = await cartApi.addProductToSaveLater(
        accessToken, productId, productCount);

    return response;
  }

  Future handleRemoveSaveLater(String accessToken, String productId) async {
    final response =
        await cartApi.removeProductFromSaveLater(accessToken, productId);

    return response;
  }

  Future handleUpdateCartItem(
      String accessToken, String cartItemId, int productCount) async {
    final response =
        await cartApi.updateCartItem(accessToken, cartItemId, productCount);
    return response;
  }
}
