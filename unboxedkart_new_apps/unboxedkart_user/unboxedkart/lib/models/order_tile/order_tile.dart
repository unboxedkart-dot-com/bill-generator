import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/constants/to_title_case.dart';
import 'package:unboxedkart/logic/order_tile/ordertile_bloc.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/order/order.model.dart';
import 'package:unboxedkart/models/reviews/review.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';
import 'package:unboxedkart/presentation/models/address/address.dart';
import 'package:unboxedkart/presentation/models/store_location/store_location.dart';
import 'package:unboxedkart/presentation/pages/orders/cancel-order.dart';
import 'package:unboxedkart/presentation/pages/orders/need-help.dart';
import 'package:unboxedkart/presentation/pages/reviews/create-review.dart';
import 'package:unboxedkart/presentation/pages/reviews/edit-review.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:unboxedkart/constants/to_title_case.dart';

class OrderTileNew extends StatefulWidget {
  final String orderId;

  const OrderTileNew({Key key, this.orderId}) : super(key: key);

  @override
  State<OrderTileNew> createState() => _OrderTileNewState();
}

class _OrderTileNewState extends State<OrderTileNew> {
  double fillPercentage = 0;
  String orderStatusTitle;
  String orderStatusContent;
  int selectedRating = 0;
  Dio dio = Dio();

  final CustomAlertPopup _customPopup = CustomAlertPopup();

  void _handleDownloadInvoice() {
    _customPopup.show(
      context: context,
      title:
          "For Security reasons, Your invoice will be sent to your registered mail address.",
      buttonOneText: "Okay, I understand",
    );
  }

  void _handleShowIcloudPassword() {
    _customPopup.show(
      context: context,
      title: "icloud password for goUnboxed@unboxedkart.com is GoUnboxed@1990",
      buttonOneText: "Okay",
    );
  }

  Future<String> downloadFile() async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    var dir = (await getApplicationDocumentsDirectory()).path;
    try {
      myUrl =
          "https://unboxedkart-india.s3.ap-south-1.amazonaws.com/invoices/sales/Documents.OD61911230638100.pdf";

      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);

        filePath = dir;

        file = File('$filePath/789');
        await file.writeAsBytes(bytes);
      } else {
        filePath = 'Error code: ' + response.statusCode.toString();
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  _getConstants(String orderStatus) {
    if (orderStatus == "ORDERED") {
      fillPercentage = 0.1;
      orderStatusTitle = "Waiting for confirmation";
      orderStatusContent = "We received your order";
    } else if (orderStatus == "ACCEPTED") {
      fillPercentage = 0.3;
      orderStatusTitle = "Your Product is ready to be shipped";
      orderStatusContent = "it will get shipped in 1 or 2 business days.";
    } else if (orderStatus == "ORDER NOT ACCEPTED") {
      fillPercentage = 1.0;
      orderStatusTitle = "Your order is not accepted";
      // orderSubTitle = "We look forward to see you again.";
    } else if (orderStatus == "SHIPPED") {
      fillPercentage = 0.5;
      orderStatusTitle = "Your Product is shipped";
      orderStatusContent = "Its already shipped, will reach you in 2 to 3 days";
    } else if (orderStatus == "OUT FOR DELIVERY") {
      fillPercentage = 0.7;
      orderStatusTitle = "Your Product is out for delivery";
      orderStatusContent = "Its very near to you and will reach you by today.";
    } else if (orderStatus == "DELIVERED") {
      fillPercentage = 1.0;
      orderStatusTitle = "Your Product is delivered";
      orderStatusContent = "It already reached you hands.";
    } else if (orderStatus == "CANCELLED") {
      fillPercentage = 1.0;
      orderStatusTitle = "Your order is cancelled";
      orderStatusContent = "We look forward to see you again.";
    }
  }

  _handleSetRating(int rating, String productId, ReviewModel review) {
    setState(() {
      selectedRating = rating;
    });
    review == null
        ? Navigator.pushNamed(context, '/review-product',
            arguments: CreateReviewPage(
              selectedRating: selectedRating,
              productId: productId,
            ))
        : Navigator.pushNamed(context, '/update-review',
            arguments: EditReviewPage(
              selectedRating: selectedRating,
              reviewContent: review.reviewContent,
              reviewTitle: review.reviewTitle,
              reviewId: review.reviewId,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(title: "order status", enableBack: true),
      ),
      body: BlocProvider(
        create: (context) =>
            OrdertileBloc()..add(LoadOrderTile(widget.orderId)),
        child: BlocBuilder<OrdertileBloc, OrdertileState>(
          builder: (context, state) {
            if (state is OrdertileLoaded) {
              _getConstants(state.order.orderStatus);
              if (state.review != null) {
                selectedRating = state.review.rating ?? 0;
              }

              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Material(
                      color: Colors.white,
                      elevation: 0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSizedTextBox(
                                textContent:
                                    "ORDER NUMBER - ${state.order.orderNumber}",
                                fontSize: 12,
                              ),
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Image(
                                        height: 60,
                                        width: 60,
                                        image: NetworkImage(state
                                            .order.productDetails.imageUrl)),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomSizedTextBox(
                                              textContent: state
                                                  .order.productDetails.title,
                                              fontSize: 14,
                                              isBold: true),
                                          const SizedBox(height: 5),
                                          CustomSizedTextBox(
                                              textContent: state
                                                  .order.productDetails.color,
                                              fontSize: 14),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              CustomSizedTextBox(
                                                  textContent:
                                                      '₹${state.order.pricingDetails.billTotal}',
                                                  fontSize: 16,
                                                  isBold: true),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              CustomSizedTextBox(
                                                  textContent:
                                                      '(Quantity : ${state.order.orderDetails.productCount})',
                                                  fontSize: 13,
                                                  isBold: true),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          // CustomSizedTextBox(
                                          //     textContent:
                                          //         'Sold by Sharadha communications',
                                          //     fontSize: 14),
                                        ]),
                                  )
                                ],
                              ),
                              OrderStatusWidget(
                                deliveryType: state.order.deliveryType,
                                fillPercentage: fillPercentage,
                                orderStatus: state.order.orderStatus,
                              ),
                              state.order.orderStatus == "DELIVERED"
                                  ? Column(
                                      children: [
                                        const Divider(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClickableRatingWidget(
                                              rating: 1,
                                              selectedRating: selectedRating,
                                              function: () {
                                                _handleSetRating(
                                                    1,
                                                    state.order.orderDetails
                                                        .productId,
                                                    state.review);
                                              },
                                            ),
                                            ClickableRatingWidget(
                                              rating: 2,
                                              selectedRating: selectedRating,
                                              function: () {
                                                _handleSetRating(
                                                    2,
                                                    state.order.orderDetails
                                                        .productId,
                                                    state.review);
                                              },
                                            ),
                                            ClickableRatingWidget(
                                              rating: 3,
                                              selectedRating: selectedRating,
                                              function: () {
                                                _handleSetRating(
                                                    3,
                                                    state.order.orderDetails
                                                        .productId,
                                                    state.review);
                                              },
                                            ),
                                            ClickableRatingWidget(
                                              rating: 4,
                                              selectedRating: selectedRating,
                                              function: () {
                                                _handleSetRating(
                                                    4,
                                                    state.order.orderDetails
                                                        .productId,
                                                    state.review);
                                              },
                                            ),
                                            ClickableRatingWidget(
                                              rating: 5,
                                              selectedRating: selectedRating,
                                              function: () {
                                                _handleSetRating(
                                                    5,
                                                    state.order.orderDetails
                                                        .productId,
                                                    state.review);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              state.order.orderStatus != "CANCELLED"
                                  ? const Divider()
                                  : const SizedBox(),
                              CancelAndNeedHelpWidget(
                                orderStatus: state.order.orderStatus,
                                orderId: state.order.orderId,
                                orderNumber: state.order.orderNumber,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  state.order.orderStatus == "DELIVERED"
                      ? _DownloadInvoiceWidget(
                          function: () => _handleDownloadInvoice(),
                        )
                      : const SizedBox(),
                  state.order.deliveryType != "STORE PICKUP"
                      ? _ShowIcloudPasswordWidget(
                          function: () => _handleShowIcloudPassword(),
                        )
                      : const SizedBox(),
                  ShowOrderDetails(
                    orderDate: state.order.orderDate,
                    deliveryType: state.order.deliveryType,
                    orderStatus: state.order.orderStatus,
                    pickUpTimeInString:
                        state.order.deliveryType == "STORE PICKUP"
                            ? state.order.pickUpDetails.pickUpTimeInString
                            : null,
                    pickUpDateInString:
                        state.order.deliveryType == "STORE PICKUP"
                            ? state.order.pickUpDetails.pickUpDateInString
                            : null,
                    expectedDeliveryDateInString:
                        state.order.deliveryType != "STORE PICKUP"
                            ? state.order.shippingDetails.deliveryDate
                            : null,
                    paymentMethod: state.order.paymentDetails.paymentMethod,
                    paymentType: state.order.paymentDetails.paymentType,
                    amountDue: state.order.paymentDetails.amountDue,
                    amountPaid: state.order.paymentDetails.amountPaid,
                  ),
                  ShowDeliveryDetails(
                    deliveryType: state.order.deliveryType,
                    address: state.order.deliveryType == "STORE PICKUP"
                        ? null
                        : state.order.shippingDetails.address,
                    storeLocation: state.order.deliveryType == "HOME DELIVERY"
                        ? null
                        : state.order.pickUpDetails.storeLocation,
                    deliveryDate: state.order.deliveryType == "STORE PICKUP"
                        ? '${state.order.pickUpDetails.pickUpDateInString} (${state.order.pickUpDetails.pickUpTimeInString} )'
                        : state.order.shippingDetails.deliveryDateInString,
                    orderStatus: state.order.orderStatus,
                  ),
                  ShowPricingDetails(
                    pricingDetails: state.order.pricingDetails,
                    sellingPrice: state.order.orderDetails.pricePerItem,
                  )
                ],
              );
            } else {
              return const LoadingSpinnerWidget();
            }
          },
        ),
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  final double fillPercentage;
  final String deliveryType;
  final String orderStatus;

  const OrderStatusWidget(
      {Key key, this.fillPercentage, this.deliveryType, this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 5),
      child: Column(
        children: [
          LinearPercentIndicator(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            lineHeight: 5.0,
            percent: fillPercentage,
            animation: true,
            animationDuration: 800,
            backgroundColor: Colors.white60,
            fillColor: Colors.white,
            progressColor: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSizedTextBox(
                  textContent: 'Ordered',
                  fontSize: 12,
                ),
                CustomSizedTextBox(
                  textContent: orderStatus == "CANCELLED"
                      ? ""
                      : deliveryType == "STORE PICKUP"
                          ? 'Ready for pickup'
                          : 'shipped',
                  fontSize: 12,
                ),
                CustomSizedTextBox(
                  textContent:
                      orderStatus == "CANCELLED" ? "Cancelled" : 'Delivered',
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CancelAndNeedHelpWidget extends StatelessWidget {
  final String orderId;
  final String orderNumber;
  final String orderStatus;
  final Function cancelFunction;
  final Function needHelpFunction;

  const CancelAndNeedHelpWidget(
      {Key key,
      this.cancelFunction,
      this.needHelpFunction,
      this.orderStatus,
      this.orderId,
      this.orderNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDelivered = orderStatus == "DELIVERED" ? true : false;
    bool isCancelled = orderStatus == "CANCELLED" ? true : false;
    print("order status - $orderStatus");
    return !isCancelled
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: isDelivered
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: isDelivered
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  !isDelivered
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/cancel-order',
                                arguments: CancelOrderPage(
                                  orderId: orderId,
                                  orderNumber: orderNumber,
                                ));
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 25,
                              child: CustomSizedTextBox(
                                isCenter: true,
                                isBold: true,
                                textContent: "Cancel",
                                // isBold: true,
                              )),
                        )
                      : const SizedBox(),
                  const VerticalDivider(
                    color: Colors.grey,
                    // width: 1,
                    thickness: 0.5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/need-help',
                          arguments: NeedHelpPage(
                            orderId: orderId,
                            orderNumber: orderNumber,
                          ));
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 25,
                        child: CustomSizedTextBox(
                          isCenter: true,
                          isBold: true,
                          textContent: "Need help ?",
                          // isBold: true,
                        )),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

class ShowOrderDetails extends StatelessWidget {
  final DateTime orderDate;
  final String deliveryType;
  final String paymentType;
  final int amountPaid;
  final int amountDue;
  final String paymentMethod;
  final DateTime expectedDeliveryDateInString;
  final String pickUpTimeInString;
  final String pickUpDateInString;
  final String orderStatus;

  const ShowOrderDetails(
      {Key key,
      this.orderDate,
      this.deliveryType,
      this.paymentMethod,
      this.paymentType,
      this.orderStatus,
      this.amountDue,
      this.amountPaid,
      this.expectedDeliveryDateInString,
      this.pickUpTimeInString,
      this.pickUpDateInString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            textContent: "ORDER DETAILS : ",
            isBold: true,
            fontSize: 12,
          ),
          const Divider(),
          CustomRowText(
            valueOne: "Order Date",
            valueTwo: orderDate.toReadableDate(),
          ),
          CustomRowText(
            valueOne: "Delivery Type",
            valueTwo: "Store Pickup".toTitleCase(),
          ),
          CustomRowText(
            valueOne: "payment Type",
            valueTwo: paymentType == "null"
                ? paymentType.toTitleCase()
                : "Pay on delivery",
          ),
          CustomRowText(
            valueOne: "Amount paid",
            valueTwo: amountPaid.toString(),
          ),
          CustomRowText(
            valueOne: "Amount Due",
            valueTwo: amountDue.toString(),
          ),
          CustomRowText(
            valueOne: "payment Method",
            valueTwo: paymentMethod.toTitleCase(),
          ),
          CustomRowText(
            valueOne: "Order Status",
            valueTwo: orderStatus.toTitleCase(),
          ),
          CustomRowText(
              valueOne: deliveryType == "STORE PICKUP"
                  ? "Pickup date"
                  : "Delivery date",
              // valueTwo: "19 May 2022 (05:54 PM)",
              valueTwo: '$pickUpDateInString ($pickUpTimeInString)'),
        ],
      ),
    );
  }
}

class ShowDeliveryDetails extends StatelessWidget {
  final String deliveryType;
  final StoreLocationModel storeLocation;
  final AddressModel address;
  final String deliveryDate;
  final String orderStatus;

  const ShowDeliveryDetails(
      {Key key,
      this.deliveryType,
      this.storeLocation,
      this.address,
      this.orderStatus,
      this.deliveryDate})
      : super(key: key);

  void _launchLocationUrl() async {
    String _url = "https://goo.gl/maps/u3Rvg8mnkGWy6iGV9";
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    if (deliveryType == "STORE PICKUP") {
      return ElevatedContainer(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedTextBox(
              textContent: "PICKUP STORE : ",
              isBold: true,
              fontSize: 12,
            ),
            const Divider(),
            CustomStoreLocation(storeLocation: storeLocation),
            GestureDetector(
              onTap: () {
                _launchLocationUrl();
              },
              child: CustomSizedTextBox(
                textContent: "(Click here to get directions)",
                color: CustomColors.blue,
                isBold: true,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    } else {
      return ElevatedContainer(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedTextBox(
              paddingWidth: 8,
              addPadding: true,
              textContent: "DELIVERY ADDRESS",
              isBold: true,
              fontSize: 12,
            ),
            CustomAddress(address: address),
            CustomSizedTextBox(
              textContent: orderStatus == "DELIVERED"
                  ? "Your order is delivered"
                  : "Your order will be delivered by $deliveryDate",
              isBold: true,
              fontSize: 12,
            ),
          ],
        ),
      );
    }
  }
}

class CustomRowText extends StatelessWidget {
  final String valueOne;
  final bool valueOneIsBold;
  final bool valueTwoIsBold;
  final String valueTwo;

  const CustomRowText(
      {Key key,
      this.valueOne,
      this.valueOneIsBold,
      this.valueTwoIsBold,
      this.valueTwo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomSizedTextBox(
            textContent: valueOne,
            isBold: valueOneIsBold ?? false,
            fontSize: 14,
          ),
          CustomSizedTextBox(
            textContent: valueTwo,
            isBold: valueTwoIsBold ?? false,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class ShowPricingDetails extends StatelessWidget {
  final PricingDetails pricingDetails;
  final int sellingPrice;

  const ShowPricingDetails({Key key, this.pricingDetails, this.sellingPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            textContent: "PRICING DETAILS",
            isBold: true,
            fontSize: 12,
          ),
          const Divider(),
          CustomRowText(
            valueOne: "Selling price",
            valueTwo: sellingPrice.toString(),
          ),
          CustomRowText(
            valueOne:
                "Order total (Qty - ${pricingDetails.billTotal ~/ sellingPrice})",
            valueTwo: pricingDetails.billTotal.toString(),
          ),
          CustomRowText(
            valueOne: "Coupon discount",
            valueTwo: pricingDetails.couponDiscount.toString(),
          ),
          CustomRowText(
            valueOne: "Total amount",
            valueOneIsBold: true,
            valueTwo: pricingDetails.payableTotal.toString(),
            valueTwoIsBold: true,
          ),
        ],
      ),
    );
  }
}

class _DownloadInvoiceWidget extends StatelessWidget {
  final Function function;

  const _DownloadInvoiceWidget({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: ElevatedContainer(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          child: Row(children: [
            const Icon(
              Icons.receipt,
              color: CustomColors.blue,
            ),
            CustomSizedTextBox(
              addPadding: true,
              textContent: "Download invoice",
              isBold: true,
              color: CustomColors.blue,
            )
          ]),
        ),
      ),
    );
  }
}

class _ShowIcloudPasswordWidget extends StatelessWidget {
  final Function function;

  const _ShowIcloudPasswordWidget({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: ElevatedContainer(
        elevation: 0,
        // noBorderRadius: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          child: Row(children: [
            const Icon(
              Icons.key,
              color: CustomColors.blue,
            ),
            CustomSizedTextBox(
              addPadding: true,
              textContent: "Show Password",
              color: CustomColors.blue,
              isBold: true,
            )
          ]),
        ),
      ),
    );
  }
}
