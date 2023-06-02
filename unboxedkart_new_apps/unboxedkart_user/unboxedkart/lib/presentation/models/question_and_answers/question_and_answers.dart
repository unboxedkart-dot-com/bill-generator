import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/question_and_answer/questionandanswers_bloc.dart';
import 'package:unboxedkart/models/question_and_answers/question_and_answers.model.dart';
import 'package:unboxedkart/presentation/models/question_and_answers/question_and_answers_tile.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/add_answer.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class QuestionAndAnswers extends StatefulWidget {
  final QuestionAndAnswersModel questionAndAnswers;
  final bool hasDividerAtEnd;

  const QuestionAndAnswers(
      {Key key, this.questionAndAnswers, this.hasDividerAtEnd = true})
      : super(key: key);

  @override
  State<QuestionAndAnswers> createState() => _QuestionAndAnswersState();
}

class _QuestionAndAnswersState extends State<QuestionAndAnswers> {
  final LocalRepository _localRepo = LocalRepository();

  bool isPurchased = false;
  bool isAnswered = false;

  checkInPurchasedItems() async {
    bool value = await _localRepo
        .checkForPurchasedItem(widget.questionAndAnswers.productId);
    setState(() {
      isPurchased = value;
    });
  }

  checkIfAnswered() async {
    bool value = await _localRepo.checkForQuestionAnswered(
        widget.questionAndAnswers.questionDetails.questionId);
    setState(() {
      isAnswered = value;
    });
  }

  @override
  void initState() {
    checkInPurchasedItems();
    checkIfAnswered();
    super.initState();

    // checkInPurchasedItems();
  }

  _pushToAddAnswer(Function function) async {
    await Navigator.pushReplacementNamed(context, '/add-answer',
        arguments: AddAnswerPage(
          questionId: widget.questionAndAnswers.questionDetails.questionId,
          productTitle: widget.questionAndAnswers.productDetails.title,
          questionTitle: widget.questionAndAnswers.questionDetails.question,
          productId: widget.questionAndAnswers.productId,
        ));
    // () => function();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => QuestionandanswersBloc(),
          child: BlocBuilder<QuestionandanswersBloc, QuestionandanswersState>(
            builder: (context, state) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedTextBox(
                        textContent:
                            'Q - ${widget.questionAndAnswers.questionDetails.question}',
                        fontSize: 13,
                        isBold: true,
                        color: Colors.black),
                    const SizedBox(
                      height: 5,
                    ),
                    widget.questionAndAnswers.answers.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSizedTextBox(
                                  textContent:
                                      'A - ${widget.questionAndAnswers.answers[0].answer}',
                                  fontSize: 13,
                                  isBold: false,
                                  color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 3),
                                child: CustomSizedTextBox(
                                    textContent:
                                        'Answered by ${widget.questionAndAnswers.answers[0].userName}',
                                    fontSize: 12,
                                    isBold: true,
                                    color: Colors.blueGrey[700]),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 3),
                                child: CustomSizedTextBox(
                                    textContent:
                                        '✓ Certified ${widget.questionAndAnswers.answers[0].userRole} ( ${timeAgo.format(widget.questionAndAnswers.answers[0].timestamp)} )',
                                    fontSize: 12,
                                    isBold: true,
                                    color: Colors.blueGrey[700]),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/q-and-a-tile',
                                            arguments: QuestionAndAnswersTile(
                                                questionAndAnswers:
                                                    widget.questionAndAnswers));
                                      },
                                      child: widget.questionAndAnswers.answers
                                                  .length >
                                              1
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 2),
                                              child: CustomSizedTextBox(
                                                  textContent:
                                                      'Read other answers',
                                                  fontSize: 12,
                                                  isBold: true,
                                                  color: CustomColors.blue),
                                            )
                                          : const SizedBox()),
                                  (isPurchased == true && isAnswered == false)
                                      ? ShowAnswerQuestionWidget(
                                          function: () => _pushToAddAnswer(() =>
                                              BlocProvider.of<
                                                          QuestionandanswersBloc>(
                                                      context)
                                                  .add(
                                                      LoadUserQuestionAndAnswers())),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomSizedTextBox(
                                  textContent: "No answers yet",
                                  fontSize: 13,
                                  isBold: false,
                                ),
                                (isPurchased == true && isAnswered == false)
                                    ? ShowAnswerQuestionWidget(
                                        function: () => _pushToAddAnswer(() =>
                                            BlocProvider.of<
                                                        QuestionandanswersBloc>(
                                                    context)
                                                .add(
                                                    LoadUserQuestionAndAnswers())),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                    widget.hasDividerAtEnd
                        ? const Divider(
                            height: 3,
                          )
                        : const SizedBox()
                  ]);
            },
          ),
        ),
      ),
    );
  }
}

class ShowAnswerQuestionWidget extends StatelessWidget {
  final Function function;

  const ShowAnswerQuestionWidget({Key key, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        child: CustomSizedTextBox(
            textContent: 'Answer this question',
            fontSize: 12,
            isBold: true,
            color: CustomColors.blue),
      ),
    );
  }
}

class CustomQuestionAndAnswers extends StatelessWidget {
  final QuestionAndAnswersModel qAndA;

  const CustomQuestionAndAnswers({Key key, this.qAndA}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product',
                  arguments: ProductTile(productId: qAndA.productId));
            },
            child: CustomSizedTextBox(
              addPadding: true,
              textContent: qAndA.productDetails.title,
              fontSize: 13,
              isBold: true,
            ),
          ),
          QuestionAndAnswers(
            questionAndAnswers: qAndA,
            hasDividerAtEnd: false,
          ),
        ],
      ),
    );
  }
}

