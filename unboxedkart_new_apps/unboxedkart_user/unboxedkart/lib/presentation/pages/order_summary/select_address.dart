import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/addresses/addresses_bloc.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/presentation/models/address/address.dart';
import 'package:unboxedkart/presentation/pages/addresses/addresses.dart';
import 'package:unboxedkart/presentation/pages/order_summary/payment.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/order_summary_status.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key key}) : super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  AddressModel selectedAddress;

  int selectedAddressIndex;

  final CustomAlertPopup _customPopup = CustomAlertPopup();

  _showCustomPopup(String title, String subtitle) {
    return _customPopup.show(
      title: title,
      subTitle: subtitle,
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  _handleSelectDeliveryAddress({int index, AddressModel address}) {
    selectedAddress = address;
    setState(() {
      selectedAddressIndex = index;
    });
  }

  _handleSaveAddressInDb() {
    BlocProvider.of<OrdersummaryBloc>(context)
        .add(AddShippingDetails(deliveryType: 1, address: selectedAddress));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(title: 'Select Address', enableBack: true),
        ),
        bottomSheet: CustomBottomButton(
             
            title: "Select Address",
            function: () async {
              if (selectedAddressIndex != null) {
                await _handleSaveAddressInDb();
                Navigator.pushNamed(context, '/payment',
                    arguments: const PaymentPage(
                      deliveryType: 1,
                    ));
              } else {
                _showCustomPopup("Please select a delivery address", "");
              }
            }),
        body: SafeArea(
          child: BlocProvider(
            create: (context) =>
                AddressesBloc()..add(const LoadSelectAddress(deliveryType: 1)),
            child: BlocBuilder<AddressesBloc, AddressesState>(
              builder: (context, state) {
                if (state is AddressesLoadedState) {
                  return ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const orderSummaryStatus(
                          orderStatus: 2,
                        ),
                        _ShowUserAddress(
                          reloadFunction: () async {
                            await Navigator.pushNamed(
                                context, '/create-address');

                            BlocProvider.of<AddressesBloc>(context)
                                .add(const LoadSelectAddress(deliveryType: 1));
                          },
                          addresses: state.addresses,
                          selectedAddressIndex: selectedAddressIndex,
                          function: (val) => _handleSelectDeliveryAddress(
                              index: val, address: state.addresses[val]),
                        ),
                      ]);
                } else {
                  return const LoadingSpinnerWidget();
                }
              },
            ),
          ),
        ));
  }
}

class _ShowUserAddress extends StatelessWidget {
  final List<AddressModel> addresses;
  final Function function;
  final int selectedAddressIndex;
  final reloadFunction;

  _ShowUserAddress(
      {Key key,
      this.addresses,
      this.function,
      this.selectedAddressIndex,
      this.reloadFunction})
      : super(key: key);

  int addressGroupValue;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        ShowAddAddressWidget(
          function: () => reloadFunction(),
        ),
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  function(index);
                },
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                        value: index,
                        groupValue: selectedAddressIndex,
                        onChanged: (val) {},
                      ),
                      Flexible(
                        child: CustomAddress(
                          address: addresses[index],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
         
         
         
      ],
    );
  }
}

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const <Widget>[
                Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.blueAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Add new address',
                  style: TextStyle(fontSize: 18, color: CustomColors.blue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
