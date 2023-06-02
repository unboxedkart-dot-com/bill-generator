import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/user/user_bloc.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  UserBloc userBloc = UserBloc();
  TextEditingController upiIdController = TextEditingController();
  TextEditingController upiNameController = TextEditingController();

  setPaymentDetails(String upiName, String upiId) {
    upiIdController.text = upiId;
    upiNameController.text = upiName;
  }

  @override
  void initState() {
     
    userBloc.add(LoadPaymentDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: CustomBottomButton(
          title: "Continue",
          function: () {
            userBloc.add(UpdatePaymentDetails(
                upiNameController.text, upiIdController.text));
          },
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Payment Details",
          ),
        ),
        body: BlocProvider(
          create: (context) => userBloc..add(LoadPaymentDetails()),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is PaymentDetailsLoaded) {
                setPaymentDetails(
                    state.paymentDetails.upiName, state.paymentDetails.upiId);
                return ListView(children: [
                  CustomSizedTextBox(
                    paddingWidth: 10,
                    addPadding: true,
                    textContent:
                        "We would like to keep your account details secure, So we ask UPI details.",
                    fontSize: 14,
                  ),
                  CustomInputWidget(
                    textController: upiIdController,
                    placeHolderText: "UPI id",
                  ),
                  CustomInputWidget(
                    textController: upiNameController,
                    placeHolderText: "UPI Registered name",
                  ),
                ]);
              } else if (state is PaymentDetailsUpdated) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pop(context);
                });
              }
               
              return const LoadingSpinnerWidget();
               
            },
          ),
        ));
  }
}
