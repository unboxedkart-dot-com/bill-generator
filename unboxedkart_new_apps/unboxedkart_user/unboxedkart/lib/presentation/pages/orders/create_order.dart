import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/orders/orders_bloc.dart';
import 'package:unboxedkart/models/order/multi_order.model.dart';
import 'package:unboxedkart/models/order_tile/order_tile.dart';
import 'package:unboxedkart/models/ordered_item/ordered_item.model.dart';
import 'package:unboxedkart/presentation/models/ordered_item/ordered_item.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class CreateOrderPage extends StatelessWidget {
  final String orderNumber;

  DateTime tomorrow = DateTime.now().add(const Duration(days: 10, hours: 10));

  CreateOrderPage({Key key, this.orderNumber}) : super(key: key);

  MultiOrderModel order;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(
            title: "Order Status",
            customBack: true,
            customBackFunction: () => Navigator.pushNamedAndRemoveUntil(
                context, '/', (route) => false),
          ),
          preferredSize: const Size.fromHeight(50),
        ),
        bottomSheet: CustomBottomButton(
            title: "Continue Shopping",
            function: () => Navigator.pushNamedAndRemoveUntil(
                context, '/', (route) => false)),
        body: BlocProvider(
          create: (context) => OrdersBloc()..add(LoadOrder(orderNumber)),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrderLoadedState) {
                order = state.order;
                String date =
                    '${months[DateTime.now().month - 1]} ${DateTime.now().day},${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}';
                return ListView(
                  children: [
                    ElevatedContainer(
                      elevation: 0,
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                CupertinoIcons.check_mark_circled,
                                size: 60,
                                color: Colors.blueAccent,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomSizedTextBox(
                            textContent: "Order Successful",
                            fontSize: 20,
                            isBold: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomSizedTextBox(
                            textContent:
                                "Thank you, your order is successful. A confirmation message will be sent to your mobile number and email shortly.",
                            fontSize: 14,
                            isBold: false,
                            isCenter: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child:
                                    CustomTitleText(title: "Order details :"),
                              ),
                              _SingleDetailWidget(
                                  title: 'order date', subTitle: date),
                              _SingleDetailWidget(
                                  title: 'order number',
                                  subTitle: order.orderNumber),
                              _SingleDetailWidget(
                                  title: 'Delivery type',
                                  subTitle: order.deliveryType.toLowerCase()),
                              _SingleDetailWidget(
                                  title: 'payment type',
                                  subTitle: order.paymentMethod.toLowerCase()),
                              order.paymentType != "PAY AT STORE DUE"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        order.couponCode != null
                                            ? _SingleDetailWidget(
                                                title: "Coupon code used",
                                                subTitle:
                                                    '${order.couponCode} (₹${order.couponDiscount} off)')
                                            : const SizedBox(),
                                        _SingleDetailWidget(
                                            title: "Amount Paid in advance",
                                            subTitle:
                                                order.amountPaid.toString()),
                                        _SingleDetailWidget(
                                            title: "Payment Due",
                                            subTitle:
                                                order.amountDue.toString()),
                                      ],
                                    )
                                  : const SizedBox(),
                              _SingleDetailWidget(
                                title: order.deliveryType == "STORE PICKUP"
                                    ? 'pick up Slot'
                                    : "Expected delivery date",
                                subTitle: order.deliveryType == "STORE PICKUP"
                                    ? '${order.pickUpDateInString} (${order.pickUpTimeInString})'
                                    : order.expectedDeliveryTimeInString,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ShowDeliveryDetails(
                        storeLocation: order.pickUpStoreDetails,
                        address: order.addressDetails,
                        deliveryType: order.deliveryType),
                    ShowOrderedProducts(orderItems: order.orderItems),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

class ShowOrderedProducts extends StatelessWidget {
  final List<OrderedItemModel> orderItems;

  const ShowOrderedProducts({Key key, this.orderItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            textContent: "ORDERED ITEMS",
            fontSize: 12,
            isBold: true,
          ),
          const Divider(),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                return OrderedItem(orderedItem: orderItems[index]);
              }),
        ],
      ),
    );
  }
}

class _SingleDetailWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const _SingleDetailWidget({Key key, this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            textContent: title,
            fontSize: 14,
            isBold: true,
          ),
          CustomSizedTextBox(
            textContent: subTitle,
            fontSize: 14,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
