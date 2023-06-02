import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class ShowSignInPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const ShowSignInPage({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 150,
              color: CustomColors.blue,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomSizedTextBox(
              paddingWidth: 50,
              addPadding: true,
              isBold: true,
              textContent: title,
              isCenter: true,
              fontSize: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomBottomButton(
                function: () {
                  Navigator.pushNamed(context, '/login');
                },
                color: CustomColors.blue,
                title: "Sign in",
              ),
            )
          ]),
    );
  }
}
