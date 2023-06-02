import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/models/referral/referral.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class Referral extends StatelessWidget {
  final ReferralModel referral;

  const Referral({Key key, this.referral}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical : 8.0),
        child: Column(children: [
          ListTile(
            title: CustomSizedTextBox(
              textContent: referral.referreName,
              fontSize: 15,
            ),
            // minLeadingWidth: 0,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedTextBox(
                  textContent:
                      "order status : ${referral.isCompleted ? "completed" : "ordered"}",
                  fontSize: 14,
                ),
                CustomSizedTextBox(
                  textContent:
                      "ordered on ${referral.timestamp.day} ${months[referral.timestamp.month - 1]}",
                  fontSize: 12,
                  // color: Colors.grey,
                ),
              ],
            ),
            trailing: Column(
              children: [
                CustomSizedTextBox(
                  textContent: "₹${referral.cashBackAmount}",
                  color: Colors.green,
                ),
                CustomSizedTextBox(
                  textContent:
                      referral.cashBackIsCredited ? "(amount credited)" : "(will be credited)",
                  color: Colors.black,
                  fontSize: 12,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
