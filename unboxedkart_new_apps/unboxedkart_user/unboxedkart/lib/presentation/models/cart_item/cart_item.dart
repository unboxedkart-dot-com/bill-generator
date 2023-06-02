import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/cart_page/cart_bloc.dart';
import 'package:unboxedkart/models/cart_item/cart_item.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CartItem extends StatefulWidget {
  CartItemModel cartItem;

  CartItem({Key key, this.cartItem}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  _handleUpdateQuantity(int quantity) {

    BlocProvider.of<CartBloc>(context).add(UpdateCartItem(
        productId: widget.cartItem.productId, updatedProductCount: quantity));
    setState(() {
      widget.cartItem.productCount = quantity;
    });
  }

  _handleRemoveCartItem() {
    BlocProvider.of<CartBloc>(context)
        .add(RemoveCartItem(productId: widget.cartItem.productId));
  }

  _handleAddToWishlist() {
    BlocProvider.of<CartBloc>(context).add(AddSavedToLater(
        productId: widget.cartItem.productId,
        productCount: widget.cartItem.productCount));
  }

  _handleShowUpdateCountPopup(int quantity) {
    return _customPopup.show(
      title: quantity > 1
          ? "Would you like to update the count of product"
          : "Would you like to remove item from cart",
      subTitle: quantity > 1
          ? "applied coupon will be removed. Please apply coupon again"
          : "",
      buttonOneText: "No",
      buttonTwoText: "Yes",
      context: context,
      buttonTwoFunction: () {
        quantity < 1
            ? _handleRemoveCartItem()
            : _handleUpdateQuantity(quantity);
        Navigator.pop(context);
      },
    );
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

  _handleShowSaveToLaterPopup() {
    return _customPopup.show(
      title: "Would you like to move this product to saved later",
      buttonOneText: "No",
      buttonTwoText: "Yes",
      context: context,
      buttonTwoFunction: () {
        _handleAddToWishlist();
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
                        textContent: widget.cartItem.productDetails.title,
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
                                '₹${(widget.cartItem.pricingDetails.sellingPrice) * widget.cartItem.productCount}',
                            fontSize: 16,
                            isBold: true),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomSizedTextBox(
                            textContent:
                                '(Qty : ${widget.cartItem.productCount})',
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
                      imageUrl: widget.cartItem.productDetails.imageUrl,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _handleShowUpdateCountPopup(
                                    widget.cartItem.productCount - 1);
                              },
                              child: const Center(
                                child: Icon(CupertinoIcons.minus,
                                    size: 16, color: Colors.black),
                              )),
                          Center(
                            child: CustomSizedTextBox(
                              textContent: "${widget.cartItem.productCount}",
                              isBold: true,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _handleShowUpdateCountPopup(
                                  widget.cartItem.productCount + 1);
                            },
                            child: const Center(
                              child: Icon(CupertinoIcons.add,
                                  size: 16, color: Colors.black),
                            ),
                          )
                        ]),
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
                      color: Colors.black,
                      size: 15,
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
                  _handleShowSaveToLaterPopup();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.black,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomSizedTextBox(
                        textContent: 'Save for later', fontSize: 16)
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

class _BuildCartItem extends StatelessWidget {
  // const _BuildCartItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
