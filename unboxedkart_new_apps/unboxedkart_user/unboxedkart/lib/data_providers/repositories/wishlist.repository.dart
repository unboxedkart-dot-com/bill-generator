import 'package:unboxedkart/data_providers/apis/wishlist/wishlist.api.dart';
import 'package:unboxedkart/models/product/product.dart';

class WishlistRepository {
  final WishlistApi wishlistApi = WishlistApi();

  Future<List<ProductModel>> handleGetWishlistItems(String accessToken) async {
    final products = await wishlistApi.getWishlistItems(accessToken);
    final List<ProductModel> wishlistItems = products
        .map<ProductModel>((product) => ProductModel.fromDoc(product))
        .toList();
    
    
    return wishlistItems;
  }

  Future handleRemoveWishlistItem(String accessToken, String productId) async {
    final response =
        await wishlistApi.removeWishlistItem(accessToken, productId);
    return response;
  }

  Future handleAddWishlistItem(String accessToken, String productId) async {
    final response = await wishlistApi.addWishlistItem(accessToken, productId);
    return response;
  }
}
