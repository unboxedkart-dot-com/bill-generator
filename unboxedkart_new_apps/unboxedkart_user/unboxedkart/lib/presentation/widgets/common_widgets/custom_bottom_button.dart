import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CustomBottomButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function function;
  final bool isBold;
  final bool hasRoundedCorners;

  const CustomBottomButton({
    Key key,
    this.color,
    this.title,
    this.function,
    this.isBold = false,
    this.hasRoundedCorners = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
        width: MediaQuery.of(context).size.width * 1,
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(hasRoundedCorners ? 6 : 0),
          color: color ?? CustomColors.blue,
        ),
        child: CustomSizedTextBox(
          color: Colors.white,
          textContent: title,
          isCenter: true,
          isBold: isBold,
        ),
      ),
    );
  }
}
