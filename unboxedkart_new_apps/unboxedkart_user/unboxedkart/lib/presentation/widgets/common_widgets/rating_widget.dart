import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class RatingWidget extends StatelessWidget {
  final num rating;

  const RatingWidget({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.green,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: CustomSizedTextBox(
          textContent: '${rating.toStringAsFixed(1)} ★',
          fontSize: 12,
          isBold: true,
          color: Colors.white,
        ),
      ),
    );
  }
}
