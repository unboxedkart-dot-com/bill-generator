import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/coupon/coupon_bloc.dart';
import 'package:unboxedkart/models/coupon/coupon.model.dart';
import 'package:unboxedkart/presentation/models/coupon/coupon.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ApplyCouponPage extends StatelessWidget {
  TextEditingController couponCodeTextController = TextEditingController();

  ApplyCouponPage({Key key}) : super(key: key);




   

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CouponBloc(),
        child: BlocBuilder<CouponBloc, CouponState>(
          builder: (context, state) {
            return Scaffold(
              appBar: PreferredSize(
                child: CustomAppBar(
                  enableBack: true,
                  title: "Coupons",
                ),
                preferredSize: const Size.fromHeight(50),
              ),
              bottomSheet: _BottomSheet(
                appliedCoupon:
                    (state is ApplyCouponLoadedState && state.coupon != null
                        ? state.coupon
                        : CouponModel(discountAmount: 0)),
                 
                 
                 
                 
              ),
              body: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                     
                    width: MediaQuery.of(context).size.width,
                     
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFF0F0F0),
                        ),
                        color: Colors.white),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 7,
                            child: CupertinoTextField(
                              inputFormatters: [UpperCaseTextFormatter()],
                              textCapitalization: TextCapitalization.characters,
                              placeholder: "Enter coupon code",
                              placeholderStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                              controller: couponCodeTextController,
                              cursorColor: Colors.blueAccent,
                               
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                 
                                BlocProvider.of<CouponBloc>(context).add(
                                    ValidateCoupon(
                                         
                                        couponCode:
                                            couponCodeTextController.text));
                                 
                              },
                              child: CustomSizedTextBox(
                                paddingWidth: 5,
                                addPadding: true,
                                textContent: "CHECK",
                                isBold: true,
                                color: Colors.blueAccent,
                              ),
                            ),
                          )
                        ]),
                  ),
                  Container(
                      child: (state is ApplyCouponLoadedState)
                          ? _ShowCouponDetails(
                              coupon: state.coupon,
                              errorText: state.errorText,
                              isValid: state.isValid,
                            )
                          : (state is ApplyCouponLoadingState)
                              ? const LoadingSpinnerWidget()
                              : const SizedBox())
                ],
              ),
            );
          },
        ));
  }
}

class _ShowCouponDetails extends StatelessWidget {
  final bool isValid;
  final String errorText;
  final CouponModel coupon;

  const _ShowCouponDetails({Key key, this.errorText, this.coupon, this.isValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isValid) {
      return Coupon(coupon: coupon);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        child: CustomSizedTextBox(
          textContent: errorText,
          color: Colors.red,
          fontSize: 14,
        ),
      );
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final int discountAmount;
  final CouponModel appliedCoupon;

  const _BottomSheet({Key key, this.discountAmount, this.appliedCoupon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
             
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSizedTextBox(
                  textContent: "Maximum savings",
                  fontSize: 10,
                  isBold: true,
                  color: Colors.grey,
                ),
                CustomSizedTextBox(
                  textContent: '₹${appliedCoupon.discountAmount}',
                  isBold: true,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomBottomButton(
            function: () {
              Navigator.pop(context, appliedCoupon

                   
                   
                   
                   
                   
                   
                  );
            },
            title: "Apply Coupon",
          ),
        ),
      ],
    );
  }
}
