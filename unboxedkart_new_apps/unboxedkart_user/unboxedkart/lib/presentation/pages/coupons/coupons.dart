import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/coupon/coupon_bloc.dart';
import 'package:unboxedkart/presentation/models/coupon/coupon.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class Coupons extends StatelessWidget {
  const Coupons({Key key}) : super(key: key);

   

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        pageTitle: "My Coupons",
        child: BlocProvider(
          create: (context) => CouponBloc()..add(LoadUserCoupons()),
          child: BlocBuilder<CouponBloc, CouponState>(
            builder: (context, state) {
              if (state is UserCouponsLoaded) {
                if (state.coupons.isNotEmpty) {
                  return ListView.builder(
                      itemCount: state.coupons.length,
                      itemBuilder: (context, index) {
                        return Coupon(coupon: state.coupons[index]);
                      });
                } else {
                  return const ShowCustomPage(
                    icon: Icons.receipt,
                    title: "We are sorry, No coupons found. Our team is on it's way to find the best coupon's available for you.",
                  );
                }
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ));
  }
}

class _BuildNoCoupons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.paperplane,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'No products',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
