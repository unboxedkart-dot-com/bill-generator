import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';

class AboutUnboxedkart extends StatelessWidget {
  const AboutUnboxedkart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(
            title: "About Unboxedkart",
            enableBack: true,
          ),
          preferredSize: const Size.fromHeight(50)),
      body: Container(
        margin: const EdgeInsets.only(top: 0),
        child: const SingleChildScrollView(
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
                'assets/images/featured_images/about_unboxedkart.png'),
          ),
        ),
      ),
    );
  }
}
