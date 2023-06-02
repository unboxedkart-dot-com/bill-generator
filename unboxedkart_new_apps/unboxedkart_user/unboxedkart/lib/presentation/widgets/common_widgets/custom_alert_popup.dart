import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CustomAlertPopup {
  showLoginPopup(
    BuildContext context,
    String title,
  ) {
    return show(
      title: "$title",
      buttonOneText: "Login",
      context: context,
      buttonOneFunction: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/login');
      },
    );
  }

  show(
      {final String title,
      final String subTitle,
      final BuildContext context,
      final Function buttonOneFunction,
      final Function buttonTwoFunction,
      final String buttonOneText,
      final String buttonTwoText,
      final bool dismissable = true}) {
    Platform.isIOS
        ? _showIosSimpleAlert(
            title: title,
            context: context,
            subTitle: subTitle,
            buttonTwoFunction: buttonTwoFunction,
            buttonOneText: buttonOneText,
            buttonTwoText: buttonTwoText,
            buttonOneFunction: buttonOneFunction,
            dismissable: dismissable)
        : _showAndroidSimpleAlert(
            title: title,
            subTitle: subTitle,
            buttonTwoFunction: buttonTwoFunction,
            buttonOneText: buttonOneText,
            buttonTwoText: buttonTwoText,
            buttonOneFunction: buttonOneFunction,
            context: context);
  }

  _showIosSimpleAlert(
      {final String title,
      final String subTitle,
      final BuildContext context,
      final Function buttonOneFunction,
      final Function buttonTwoFunction,
      final String buttonOneText,
      final String buttonTwoText,
      final bool dismissable}) {
    return showDialog(
        context: context,
        barrierDismissible: dismissable,
        builder: (context) => CupertinoAlertDialog(
              title: CustomSizedTextBox(
                isBold: true,
                isCenter: true,
                textContent: title,
                fontSize: 14,
              ),
              content: CustomSizedTextBox(
                isCenter: true,
                textContent: subTitle ?? "",
                fontSize: 12,
              ),
              actions: buttonTwoText != null
                  ? <Widget>[
                      CupertinoDialogAction(
                        child: CustomSizedTextBox(
                          isCenter: true,
                          color: CustomColors.blue,
                          isBold: true,
                          textContent: buttonOneText ?? "Dismiss",
                          fontSize: 14,
                        ),
                        onPressed:
                            buttonOneFunction ?? () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        child: CustomSizedTextBox(
                          isCenter: true,
                          color: CustomColors.blue,
                          isBold: true,
                          textContent: buttonTwoText,
                          fontSize: 14,
                        ),
                        onPressed:
                            buttonTwoFunction ?? () => Navigator.pop(context),
                      )
                    ]
                  : <Widget>[
                      CupertinoDialogAction(
                        child: CustomSizedTextBox(
                          isCenter: true,
                          color: CustomColors.blue,
                          isBold: true,
                          textContent: buttonOneText ?? "Dismiss",
                          fontSize: 14,
                        ),
                        onPressed:
                            buttonOneFunction ?? () => Navigator.pop(context),
                      ),
                    ],
            ));
  }

  _showAndroidSimpleAlert(
      {final String title,
      final String subTitle,
      final BuildContext context,
      final Function buttonOneFunction,
      final Function buttonTwoFunction,
      final String buttonOneText,
      final String buttonTwoText,
      final bool nonDismissable}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomSizedTextBox(
                textContent: title,
                fontSize: 14,
              ),
              content: CustomSizedTextBox(
                textContent: subTitle ?? "",
                fontSize: 14,
              ),
              actions: <Widget>[
                TextButton(
                    onPressed:
                        buttonOneFunction ?? () => Navigator.pop(context),
                    child: Text(
                      buttonOneText ?? 'Ok',
                      style:
                          const TextStyle(fontFamily: 'Amaranth', fontSize: 16),
                    )),
                TextButton(
                    onPressed:
                        buttonTwoFunction ?? () => Navigator.pop(context),
                    child: Text(
                      buttonTwoText ?? 'Dismiss',
                      style:
                          const TextStyle(fontFamily: 'Amaranth', fontSize: 16),
                    )),
              ],
            ));
  }
}
