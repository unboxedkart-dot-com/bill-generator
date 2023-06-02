import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class ProductVertical extends StatefulWidget {
  final ProductModel product;

  const ProductVertical({Key key, this.product}) : super(key: key);

  @override
  _ProductVerticalState createState() => _ProductVerticalState();
}

class _ProductVerticalState extends State<ProductVertical> {
  bool isFavorite = false;
  bool isAddedToCart = false;
  bool isCertified = true;
  UsageTrackingApi _usageTrackingApi = UsageTrackingApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _usageTrackingApi.handleAddViewedProduct(widget.product.id);
        Navigator.pushNamed(context, '/product',
            arguments: ProductTile(
              productId: widget.product.id,
            ));
      },
      child: ElevatedContainer(
        elevation: 0,
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                    imageUrl:
                        // "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/product/mobile-phone/apple/iphone-x/spacegrey/apple-iphone-x-space-grey-unboxedkart-01.webp",
                        widget.product.imageUrls.coverImage,
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSizedTextBox(
                textContent: widget.product.title, fontSize: 12, isBold: true),
            widget.product.rating != null && widget.product.rating > 0
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 3),
                        child: widget.product.rating != null &&
                                widget.product.rating > 0
                            ? RatingWidget(rating: widget.product.rating)
                            : const SizedBox(),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                        child: Image(
                          width: 60,
                          height: 20,
                          image: AssetImage(
                            "assets/images/product/unboxedkart_certified.png",
                            // 'assets/images/featured_images/unboxedkart_certified.png'
                          ),
                        ),
                      )
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    child: Image(
                      // width: 60,
                      height: 20,
                      image: AssetImage(
                        "assets/images/product/unboxedkart_certified.png",
                        // 'assets/images/featured_images/unboxedkart_certified.png'
                      ),
                    ),
                  ),
            Row(
              children: [
                CustomSizedTextBox(
                    textContent: '₹${widget.product.pricing.sellingPrice}',
                    fontSize: 12,
                    isBold: true),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '₹${widget.product.pricing.price}',
                  style: const TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '₹${(widget.product.pricing.price - widget.product.pricing.sellingPrice)} Off',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
