import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';
import 'package:unboxedkart/models/coupon/coupon.model.dart';
import 'package:unboxedkart/presentation/models/order_summary_item/order_summary_item.dart';
import 'package:unboxedkart/presentation/pages/order_summary/apply_coupon.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/order_summary_status.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/pay_at_store.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key key}) : super(key: key);

   
   

   
   
   
   
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
   
}

class _OrderSummaryState extends State<OrderSummary> {
   
   

  final CustomAlertPopup _customPopup = CustomAlertPopup();
  List<String> deliveryOptions = [
    "Store Pickup",
    "Home Delivery",
  ];
  int selectedDeliveryType;
  bool couponApplied = false;
  CouponModel coupon;

  _handleShowSelectDeliveryTypePopup() {
    return _customPopup.show(
      title: "Select delivery type to continue",
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Order summary",
            enableBack: true,
          )),
      body: BlocProvider(
        create: (context) => OrdersummaryBloc()..add(LoadOrderSummaryItems()),
        child: BlocBuilder<OrdersummaryBloc, OrdersummaryState>(
          builder: (context, state) {
            if (state is OrderSummaryItemsLoading) {
              return const Center(
                child: LoadingSpinnerWidget(),
              );
            } else if (state is OrderSummaryItemsLoadedState) {
              return Scaffold(
                bottomSheet: _BuildBottomSheet(
                  cartTotal: state.cartTotal,
                  function: () {
                    if (selectedDeliveryType != null) {
                      selectedDeliveryType == 0
                          ? Navigator.pushNamed(context, "/select-pickup-store")
                          : Navigator.pushReplacementNamed(
                              context, '/select-address');
                    } else {
                      _handleShowSelectDeliveryTypePopup();
                    }
                  },
                ),
                body: ListView(
                  children: [
                     
                    const orderSummaryStatus(
                      orderStatus: 1,
                    ),
                    PayAtStoreWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: CustomSizedTextBox(
                        textContent: "SELECT DELIVERY TYPE *",
                        fontSize: 13,
                         
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDeliveryType = 0;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                    value: 0,
                                    groupValue: selectedDeliveryType,
                                    activeColor: CustomColors.blue,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedDeliveryType = val;
                                      });

                                       
                                    }),
                                CustomSizedTextBox(
                                  textContent: deliveryOptions[0],
                                  isBold:
                                      selectedDeliveryType == 0 ? true : false,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDeliveryType = 1;
                              });
                            },
                            child: Row(
                              children: [
                                Radio(
                                    activeColor: CustomColors.blue,
                                    value: 1,
                                    groupValue: selectedDeliveryType,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedDeliveryType = val;
                                      });
                                    }),
                                CustomSizedTextBox(
                                  textContent: deliveryOptions[1],
                                  isBold:
                                      selectedDeliveryType == 1 ? true : false,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: CustomSizedTextBox(
                        textContent: "ORDER ITEMS",
                        fontSize: 13,
                         
                      ),
                    ),
                    ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          return OrderSummaryItem(
                            orderSummaryItem: state.cartItems[index],
                          );
                        }),
                    _ApplyCoupon(
                        applyCouponFunction: (val1, val2) {
                          BlocProvider.of<OrdersummaryBloc>(context).add(
                            AddCouponCodeToOrderSummary(
                                couponCode: val1, discountAmount: val2),
                          );
                        },
                        couponDiscount: state.couponDiscount),
                    const SizedBox(height: 40)
                  ],
                ),
              );
            } else {
              return const Text("wrong");
            }
          },
        ),
      ),
    );
  }
}

class _ApplyCoupon extends StatefulWidget {
  final Function applyCouponFunction;
  final int couponDiscount;

  const _ApplyCoupon({Key key, this.applyCouponFunction, this.couponDiscount})
      : super(key: key);

  @override
  State<_ApplyCoupon> createState() => __ApplyCouponState();
}

class __ApplyCouponState extends State<_ApplyCoupon> {
  bool couponApplied = false;
  CouponModel coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApplyCouponPage()),
          );

          if (result != null && result.discountAmount > 0) {
            coupon = result;

             
             
             
             
             
             
             
            widget.applyCouponFunction(
                coupon.couponCode, coupon.discountAmount);
          }
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                CupertinoIcons.paperplane,
                size: 18,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSizedTextBox(
                    textContent: widget.couponDiscount != null
                        ? "Coupon Applied"
                        : "Apply Coupon",
                    fontSize: 14,
                    isBold: true,
                  ),
                  widget.couponDiscount != null
                      ? CustomSizedTextBox(
                          textContent:
                              "You saved additional ₹${widget.couponDiscount}",
                          fontSize: 14,
                          isBold: true,
                          color: Colors.green,
                        )
                      : const SizedBox()
                ],
              ),
            ]),
      ),
    );
  }
}

class CustomNumberedCircle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const CustomNumberedCircle(
      {Key key,
      this.icon,
      this.iconColor,
      this.title,
      this.subTitle,
      this.backgroundColor,
      this.textColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
           
           
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            shape: BoxShape.circle,
          ),
          child: icon != null
              ? Icon(
                  icon,
                  color: iconColor,
                  size: 14,
                )
              : CustomSizedTextBox(
                  isCenter: true,
                  textContent: title,
                  fontSize: 12,
                  isBold: true,
                  color: textColor,
                ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomSizedTextBox(
          isCenter: true,
          textContent: subTitle,
          fontSize: 10,
          isBold: true,
        ),
      ],
    );
  }
}

class _BuildBottomSheet extends StatelessWidget {
  final int cartTotal;
  final Function function;
  const _BuildBottomSheet({this.cartTotal, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
       
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 15, top: 10, left: 30, right: 20),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Center(
                        child: CustomSizedTextBox(
                            textContent: '₹$cartTotal',
                            fontSize: 20,
                            isBold: true,
                            color: Colors.black))),
              ),
               
               
               
              GestureDetector(
                onTap: () => function(),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: CustomColors.blue,
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Center(
                    child: CustomSizedTextBox(
                        textContent: 'Continue',
                        fontSize: 16,
                        isBold: true,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
