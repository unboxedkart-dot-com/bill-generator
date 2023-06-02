import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:unboxedkart/models/question_and_answers/question_and_answers.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class QuestionAndAnswersTile extends StatelessWidget {
  final QuestionAndAnswersModel questionAndAnswers;

  const QuestionAndAnswersTile({Key key, this.questionAndAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          enableBack: true,
          title: "Q & A",
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedTextBox(
                paddingWidth: 10,
                addPadding: true,
                textContent:
                    'Q: ${questionAndAnswers.questionDetails.question}',
                fontSize: 14,
                isBold: true,
                color: Colors.black),
            // const SizedBox(
            //   height: 10,
            // ),
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: questionAndAnswers.answers.length,
                itemBuilder: (context, index) {
                  return ElevatedContainer(
                    elevation: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomSizedTextBox(
                              textContent:
                                  'A:  ${questionAndAnswers.answers[index].answer}',
                              fontSize: 13,
                              isBold: false,
                              color: Colors.black),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            child: CustomSizedTextBox(
                                textContent:
                                    'Answered by ${questionAndAnswers.answers[index].userName}',
                                fontSize: 11,
                                isBold: true,
                                color: Colors.blueGrey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            child: CustomSizedTextBox(
                                textContent:
                                    '✓ Certified ${questionAndAnswers.answers[index].userRole} ( ${timeAgo.format(questionAndAnswers.answers[0].timestamp)} )',
                                fontSize: 11,
                                isBold: true,
                                color: Colors.blueGrey),
                          ),
                        ]),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
