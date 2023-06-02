import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/addresses/addresses_bloc.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CreateAddressPage extends StatefulWidget {
  final Function function;
  final String previousPage;

  const CreateAddressPage({Key key, this.function, this.previousPage})
      : super(key: key);
  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController laneController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController alternatePhoneNumberController =
      TextEditingController();
  String addressType = "Home Address";
  final CustomAlertPopup _customPopup = CustomAlertPopup();

   
  addressTypeModelWidget({String title}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          addressType = title;
        });
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(
          addressType == title
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: addressType == title ? Colors.blueAccent : null,
        ),
        title: CustomSizedTextBox(
            textContent: title, isBold: addressType == title ? true : false),
      ),
    );
  }

  checkIfValid(AddressModel address) {
    if (address.doorNo.length > 1 &&
        address.street.length > 1 &&
        address.cityName.length > 1 &&
        address.stateName.length > 1 &&
        address.phoneNumber.toString().length == 10 &&
        address.pinCode.toString().length == 6 &&
        address.addressType.length > 1) {
      return true;
    } else {
      return false;
    }
  }

  showCustomPopUp(String title) {
    return _customPopup.show(
      title: title,
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressesBloc(),
      child: BlocBuilder<AddressesBloc, AddressesState>(
        builder: (context, state) {
          if (state is CreateAddressLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(
                title: "create address",
                enableBack: true,
              ),
            ),
            bottomSheet: CustomBottomButton(
              title: "Add Address",
              function: () {
                AddressModel address = AddressModel(
                  doorNo: doorNoController.text,
                  lane: laneController.text,
                  street: streetNameController.text,
                  cityName: cityNameController.text,
                  stateName: stateNameController.text,
                  pinCode: pinCodeController.text.length > 1
                      ? int.parse(pinCodeController.text)
                      : null,
                  landmark: landmarkController.text,
                  name: nameController.text,
                  phoneNumber: phoneNumberController.text.length > 1
                      ? int.parse(phoneNumberController.text)
                      : null,
                  alternatePhoneNumber:
                      alternatePhoneNumberController.text.length > 1
                          ? int.parse(alternatePhoneNumberController.text)
                          : null,
                  addressType: addressType,
                );
                checkIfValid(address)
                    ? BlocProvider.of<AddressesBloc>(context)
                        .add(AddAddress(address: address))
                    : showCustomPopUp("Please fill all the required fields");
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  CustomInputWidget(
                      textController: doorNoController,
                      placeHolderText: 'Door no *'),
                  CustomInputWidget(
                      textController: laneController,
                      placeHolderText: 'Address Line 1'),
                  CustomInputWidget(
                      textController: streetNameController,
                      placeHolderText: 'Street / Area *'),
                  CustomInputWidget(
                      textController: cityNameController,
                      placeHolderText: 'City *'),
                  CustomInputWidget(
                      textController: stateNameController,
                      placeHolderText: 'State *'),
                  CustomInputWidget(
                      textController: pinCodeController,
                      isInt: true,
                      maxLength: 6,
                      minLength: 6,
                      placeHolderText: 'Pincode *'),
                  CustomInputWidget(
                      textController: landmarkController,
                      placeHolderText: 'Landmark'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSizedTextBox(
                    textContent: 'Person Details',
                    fontSize: 14,
                    isBold: true,
                    addPadding: true,
                    paddingWidth: 8,
                  ),
                  CustomInputWidget(
                      textController: nameController,
                      placeHolderText: 'Name *'),
                  CustomInputWidget(
                      textController: phoneNumberController,
                      minLength: 10,
                      maxLength: 10,
                      isInt: true,
                      placeHolderText: '10 - Digit Mobile Number *'),
                  CustomInputWidget(
                      minLength: 10,
                      maxLength: 10,
                      isInt: true,
                      textController: alternatePhoneNumberController,
                      placeHolderText: 'Alternate Mobile Number'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSizedTextBox(
                    textContent: 'Address type *',
                    fontSize: 14,
                    isBold: true,
                    addPadding: true,
                    paddingWidth: 8,
                  ),
                  addressTypeModelWidget(title: 'Home Address'),
                  addressTypeModelWidget(title: 'Work/Office Address'),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
