import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/orders/orders_bloc.dart';
import 'package:unboxedkart/models/referral/referral.model.dart';
import 'package:unboxedkart/presentation/models/referral/referral.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';
import 'package:url_launcher/url_launcher.dart';

class CouponReferralPage extends StatelessWidget {
  const CouponReferralPage({Key key}) : super(key: key);

  void _sendInviteLink(String couponCode) async {
    String inviteBody =
        "Exclusive : Hey, Now you can shop on unboxedkart using my coupon code ($couponCode) and get a flat discount of Rs.500.Click here to download app unboxedkart.com/app";
    if (Platform.isAndroid) {
      String _url = "sms:?body=$inviteBody";
      if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
    } else if (Platform.isIOS) {
      String _url = "sms:&body=$inviteBody";
      if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
    }
  }

  handleGetReferralEarnings(List<ReferralModel> referrals) {
    int referralEarning = 0;
    for (var element in referrals) {
      referralEarning += element.cashBackAmount;
    }
    return referralEarning;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "My Referrals",
      child: BlocProvider(
          create: (context) => OrdersBloc()..add(LoadMyReferralOrders()),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is ReferralsLoaded) {
                if (state.referrals.isNotEmpty) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ShowAddPaymentDetails(function: () {
                        Navigator.pushNamed(context, '/payment-details');
                      }),
                      _ReferralEarnings(
                        amount: handleGetReferralEarnings(state.referrals),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.referrals.length,
                          itemBuilder: (context, index) {
                            return Referral(referral: state.referrals[index]);
                          }),
                    ],
                  );
                } else {
                  return ShowCustomPage(
                    icon: FontAwesome.money,
                    title:
                        "It looks like you haven't referred anyone yet. Start referring now to earn special cashbacks.",
                    buttonText: "Refer now",
                    function: () => _sendInviteLink,
                  );
                }
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          )),
    );
  }
}

class _BuildNoReferrals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.money_dollar,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'You have no referrals',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}

class ShowAddPaymentDetails extends StatelessWidget {
  final String previousPage;
  final Function function;

  const ShowAddPaymentDetails({Key key, this.function, this.previousPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        function();
      },
      child: ElevatedContainer(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const <Widget>[
              Icon(
                Icons.payment,
                size: 24,
                color: Colors.blueAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Payment details',
                style: TextStyle(fontSize: 18, color: CustomColors.blue),
              )
            ],
          ),
        ),
      ),

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
    );
  }
}

class _ReferralEarnings extends StatelessWidget {
  final int amount;

  const _ReferralEarnings({Key key, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
        elevation: 0,
        child: Column(
          children: [
            CustomSizedTextBox(
              textContent: "₹$amount",
              fontSize: 40,
              color: CustomColors.blue,
            ),
            CustomSizedTextBox(
              textContent: "Your Earnings",
            )
          ],
        ));
  }
}
