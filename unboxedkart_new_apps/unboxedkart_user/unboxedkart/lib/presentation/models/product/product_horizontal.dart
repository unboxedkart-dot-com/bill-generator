import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/user/user_bloc.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class ProductHorizontal extends StatefulWidget {
  final ProductModel product;

  const ProductHorizontal({Key key, this.product}) : super(key: key);

  // const ProductHorizontal(this.product);
  @override
  _ProductHorizontalState createState() => _ProductHorizontalState();
}

class _ProductHorizontalState extends State<ProductHorizontal> {
  // final ProductModel product;
  // final int discountPrice;

  final LocalRepository _localRepo = LocalRepository();
  UsageTrackingApi _usageTrackingApi = UsageTrackingApi();

  bool isFavorite = false;
  bool isAuthenticated = false;

  getAuthenticationStatus() async {
    isAuthenticated = await _localRepo.getAuthStatus();
  }

  checkItemInWishlist() async {
    if (await _localRepo.checkForItemInWishlist(widget.product.id)) {
      setState(() {
        isFavorite = true;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  @override
  initState() {
    checkItemInWishlist();
    getAuthenticationStatus();
  }

  _handleAddFavorite() async {
    if (isAuthenticated) {
      setState(() {
        isFavorite = true;
      });
      BlocProvider.of<UserBloc>(context)
          .add(AddFavoriteItem(widget.product.id));
    } else {
      await Navigator.pushNamed(context, '/login');
      getAuthenticationStatus();
    }
  }

  _handleDeleteFavorite() {
    print("deleting favorite");

    BlocProvider.of<UserBloc>(context)
        .add(RemoveFavoriteItem(widget.product.id));
    setState(() {
      isFavorite = false;
    });
  }

  _handlePushToProductPage() {
    _usageTrackingApi.handleAddViewedProduct(widget.product.id);
    Navigator.pushNamed(context, '/product',
        arguments: ProductTile(
          productId: widget.product.id,
        ));
  }

  // _ProductHorizontalState({this.product, this.discountPrice});
  @override
  Widget build(BuildContext context) {
    final int discountPrice =
        widget.product.pricing.price - widget.product.pricing.sellingPrice;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          // elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () => _handlePushToProductPage(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
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
                        child: CachedNetworkImage(
                          height: 120,
                          width: 120,
                          imageUrl: widget.product.imageUrls.coverImage,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Container(
                        width: 45,
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              isFavorite
                                  ? _handleDeleteFavorite()
                                  : _handleAddFavorite();
                            },
                            icon: Icon(
                              isFavorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: CustomColors.blue,
                            )),
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
                          // textContent: "iphone",
                          textContent: widget.product.title,
                          fontSize: 14,
                          isBold: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // ?
                        widget.product.rating != null &&
                                widget.product.rating > 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.product.rating > 0
                                      ? RatingWidget(
                                          rating: widget.product.rating
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                  textContent:
                                      "₹${widget.product.pricing.price}",
                                  isBold: true,
                                  isLineThrough: true,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                CustomSizedTextBox(
                                  textContent: "₹$discountPrice off",
                                  color: Colors.green,
                                  isBold: true,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                            widget.product.rating == 0
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 3),
                                    child: Image(
                                      width: 60,
                                      height: 20,
                                      image: AssetImage(
                                        "assets/images/product/unboxedkart_certified.png",
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        widget.product.quantity == 0
                            ? CustomSizedTextBox(
                                textContent: "Currently, out of stock",
                                fontSize: 12,
                                isBold: true,
                                color: Colors.red,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
