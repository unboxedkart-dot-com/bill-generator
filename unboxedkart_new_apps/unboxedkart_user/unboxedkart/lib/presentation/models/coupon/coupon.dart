import 'package:flutter/material.dart';
import 'package:unboxedkart/models/coupon/coupon.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class Coupon extends StatelessWidget {
  final CouponModel coupon;

  const Coupon({Key key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Container(

        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    CustomSizedTextBox(
                      textContent: '₹${coupon.discountAmount}',
                      isBold: true,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                    CustomSizedTextBox(
                      textContent: 'OFF',
                      isBold: true,
                      fontSize: 18,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
                child: VerticalDivider(
                  color: Colors.blueGrey,
                  thickness: 0.5,
                  indent: 5,
                  endIndent: 0,
                  width: 20,
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedTextBox(
                      textContent: coupon.couponDescription,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'On minimum purchase of ',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'T MS',
                            )),
                        TextSpan(
                            text: '${coupon.minimumOrderTotal}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'T MS',
                            )),
                      ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Code : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'T MS',
                                fontSize: 15)),
                        TextSpan(
                            text: coupon.couponCode,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'T MS',
                                fontSize: 15)),
                      ]),
                    ),
 
                  ],
                ),
              )
            ],
          ),
          const Divider(color: Colors.blueGrey),
          Row(
            children: [
              CustomSizedTextBox(
                textContent: 'Expiry : ',
                fontSize: 12,
              ),
              CustomSizedTextBox(
                textContent: coupon.expiryType == "EXPIRABLE"
                    ? coupon.expiryTime
                    : coupon.expiryType.toString(),
                fontSize: 12,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
