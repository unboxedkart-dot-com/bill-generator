import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/wishlist/wishlist_bloc.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class WishlistItem extends StatefulWidget {
  final ProductModel product;

  const WishlistItem({Key key, this.product}) : super(key: key);
  @override
  _WishlistItemState createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  bool isFavorite = true;

  _handleDeleteFavorite() {
    setState(() {
      setState(() {
        isFavorite = false;
      });
    });
    BlocProvider.of<WishlistBloc>(context)
        .add(RemoveWishlistItem(widget.product.id));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
        elevation: 0,
        // borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/product',
                arguments: ProductTile(
                  productId: widget.product.id,
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            // height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 45,
                    ),
                    Center(
                      child: Image(
                        image:
                            NetworkImage(widget.product.imageUrls.coverImage),
                        fit: BoxFit.contain,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Container(
                      width: 45,
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            isFavorite ? _handleDeleteFavorite() : () {};
                          },
                          icon: Icon(
                              isFavorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: CustomColors.blue)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizedTextBox(
                        textContent: widget.product.title,
                        fontSize: 14,
                        isBold: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.product.rating != null && widget.product.rating > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.product.rating > 0
                                    ? RatingWidget(rating: widget.product.rating
                                        // widget
                                        //     .product.reviewsData[0].averageRating
                                        )
                                    : const Image(
                                        alignment: Alignment.centerLeft,
                                        width: 60,
                                        height: 20,
                                        image: AssetImage(
                                          "assets/images/product/unboxedkart_certified.png",
                                          // 'assets/images/featured_images/unboxedkart_certified.png'
                                        ),
                                      ),
                                widget.product.rating > 0
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 3),
                                        child: Image(
                                          width: 60,
                                          height: 20,
                                          image: AssetImage(
                                            "assets/images/product/unboxedkart_certified.png",
                                            // 'assets/images/featured_images/unboxedkart_certified.png'
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        children: [
                          CustomSizedTextBox(
                              textContent:
                                  "₹${widget.product.pricing.sellingPrice}",
                              fontSize: 15,
                              isBold: true),
                          const SizedBox(
                            width: 7,
                          ),
                          CustomSizedTextBox(
                            fontSize: 15,
                            textContent: "₹${widget.product.pricing.price}",
                            isBold: true,
                            isLineThrough: true,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          CustomSizedTextBox(
                            textContent:
                                "₹${widget.product.pricing.price - widget.product.pricing.sellingPrice}",
                            color: Colors.green,
                            isBold: true,
                            fontSize: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
