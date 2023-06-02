import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/models/cart_item/cart_item.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class OrderSummaryItem extends StatefulWidget {
  final CartItemModel orderSummaryItem;

  const OrderSummaryItem({Key key, this.orderSummaryItem}) : super(key: key);

  @override
  State<OrderSummaryItem> createState() => _OrderSummaryItemState();
}

class _OrderSummaryItemState extends State<OrderSummaryItem> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  _handleUpdateQuantity(int quantity) {

    BlocProvider.of<OrdersummaryBloc>(context).add(UpdateOrderSummaryItem(
        productId: widget.orderSummaryItem.productId,
        updatedProductCount: quantity));
    setState(() {
      widget.orderSummaryItem.productCount = quantity;
    });
  }

  _handleShowUpdateCountPopup(int quantity) {
    return _customPopup.show(
      title: "Would you like to update the count of product",
      buttonOneText: "No",
      buttonTwoText: "Yes",
      context: context,
      buttonTwoFunction: () {
        _handleUpdateQuantity(quantity);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      // padding: const EdgeInsets.only(bottom: 15),
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
                            widget.orderSummaryItem.productDetails.title,
                        fontSize: 16,
                        isBold: true),
                    const RatingWidget(rating: 4.5),
                    Row(
                      children: [
                        CustomSizedTextBox(
                            textContent:
                                '₹${(widget.orderSummaryItem.pricingDetails.sellingPrice) * widget.orderSummaryItem.productCount}',
                            fontSize: 16,
                            isBold: true),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomSizedTextBox(
                            textContent:
                                '(Qty : ${widget.orderSummaryItem.productCount})',
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
                  Image(
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                    image: NetworkImage(
                        widget.orderSummaryItem.productDetails.imageUrl),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustomColors.blue),
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
                                  widget.orderSummaryItem.productCount - 1);
                            },
                            child: const Center(
                              child: Icon(CupertinoIcons.minus,
                                  size: 12, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: CustomSizedTextBox(
                              textContent:
                                  "${widget.orderSummaryItem.productCount}",
                              isBold: true,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _handleShowUpdateCountPopup(
                                  widget.orderSummaryItem.productCount + 1);
                            },
                            child: const Center(
                              child: Icon(CupertinoIcons.add,
                                  size: 12, color: Colors.black),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
