import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

import '../../../constants/constants.dart';

class CustomNoWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double iconSize;

  const CustomNoWidget({Key key, this.title, this.icon, this.iconSize = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: iconSize,
              color: CustomColors.blue,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomSizedTextBox(
              textContent: title,
              isCenter: true,
              fontSize: 13,
            )
          ]),
    );
  }
}
