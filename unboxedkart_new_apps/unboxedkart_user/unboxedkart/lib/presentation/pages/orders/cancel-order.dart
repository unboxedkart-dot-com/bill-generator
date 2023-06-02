import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/orders/orders_bloc.dart';
import 'package:unboxedkart/presentation/pages/orders/order-cancelled.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_radio_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class CancelOrderPage extends StatefulWidget {
  final String orderId;
  final String orderNumber;

  const CancelOrderPage({Key key, this.orderId, this.orderNumber})
      : super(key: key);

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();
  List<String> orderCancellationReasons = [
    "Price for the product has decreased",
    "I have changed my mind",
    "I have purchased the product somewhere else",
    "I want to change the pickup location /delivery address for the order",
    "I ordered the product by mistake"
  ];
   
  int groupValue;
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
          create: (context) => OrdersBloc(),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is CancelOrderLoading) {
                return const LoadingSpinnerWidget();
              } else if (state is CancelOrderLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pushReplacementNamed(context, '/order-cancelled',
                      arguments: OrderCancelled(
                        orderId: widget.orderId,
                      ));
                });
              }
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: CustomAppBar(title: 'Order cancellation'),
                ),
                bottomSheet: CustomBottomButton(
                  title: 'Submit request',
                  function: () {
                    if (groupValue != null) {
                      BlocProvider.of<OrdersBloc>(context).add(CancelOrder(
                          widget.orderId,
                          widget.orderNumber,
                          orderCancellationReasons[groupValue],
                          contentController.text));
                    } else {
                      _customPopup.show(
                        context: context,
                        title: "Please select a reason for cancellation",
                      );
                    }
                  },
                ),
                body: ElevatedContainer(
                  elevation: 0,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomSizedTextBox(
                        addPadding: true,
                        textContent: "Reason for cancellation",
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderCancellationReasons.length,
                          itemBuilder: (context, index) {
                            return CustomRadioButton(
                              groupValue: groupValue,
                              buttonValue: index,
                              title: orderCancellationReasons[index],
                              function: () {
                                setState(() {
                                  groupValue = index;
                                });
                              },
                            );
                          }),
                      CustomSizedTextBox(
                        addPadding: true,
                        textContent:
                            "Write more about your reason of cancellation...",
                        fontSize: 14,
                      ),
                      CustomInputWidget(
                        minLines: 4,
                        textController: contentController,
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
