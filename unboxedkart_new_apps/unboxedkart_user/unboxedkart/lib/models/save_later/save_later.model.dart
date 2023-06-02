

import 'package:unboxedkart/models/cart_item/cart_item.model.dart';

class SavedLaterModel {
  String cartItemId;
  String productId;
  int productCount;
  ProductDetails productDetails;
  Pricing pricingDetails;

  SavedLaterModel(
      {this.cartItemId,
      this.productCount,
      this.pricingDetails,
      this.productDetails,
      this.productId});

  factory SavedLaterModel.fromDocument(doc) {
    return SavedLaterModel(
        cartItemId: doc['_id'],
        productId: doc['productId'],
        productCount: doc['productCount'],
        productDetails: ProductDetails.fromDocument(doc['productDetails']),
        pricingDetails: Pricing.fromDocument(doc['pricingDetails']));
  }
}
