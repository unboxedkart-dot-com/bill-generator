import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/models/order_tile/order_tile.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';

import '../../widgets/custom_sized_text.dart';

class OrderCancelled extends StatelessWidget {
  final String orderId;

  const OrderCancelled({Key key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "Order cancelled",
      bottomButton: CustomBottomButton(
        title: "Check status",
        function: () {
          Navigator.pushReplacementNamed(context, '/order',
              arguments: OrderTileNew(orderId: orderId));
        },
      ),
      child: ListView(
        children: [
          ElevatedContainer(
            elevation: 0,
            child: Column(
              children: [
                const Icon(
                  CupertinoIcons.check_mark_circled,
                  size: 60,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomSizedTextBox(
                  isCenter: true,
                  textContent: "Order Cancelled successfully",
                  fontSize: 20,
                  isBold: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomSizedTextBox(
                  textContent:
                      "Your order is cancelled, we look forward to see you again.",
                  fontSize: 14,
                  isBold: false,
                  isCenter: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                 
                 
                 
                 
                 
                 
                 
                 
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                     
                     
                     
                     
                     
                    TextSpan(
                        text:
                            "If you have any other queries, You can always contact our suppport team at ",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'T MS',
                            color: Colors.black)),
                    TextSpan(
                        text: 'support@unboxedkart.com ',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'T MS',
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "or call us on ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: '+91 8508484848',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'T MS',
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
