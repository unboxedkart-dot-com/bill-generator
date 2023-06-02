import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/cart_page/cart_bloc.dart';
import 'package:unboxedkart/models/save_later/save_later.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class SaveLaterProduct extends StatefulWidget {
  final SavedLaterModel saveLaterProduct;

  const SaveLaterProduct({Key key, this.saveLaterProduct}) : super(key: key);

  @override
  State<SaveLaterProduct> createState() => _SaveLaterProductState();
}

class _SaveLaterProductState extends State<SaveLaterProduct> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  _handleRemoveCartItem() {
    BlocProvider.of<CartBloc>(context)
        .add(RemoveSavedLater(productId: widget.saveLaterProduct.productId));
  }

  _handleAddToCart() {
    BlocProvider.of<CartBloc>(context).add(MoveSaveLaterToCart(
        productCount: widget.saveLaterProduct.productCount,
        productId: widget.saveLaterProduct.productId));
  }

  _handleShowDeleteItemPopup() {
    return _customPopup.show(
      title: "Would you like to remove product from cart",
      buttonOneText: "No",
      buttonTwoText: "Yes",
      context: context,
      buttonTwoFunction: () {
        _handleRemoveCartItem();
        Navigator.pop(context);
      },
    );
  }

  _handleShowAddToCartPopup() {
    return _customPopup.show(
      title: "Would you like to move this product to Cart",
      buttonOneText: "No",
      buttonTwoText: "Yes",
      context: context,
      buttonTwoFunction: () {
        _handleAddToCart();
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomSizedTextBox(
                        textContent:
                            widget.saveLaterProduct.productDetails.title,
                        fontSize: 14,
                        isBold: true),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: RatingWidget(rating: 4.5),
                    ),
                    Row(
                      children: [
                        CustomSizedTextBox(
                            textContent:
                                '₹${(widget.saveLaterProduct.pricingDetails.sellingPrice) * widget.saveLaterProduct.productCount}',
                            fontSize: 16,
                            isBold: true),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomSizedTextBox(
                            textContent:
                                '(Qty : ${widget.saveLaterProduct.productCount})',
                            fontSize: 13,
                            isBold: true),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: CachedNetworkImage(
                      imageUrl: widget.saveLaterProduct.productDetails.imageUrl,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSizedTextBox(
                    textContent:
                        '(Qty : ${widget.saveLaterProduct.productCount})',
                    fontSize: 15,
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  _handleShowDeleteItemPopup();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline,
                      size: 15,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomSizedTextBox(textContent: 'Remove', fontSize: 16),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _handleShowAddToCartPopup();
                },
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.bag,
                      color: Colors.black,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomSizedTextBox(
                        textContent: 'Move to Cart', fontSize: 16)
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
