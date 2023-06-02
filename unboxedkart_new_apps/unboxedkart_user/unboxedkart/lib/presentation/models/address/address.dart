import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/addresses/addresses_bloc.dart';
import 'package:unboxedkart/presentation/pages/addresses/edit_address.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

import '../../../../models/address/address.model.dart';

class Address extends StatefulWidget {
  final AddressModel address;

  const Address({Key key, this.address}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return _ShowAddressDetails(address: widget.address);
  }
}

class _ShowAddressDetails extends StatelessWidget {
  final AddressModel address;

  _ShowAddressDetails({this.address});
  // const _ShowAddressDetails({ Key? key }) : super(key: key);

  final CustomAlertPopup _customPopup = CustomAlertPopup();

  showDeleteAddressPopup(BuildContext context, Function function) {
    return _customPopup.show(
        title: "Would you like to delete this address.",
        buttonOneFunction: () => function(),
        buttonOneText: "Yes",
        buttonTwoText: "No",
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomSizedTextBox(
                      textContent: address.name,
                      fontSize: 14,
                      isBold: true),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDeleteAddressPopup(context, () {
                            Navigator.pop(context);
                            BlocProvider.of<AddressesBloc>(context).add(
                                DeleteAddress(
                                    addressId: address.addressId));
                          });
                        },
                        child: Icon(
                          FontAwesome.trash_o,
                          color: CustomColors.blue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.pushNamed(
                              context, '/edit-address',
                              arguments: EditAddressPage(
                                address: address,
                              ));
                          BlocProvider.of<AddressesBloc>(context)
                              .add(LoadUserAddresses());
                        },
                        child: Icon(
                          FontAwesome.pencil,
                          color: CustomColors.blue,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomSizedTextBox(
                textContent: '${address.doorNo},', fontSize: 14),
            address.lane.isNotEmpty
                ? CustomSizedTextBox(
                    textContent: '${address.lane},', fontSize: 14)
                : const SizedBox(),
            CustomSizedTextBox(
                textContent: '${address.street},', fontSize: 14),
            CustomSizedTextBox(
                textContent: '${address.landmark},', fontSize: 14),
            CustomSizedTextBox(
                textContent: '${address.cityName},', fontSize: 14),
            CustomSizedTextBox(
                textContent: '${address.stateName},', fontSize: 14),
            CustomSizedTextBox(
                textContent: '${address.pinCode}.', fontSize: 14),
            const SizedBox(
              height: 4,
            ),
            CustomSizedTextBox(
                textContent: 'Contact number : ${address.phoneNumber}',
                fontSize: 14,
                isBold: false),
          ]),
    );
  }
}

class CustomAddress extends StatefulWidget {
  final AddressModel address;

  const CustomAddress({Key key, this.address}) : super(key: key);

  @override
  State<CustomAddress> createState() => _CustomAddressState();
}

class _CustomAddressState extends State<CustomAddress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        // borderRadius: BorderRadius.circular(10),
        // elevation: 5,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedTextBox(
                    textContent: widget.address.name,
                    fontSize: 14,
                    isBold: true),
                const SizedBox(
                  height: 8,
                ),
                CustomSizedTextBox(
                    textContent: '${widget.address.doorNo},', fontSize: 14),
                widget.address.lane != null
                    ? CustomSizedTextBox(
                        textContent: '${widget.address.lane},', fontSize: 14)
                    : const SizedBox(),
                CustomSizedTextBox(
                    textContent: '${widget.address.street},', fontSize: 14),
                CustomSizedTextBox(
                    textContent: '${widget.address.landmark},', fontSize: 14),
                CustomSizedTextBox(
                    textContent: '${widget.address.cityName},', fontSize: 14),
                CustomSizedTextBox(
                    textContent: '${widget.address.stateName},', fontSize: 14),
                CustomSizedTextBox(
                    textContent: '${widget.address.pinCode};,', fontSize: 14),
                const SizedBox(
                  height: 4,
                ),
                CustomSizedTextBox(
                    textContent:
                        'Phone number : ${widget.address.phoneNumber},',
                    fontSize: 14,
                    isBold: true),
              ]),
        ),
      ),
    );
  }
}