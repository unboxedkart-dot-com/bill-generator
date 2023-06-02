import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

import '../../../constants/constants.dart';

class ShowCustomPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String buttonText;
  final Function function;
  final double iconSize;
  final double paddingWidth;

  const ShowCustomPage(
      {Key key,
      this.icon,
      this.title,
      this.buttonText,
      this.function,
      this.iconSize = 130,
      this.paddingWidth = 50})
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
            CustomSizedTextBox(
              paddingWidth: paddingWidth,
              addPadding: true,
              isBold: true,
              textContent: title,
              isCenter: true,
              fontSize: 15,
            ),
            // buttonText != null
            //     ? Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 50),
            //         child: CustomBottomButton(
            //           hasRoundedCorners: true,
            //           color: CustomColors.blue,
            //           title: buttonText,
            //           isBold: true,
            //           function: () => function(),
            //         ),
            //       )
            //     : const SizedBox()
          ]),
    );
  }
}
