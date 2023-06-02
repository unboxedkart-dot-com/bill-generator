import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/coupon/coupon_bloc.dart';
 
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: CustomAppBar(
            title: "Refer & Earn",
            enableBack: true,
          ),
          preferredSize: const Size.fromHeight(50),
        ),
        body: BlocProvider(
          create: (context) => CouponBloc()..add(LoadPersonalCoupon()),
          child: BlocBuilder<CouponBloc, CouponState>(
            builder: (context, state) {
              if (state is CouponLoaded) {
                return Container(
                   
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      CustomSizedTextBox(
                        isCenter: true,
                        textContent:
                            "Invite your friends to shop on Unboxedkart",
                        isBold: true,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.8,
                            image: const AssetImage(
                                'assets/images/featured_images/refer.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(children: [
                             
                             
                             
                             
                             
                            TextSpan(
                                text:
                                    'When your friend use the referral coupon code to purchase a product, they will receive ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'T MS',
                                    color: Colors.black)),
                            TextSpan(
                                text: '₹500.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'T MS',
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " You'll gain ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: '₹500 ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'T MS',
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'in cash.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'T MS',
                                )),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomSizedTextBox(
                        textContent: "Send invite with referral coupon code.",
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: CustomColors.blue,
                        )),
                        child: Center(
                          child: CustomSizedTextBox(
                              textContent: state.coupon.couponCode,
                              fontSize: 16,
                              isBold: true),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _sendInviteLink(state.coupon.couponCode);
                           
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: CustomColors.blue,
                          child: CustomSizedTextBox(
                             
                            isCenter: true,
                            textContent: "SEND INVITE",
                            fontSize: 14,
                            isBold: true,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/coupon-referrals');
                        },
                        child: CustomSizedTextBox(
                          isCenter: true,
                          textContent: "SHOW MY REFERRALS",
                          fontSize: 16,
                          isBold: true,
                          color: CustomColors.blue,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ));
  }
}



   

   
     
     
     
     
     
   


     
   

   
     
     
     
     
     
     
     
     
