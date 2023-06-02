
class ProductDetails {
  String title;
  String color;
  String brand;
  String category;
  String condition;
  String imageUrl;

  ProductDetails(
      {this.brand,
      this.category,
      this.color,
      this.condition,
      this.imageUrl,
      this.title});

  factory ProductDetails.fromDocument(doc) {
    return ProductDetails(
      title: doc['title'],
      color: doc['color'],
      brand: doc['brand'],
      category: doc['category'],
      condition: doc['condition'],
      imageUrl: doc['imageUrl'],
    );
  }
}

class Pricing {
  int sellingPrice;
  int price;

  Pricing({this.price, this.sellingPrice});

  factory Pricing.fromDocument(doc) {
    return Pricing(sellingPrice: doc['sellingPrice'], price: doc['price']);
  }
}

class CartItemModel {
  String cartItemId;
  String productId;
  int productCount;
  num rating;
  ProductDetails productDetails;
  Pricing pricingDetails;

  CartItemModel(
      {this.cartItemId,
      this.productCount,
      this.pricingDetails,
      this.productDetails,
      this.rating,
      this.productId});

  factory CartItemModel.fromDocument(doc) {
    return CartItemModel(
        cartItemId: doc['_id'],
        productId: doc['productId'],
        productCount: doc['productCount'],
        // rating: doc[],
        productDetails: ProductDetails.fromDocument(doc['productDetails']),
        pricingDetails: Pricing.fromDocument(doc['pricingDetails']));
  }
}
