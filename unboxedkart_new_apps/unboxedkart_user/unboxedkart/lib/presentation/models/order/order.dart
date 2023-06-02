import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:unboxedkart/logic/orders/orders_bloc.dart';
import 'package:unboxedkart/models/order/order.model.dart';
import 'package:unboxedkart/models/order_tile/order_tile.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class Order extends StatefulWidget {
  final OrderModel order;

  const Order({Key key, this.order}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  void initState() {
    super.initState();
    _getConstants();
  }

  double fillPercentage = 0;
  String orderStatusText;
  String orderSubTitle;

  _getConstants() {
    if (widget.order.orderStatus == "ORDERED") {
      fillPercentage = 0.1;
      orderStatusText = "Waiting for confirmation";
      orderSubTitle = "We received your order";
    } else if (widget.order.orderStatus == "ACCEPTED") {
      fillPercentage = 0.3;
      orderStatusText =
          "Your order is confirmed and will be delivered to you in 2 days.";
      orderSubTitle = "it will get shipped in 1 or 2 business days.";
    } else if (widget.order.orderStatus == "ORDER NOT ACCEPTED") {
      fillPercentage = 1.0;
      orderStatusText = "Your order is not accepted";
      orderSubTitle = "We look forward to see you again.";
    } else if (widget.order.orderStatus == "READY FOR PICKUP") {
      fillPercentage = 0.7;
      orderStatusText = "Your Product is ready for pickup";
      orderSubTitle = "Its very near to you and will reach you by today.";
    } else if (widget.order.orderStatus == "SHIPPED") {
      fillPercentage = 0.5;
      orderStatusText = "Your Product is shipped";
      orderSubTitle = "Its already shipped, will reach you in 2 to 3 days";
    } else if (widget.order.orderStatus == "OUT FOR DELIVERY") {
      fillPercentage = 0.7;
      orderStatusText = "Your Product is out for delivery";
      orderSubTitle = "Its very near to you and will reach you by today.";
    } else if (widget.order.orderStatus == "DELIVERED") {
      fillPercentage = 1.0;
      orderStatusText = "Your Product is delivered";
      orderSubTitle = "It already reached you hands.";
    } else if (widget.order.orderStatus == "CANCELLED") {
      fillPercentage = 1.0;
      orderStatusText = "Your order is cancelled";
      orderSubTitle = "We look forward to see you again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () => _pushToOrderTile(),
          child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: widget.order.productDetails.imageUrl,
                    height: 60,
                    width: 60,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CustomSizedTextBox(
                        textContent: orderStatusText,
                        // textContent: "$orderStatusText",
                        fontSize: 14,
                        isBold: true),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: CustomSizedTextBox(
                        textContent: widget.order.productDetails.title,
                        // textContent: '$orderSubTitle',
                        fontSize: 14),
                  ),
                  trailing: IconButton(
                      icon: const Icon(
                        CupertinoIcons.chevron_right,
                        size: 18,
                      ),
                      onPressed: () => _pushToOrderTile()),
                ),
                _OrderStatusIndicator(
                    deliveryType: widget.order.deliveryType,
                    fillPercentage: fillPercentage,
                    orderStatus: widget.order.orderStatus),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pushToOrderTile() async {
    await Navigator.pushNamed(context, '/order',
        arguments: OrderTileNew(
          orderId: widget.order.orderId,
        ));
    // if (reloadPage != null && reloadPage == true) {
    BlocProvider.of<OrdersBloc>(context).add(LoadOrders());
    // }
  }
}

class _OrderStatusIndicator extends StatelessWidget {
  final String deliveryType;
  final double fillPercentage;
  final String orderStatus;

  const _OrderStatusIndicator(
      {Key key, this.fillPercentage, this.deliveryType, this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 0.95,
          lineHeight: 5.0,
          percent: fillPercentage,
          backgroundColor: Colors.white,
          animationDuration: 800,
          animation: true,
          fillColor: Colors.white60,
          progressColor: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSizedTextBox(
                textContent: 'ordered',
                fontSize: 14,
              ),
              CustomSizedTextBox(
                textContent: orderStatus == "CANCELLED" ||
                        orderStatus == "ORDER NOT ACCEPTED"
                    ? ""
                    : deliveryType == "STORE PICKUP"
                        ? 'Ready for pickup'
                        : 'shipped',
                fontSize: 14,
              ),
              CustomSizedTextBox(
                textContent:
                    orderStatus == "CANCELLED" ? "Cancelled" : 'Delivered',
                fontSize: 14,
              ),
            ],
          ),
        )
      ],
    );
  }
}
