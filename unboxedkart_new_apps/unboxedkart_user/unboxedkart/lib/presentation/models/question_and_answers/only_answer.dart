import 'package:flutter/material.dart';
import 'package:unboxedkart/models/question_and_answers/answer.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class OnlyAnswer extends StatelessWidget {
  final AnswerModel answer;

  const OnlyAnswer({Key key, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedTextBox(
                  textContent: answer.productTitle,
                  fontSize: 13,
                  isBold: true,
                  color: Colors.black),
              const Divider(),
              CustomSizedTextBox(
                  textContent: 'Q: ${answer.questionTitle}',
                  fontSize: 13,
                  isBold: true,
                  color: Colors.black),
              CustomSizedTextBox(
                  textContent: 'A:  ${answer.answer}',
                  fontSize: 13,
                  isBold: false,
                  color: Colors.black),
            ]),
      ),
    );
  }
}
