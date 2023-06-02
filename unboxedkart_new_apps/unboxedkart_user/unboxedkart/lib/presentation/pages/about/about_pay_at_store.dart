import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';

class PayAtStoreDetails extends StatelessWidget {
  const PayAtStoreDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(
            title: "Pay at store",
            enableBack: true,
          ),
          preferredSize: const Size.fromHeight(50)),
      body: const SingleChildScrollView(
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage(
              'assets/images/featured_images/about_pay_at_store.png'),
        ),
      ),
    );
  }
}
