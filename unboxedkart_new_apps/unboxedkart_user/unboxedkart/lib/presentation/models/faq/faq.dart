import 'package:flutter/material.dart';
import 'package:unboxedkart/models/faq/faq.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class Faq extends StatelessWidget {
  final FaqModel faq;

  const Faq({Key key, this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomSizedTextBox(
          textContent: '${faq.question} ? ',
          fontSize: 13,
          isBold: true,
          color: Colors.black),
            const SizedBox(
        height: 5,
            ),
            CustomSizedTextBox(
          textContent: faq.answer,
          fontSize: 13,
          isBold: false,
          color: Colors.black),
          ]),
      ),
    );
  }
}
