import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/orders/orders_bloc.dart';
import 'package:unboxedkart/presentation/pages/orders/create_order.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/order_summary_status.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/pay_at_store.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class PaymentPage extends StatefulWidget {
  final int deliveryType;

  const PaymentPage({Key key, this.deliveryType}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int currentPaymentIndex = 0;
  bool isPaymentMethodSelected = true;

  final CustomAlertPopup _customPopup = CustomAlertPopup();

  List<String> paymentCodes = [
    'pas',
    'pas-d',
    'prepaid',
    'prepaid',
    'cod',
  ];

  List<String> paymentTitles = [
    "Pay at store",
    "Pay at Store (Pay ₹2000 as advance payment)",
    "UPI",
    "Credit / Debit / ATM Card",
    "Cash on delivery",
  ];
  List<String> paymentSubTitles = [
    'Your product will be booked without making any payment for next 24 to 48 hours from time of booking, you can collect your product at any time by visting our store nearby you.',
    "A small Advance payment payment is required for products with low availability or high demand. We require advance payment to ensure that our customers get required products.",
    'Make payment using UPI',
    'Make payment using debit/credit card/UPI/Wallets',
    'We request you to choose Store Pickup instead of cash/card on delivery for easier pickup',
  ];

  final _razorpay = Razorpay();

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment is failed");
    print(response.message);
    print(response.code);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("external wallet");
  }

  validatePaymentMethod() {
    if ((currentPaymentIndex == 0) && widget.deliveryType == 1) {
      return _customPopup.show(
          title: "Pay at store is not available for home delivery orders",
          subTitle:
              "Please change delivery type to store pickup to select this payment option.",
          buttonOneText: "Change delivery type",
          buttonTwoText: "Dismiss",
          context: context,
          buttonOneFunction: () {
            Navigator.pushReplacementNamed(context, '/order-summary');
          });
    } else if (currentPaymentIndex == 4 && widget.deliveryType == 0) {
      _customPopup.show(
          title: "Cash on delivery is not available for store pickup orders",
          subTitle: "Instead you can select pay at store payment method",
          buttonOneText: "Select pay at store",
          buttonTwoText: "Dismiss",
          context: context,
          buttonOneFunction: () {
            setState(() {
              currentPaymentIndex = 0;
            });
            Navigator.pop(context);
          });
    } else {
      return true;
    }
  }

  showCustomPopup(String title, String content) async {
    return _customPopup.show(
      title: title,
      buttonOneText: "Okay",
      buttonTwoText: "Dismiss",
      context: context,
    );
  }

  showPaymentWindow(
    String name,
    String email,
    int phoneNumber,
    String orderId,
    int amount,
    String method,
  ) async {
    var options = {
      'key': 'rzp_live_Yf6SskMc0yCBdS',
      'amount': (amount * 100).toString(),
      'name': 'Unboxedkart',
      'order_id': orderId,
      'description': "Purchase on unboxedkart",
      'timeout': 120,
      'prefill': {
        'contact': phoneNumber.toString(),
        'email': email,
        'method': method
      },
    };
    _razorpay.open(options);
  }

  showPaymentWindows() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc()..add(GetPayableAmount()),
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersPaymentVerifying) {
            return const LoadingSpinnerWidget();
          }
          if (state is OrdersPaymentVerified) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/create-order',
                  arguments: CreateOrderPage(
                    orderNumber: state.orderNumber,
                  ));
            });
          } else if (state is OrdersPaymentLoaded) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: CustomAppBar(
                  title: "Payment",
                  enableBack: true,
                ),
              ),
              bottomSheet: _BottomSheet(
                selectedPaymentMethod: isPaymentMethodSelected,
                payableAmount: state.payableAmount,
                currentPaymentIndex: currentPaymentIndex,
                function: () async {
                  bool isValid = await validatePaymentMethod();
                  if (isValid != null && isValid == true) {
                    if (currentPaymentIndex == 0) {
                      BlocProvider.of<OrdersBloc>(context).add(
                          SetPaymentMethod(paymentCodes[currentPaymentIndex]));
                    } else if (currentPaymentIndex == 1) {
                      showPaymentWindow(
                        state.name,
                        state.email,
                        state.phoneNumber,
                        state.partialPaymentOrderId,
                        state.partialPaymentAmount,
                        "",
                      );
                    } else if (currentPaymentIndex == 2) {
                      showPaymentWindow(
                        state.name,
                        state.email,
                        state.phoneNumber,
                        state.paymentOrderId,
                        state.payableAmount,
                        "upi",
                      );
                    } else if (currentPaymentIndex == 3) {
                      showPaymentWindow(
                          state.name,
                          state.email,
                          state.phoneNumber,
                          state.paymentOrderId,
                          state.payableAmount,
                          "card");
                    } else if (currentPaymentIndex == 4) {}
                    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        (PaymentSuccessResponse response) {
                      if (currentPaymentIndex == 1) {
                        BlocProvider.of<OrdersBloc>(context).add(
                            VerifyPartialPaymentSignature(response.signature,
                                response.paymentId, response.orderId));
                      } else {
                        BlocProvider.of<OrdersBloc>(context).add(
                            VerifyPaymentSignature(response.signature,
                                response.paymentId, response.orderId));
                      }
                    });
                    _razorpay.on(
                        Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
                    _razorpay.on(
                        Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
                  }
                },
              ),
              body: ListView(
                children: [
                  const orderSummaryStatus(
                    orderStatus: 3,
                  ),
                  PayAtStoreWidget(),
                  _PaymentWidget(
                    paymentIndex: 0,
                    currentPaymentIndex: currentPaymentIndex,
                    title: paymentTitles[0],
                    subTitle: paymentSubTitles[0],
                    function: () {
                      setState(() {
                        isPaymentMethodSelected = true;
                        currentPaymentIndex = 0;
                      });
                    },
                  ),
                  _PaymentWidget(
                    paymentIndex: 1,
                    currentPaymentIndex: currentPaymentIndex,
                    title: paymentTitles[1],
                    subTitle: paymentSubTitles[1],
                    function: () {
                      setState(() {
                        isPaymentMethodSelected = true;
                        currentPaymentIndex = 1;
                      });
                    },
                  ),
                  _PaymentWidget(
                    paymentIndex: 2,
                    currentPaymentIndex: currentPaymentIndex,
                    title: paymentTitles[2],
                    subTitle: paymentSubTitles[2],
                    function: () {
                      setState(() {
                        isPaymentMethodSelected = true;
                        currentPaymentIndex = 2;
                      });
                    },
                  ),
                  _PaymentWidget(
                    paymentIndex: 3,
                    currentPaymentIndex: currentPaymentIndex,
                    title: paymentTitles[3],
                    subTitle: paymentSubTitles[3],
                    function: () {
                      setState(() {
                        isPaymentMethodSelected = true;
                        currentPaymentIndex = 3;
                      });
                    },
                  ),
                  widget.deliveryType == 1
                      ? _PaymentWidget(
                          paymentIndex: 4,
                          currentPaymentIndex: currentPaymentIndex,
                          title: paymentTitles[4],
                          subTitle: paymentSubTitles[4],
                          function: () {
                            setState(() {
                              isPaymentMethodSelected = true;
                              currentPaymentIndex = 4;
                            });
                          },
                        )
                      : const SizedBox()
                ],
              ),
            );
          }
          return const CustomScaffold(
            pageTitle: "Payment",
            enableBack: true,
            child: LoadingSpinnerWidget(),
          );
        },
      ),
    );
  }
}

class _PaymentWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final int paymentIndex;
  final int currentPaymentIndex;
  final Function function;

  const _PaymentWidget(
      {Key key,
      this.title,
      this.subTitle,
      this.paymentIndex,
      this.currentPaymentIndex,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  paymentIndex == currentPaymentIndex
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: paymentIndex == currentPaymentIndex
                      ? CustomColors.blue
                      : Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomSizedTextBox(
                  textContent: title,
                  fontSize: 12,
                  isBold: true,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 35),
                child: CustomSizedTextBox(
                  textContent: subTitle,
                  isBold: false,
                  fontSize: 12,
                ))
          ],
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final payableAmount;
  final bool selectedPaymentMethod;
  final currentPaymentIndex;
  final Function function;

  const _BottomSheet(
      {Key key,
      this.payableAmount,
      this.currentPaymentIndex,
      this.selectedPaymentMethod,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomSizedTextBox(
                      textContent: "Payable amount : ",
                      fontSize: 12,
                      isBold: true,
                      color: Colors.grey,
                    ),
                    CustomSizedTextBox(
                      textContent: '₹$payableAmount',
                      isBold: true,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: CustomBottomButton(
                  function: () => function(),
                  title: "Make Payment",
                )),
          ],
        ),
      ),
    );
  }
}
