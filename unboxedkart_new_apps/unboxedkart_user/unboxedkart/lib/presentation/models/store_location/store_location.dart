import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/url_actions.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class StoreLocation extends StatelessWidget {
  final StoreLocationModel storeLocation;

  const StoreLocation({Key key, this.storeLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSizedTextBox(
                  textContent: storeLocation.storeName,
                  fontSize: 14,
                  isBold: true),
              const SizedBox(
                height: 8,
              ),
              CustomSizedTextBox(
                  textContent: '${storeLocation.streetName},', fontSize: 14),
              CustomSizedTextBox(
                  textContent: '${storeLocation.cityName},', fontSize: 14),
              CustomSizedTextBox(
                  textContent: '${storeLocation.pinCode},', fontSize: 14),
              const SizedBox(
                height: 8,
              ),
              CustomSizedTextBox(
                  textContent: 'Store timings - ,', fontSize: 14, isBold: true),
              CustomSizedTextBox(
                  textContent: 'Open hours : ${storeLocation.storeTimings},',
                  fontSize: 14),
              CustomSizedTextBox(
                  textContent: 'Open Days :  ${storeLocation.storeOpenDays}',
                  fontSize: 14),
              // SizedBox(
              //   height: 2,
              // ),
              CustomSizedTextBox(
                  textContent:
                      'Contact number : ${storeLocation.contactNumber},',
                  fontSize: 14,
                  isBold: true),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  UrlActions.handleOpenUrl(storeLocation.directionsUrl);
                },
                child: CustomSizedTextBox(
                    textContent: 'Click here to get directions to the store',
                    fontSize: 14,
                    color: CustomColors.blue,
                    isBold: true),
              ),
            ]),
      ),
    );
  }
}

class CustomStoreLocation extends StatefulWidget {
  final StoreLocationModel storeLocation;

  const CustomStoreLocation({Key key, this.storeLocation}) : super(key: key);

  @override
  State<CustomStoreLocation> createState() => _CustomStoreLocationState();
}

class _CustomStoreLocationState extends State<CustomStoreLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSizedTextBox(
                textContent: widget.storeLocation.storeName,
                fontSize: 14,
                isBold: true),
            const SizedBox(
              height: 8,
            ),
            CustomSizedTextBox(
                textContent: '${widget.storeLocation.streetName},',
                fontSize: 14),
            CustomSizedTextBox(
                textContent: '${widget.storeLocation.cityName},', fontSize: 14),
            CustomSizedTextBox(
                textContent: '${widget.storeLocation.pinCode},', fontSize: 14),
            const SizedBox(
              height: 8,
            ),
            CustomSizedTextBox(
                textContent: 'Store timings - ,', fontSize: 14, isBold: true),
            CustomSizedTextBox(
                textContent:
                    'Open hours : ${widget.storeLocation.storeTimings},',
                fontSize: 14),
            CustomSizedTextBox(
                textContent:
                    'Open Days :  ${widget.storeLocation.storeOpenDays}',
                fontSize: 14),
            // SizedBox(
            //   height: 2,
            // ),
            CustomSizedTextBox(
                textContent:
                    'Contact number : ${widget.storeLocation.contactNumber},',
                fontSize: 14,
                isBold: true),
          ]),
    );
  }
}
