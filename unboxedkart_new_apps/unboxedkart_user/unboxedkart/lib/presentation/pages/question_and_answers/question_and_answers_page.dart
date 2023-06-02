import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/question_and_answer/questionandanswers_bloc.dart';
import 'package:unboxedkart/models/question_and_answers/answer.model.dart';
import 'package:unboxedkart/presentation/models/question_and_answers/only_answer.dart';
import 'package:unboxedkart/presentation/models/question_and_answers/question_and_answers.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class QuestionAndAnswersPage extends StatelessWidget {
  const QuestionAndAnswersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.blue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 18,
            ),
          ),
          title: CustomSizedTextBox(
            textContent: "My Questions & Answers",
            color: Colors.white,
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: CustomSizedTextBox(
                  color: Colors.white,
                  textContent: "Questions",
                  fontSize: 13,
                ),
              ),
              Tab(
                child: CustomSizedTextBox(
                  color: Colors.white,
                  textContent: "Answers",
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
        body: BlocProvider(
          create: (context) =>
              QuestionandanswersBloc()..add(LoadUserQuestionAndAnswers()),
          child: BlocBuilder<QuestionandanswersBloc, QuestionandanswersState>(
            builder: (context, state) {
              if (state is QuestionAndAnswersLoaded) {
                return TabBarView(children: [
                  state.questionAndAnswers.isNotEmpty ||
                          state.questionsFeed.isNotEmpty
                      ? ListView(
                          children: [
                            state.questionAndAnswers.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: state.questionAndAnswers.length,
                                    itemBuilder: (context, index) {
                                      return CustomQuestionAndAnswers(
                                          qAndA:
                                              state.questionAndAnswers[index]);
                                    })
                                : const ShowCustomPage(
                                    icon: FontAwesome.question,
                                    iconSize: 90,
                                    paddingWidth: 20,
                                    title:
                                        "You haven't asked any questions yet. You can always ask a question, if you need help while shopping.",
                                  ),
                            state.questionsFeed.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomSizedTextBox(
                                        addPadding: true,
                                        textContent:
                                            "Questions you might answer",
                                        fontSize: 14,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: state.questionsFeed.length,
                                          itemBuilder: (context, index) {
                                            return CustomQuestionAndAnswers(
                                                qAndA:
                                                    state.questionsFeed[index]);
                                          }),
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        )
                      : const ShowCustomPage(
                          icon: FontAwesome.question,
                          title:
                              "You haven't asked any questions yet. You can always ask a question, if you need help while shopping.",
                        ),
                  state.answers.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.answers.length,
                          itemBuilder: (context, index) {
                            return OnlyAnswer(answer: state.answers[index]);
                          })
                      : const ShowCustomPage(
                          icon: FontAwesome.comments_o,
                          title:
                              "You haven't answered any questions, You can always help others by aftering questions.",
                        )
                ]);
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _ShowUserAnswer extends StatelessWidget {
  final List<AnswerModel> answers;

  const _ShowUserAnswer({Key key, this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: answers.length,
        itemBuilder: (context, index) {
          return const Text("helllo");
        });
  }
}
