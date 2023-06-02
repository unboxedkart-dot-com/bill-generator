import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/question_and_answer/questionandanswers_bloc.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';

class AskQuestion extends StatelessWidget {
  final String productId;

  AskQuestion({Key key, this.productId}) : super(key: key);

  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionandanswersBloc(),
      child: BlocBuilder<QuestionandanswersBloc, QuestionandanswersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(
                title: "Ask question",
                enableBack: true,
              ),
            ),
            bottomSheet: CustomBottomButton(
              title: "Ask questionj",
              function: () {
                BlocProvider.of<QuestionandanswersBloc>(context, listen: false)
                    .add(AddQuestion(productId, questionController.text));
                Navigator.pop(context);
              },
            ),
            body: ListView(
              children: [
                CustomInputWidget(
                  textController: questionController,
                  placeHolderText: "Enter your question ?",
                  minLines: 3,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
