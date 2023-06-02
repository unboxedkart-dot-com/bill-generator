import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/presentation/pages/order_summary/order_summary.dart';

class orderSummaryStatus extends StatelessWidget {
  final int orderStatus;

  const orderSummaryStatus({Key key, this.orderStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    return Container(
       
      padding: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.white,
      height: 50,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CustomNumberedCircle(
                  title: "1",
                  icon: orderStatus > 1 ? Icons.check : null,
                  backgroundColor: orderStatus == 1 ? CustomColors.blue : Colors.white,
                  textColor: orderStatus == 1 ? Colors.white : CustomColors.blue,
                  borderColor: CustomColors.blue,
                  subTitle: "Order Summary",
                ),
              ),
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Divider(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomNumberedCircle(
                  title: "2",
                  icon: orderStatus > 2 ? Icons.check : null,
                  backgroundColor: orderStatus == 2 ? CustomColors.blue : Colors.white,
                  textColor: orderStatus == 2 ? Colors.white : CustomColors.blue,
                  borderColor: CustomColors.blue,
                   
                   
                   
                   
                  subTitle: "Address",
                ),
              ),
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Divider(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomNumberedCircle(
                  title: "3",
                  icon: orderStatus > 3 ? Icons.check : null,
                  backgroundColor: orderStatus == 3 ? CustomColors.blue : Colors.white,
                  textColor: orderStatus == 3 ? Colors.white : CustomColors.blue,
                  borderColor: CustomColors.blue,
                   
                   
                   
                   
                  subTitle: "Payment",
                ),
              ),
            ]),
      ),
    );
  }
}
