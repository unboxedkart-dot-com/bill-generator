import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/question_and_answer/questionandanswers_bloc.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class AddAnswerPage extends StatefulWidget {
  final String questionId;
  final String questionTitle;
  final String productTitle;
  final String productId;

  const AddAnswerPage(
      {Key key,
      this.questionId,
      this.questionTitle,
      this.productTitle,
      this.productId})
      : super(key: key);

  @override
  State<AddAnswerPage> createState() => _AddAnswerPageState();
}

class _AddAnswerPageState extends State<AddAnswerPage> {
  TextEditingController answerController = TextEditingController();

  final CustomAlertPopup _customPopup = CustomAlertPopup();

  showCustomPopup(String title) async {
    return _customPopup.show(
      title: title,
      buttonOneText: "Okay",
      buttonTwoText: "Dismiss",
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "Add an answer",
      bottomButton: CustomBottomButton(
        title: "Add answer",
        function: () {
          if (answerController.text.isNotEmpty) {
            Navigator.pop(context);
            BlocProvider.of<QuestionandanswersBloc>(context).add(AddAnswer(
              questionTitle: widget.questionTitle,
              answer: answerController.text,
              productTitle: widget.productTitle,
              productId: widget.productId,
              questionId: widget.questionId,
            ));
          } else {
            return showCustomPopup("Answer field cannot be empty");
          }
        },
      ),
      child: ListView(
        children: [
          CustomSizedTextBox(
            textContent: widget.questionTitle,
            addPadding: true,
          ),
          CustomInputWidget(
            textController: answerController,
            placeHolderText: "Your answer..",
            minLines: 3,
          )
        ],
      ),
    );

     
     
     
     
     
     
     
     
     
     
     

     
     
     
  }
}
