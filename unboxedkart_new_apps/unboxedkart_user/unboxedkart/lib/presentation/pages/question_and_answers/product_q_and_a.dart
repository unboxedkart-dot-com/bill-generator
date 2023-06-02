import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/question_and_answer/questionandanswers_bloc.dart';
import 'package:unboxedkart/presentation/models/question_and_answers/question_and_answers.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_no_items.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ProductQandAPage extends StatelessWidget {
  final String productId;

  const ProductQandAPage({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        pageTitle: "Product reviews",
        child: BlocProvider(
          create: (context) =>
              QuestionandanswersBloc()..add(LoadAllProductQandA(productId)),
          child: BlocBuilder<QuestionandanswersBloc, QuestionandanswersState>(
            builder: (context, state) {
              if (state is ProductsQandALoaded) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    state.qAndA.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: state.qAndA.length,
                            itemBuilder: (context, index) {
                              return QuestionAndAnswers(
                                  questionAndAnswers: state.qAndA[index]);
                            })
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CustomNoWidget(
                                title: "No question asked",
                                icon: Icons.question_mark_sharp,
                                iconSize: 40),
                          )
                  ],
                );
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ));
  }
}
