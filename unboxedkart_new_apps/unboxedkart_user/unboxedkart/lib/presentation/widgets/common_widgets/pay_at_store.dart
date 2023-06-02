import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class PayAtStoreWidget extends StatelessWidget {
  PayAtStoreWidget({Key key}) : super(key: key);

  final UsageTrackingApi _trackingApi = UsageTrackingApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _trackingApi.handleKnowMoreAboutStorePickup();
        Navigator.pushNamed(context, '/pay-at-store');
      },
      child: ElevatedContainer(
        elevation: 2,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedTextBox(
                  textContent: 'Introducing Store Pickup',
                  fontName: 'Alegreya Sans',
                  color: CustomColors.blue,
                  fontSize: 17,
                  isBold: true),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: CustomSizedTextBox(
                    fontName: 'Alegreya Sans',
                    textContent:
                        'Now, You can reserve a product without making an upfront payment and visit our store within next 48 hours to inspect and purchase it.',
                    fontSize: 15),
              ),
              CustomSizedTextBox(
                  fontName: 'Alegreya Sans',
                  textContent: 'Click here to know more..',
                  fontSize: 14,
                  color: CustomColors.yellow,
                  isBold: true),
            ],
          ),
        ),
      ),
    );
  }
}
