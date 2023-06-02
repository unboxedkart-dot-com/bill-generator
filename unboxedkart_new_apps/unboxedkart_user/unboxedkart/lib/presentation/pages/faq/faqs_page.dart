import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/faqs/faqs_bloc.dart';
import 'package:unboxedkart/presentation/models/faq/faq.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        pageTitle: "FAQ's",
        child: BlocProvider(
          create: (context) => FaqsBloc()..add(LoadFaqs()),
          child: BlocBuilder<FaqsBloc, FaqsState>(
            builder: (context, state) {
              if (state is FaqsLoading) {
                return const LoadingSpinnerWidget();
              } else if (state is FaqsLoaded) {
                if (state.faqs.isNotEmpty) {
                  return ListView.builder(
                      itemCount: state.faqs.length,
                      itemBuilder: (context, index) {
                        return Faq(faq: state.faqs[index]);
                      });
                } else {
                  return Center(child: _BuildNoFaqs());
                }
              } else {
                return const Text("Something went wrong");
              }
            },
          ),
        ));
  }
}

class _BuildNoFaqs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.question_circle,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'No Faqs',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
