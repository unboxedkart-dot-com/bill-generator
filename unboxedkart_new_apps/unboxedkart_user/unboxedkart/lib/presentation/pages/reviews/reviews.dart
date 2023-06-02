import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/reviews/reviews_bloc.dart';
import 'package:unboxedkart/presentation/models/review/review.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class Reviews extends StatelessWidget {
  const Reviews({Key key}) : super(key: key);

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Reviews",
            enableBack: true,
          )),
      body: BlocProvider(
        create: (context) => ReviewsBloc()..add(LoadUserReviews()),
        child: BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoaded) {
              if (state.reviews.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.reviews.length,
                    itemBuilder: (context, index) {
                      return CustomReview(review: state.reviews[index]);
                    });
              } else {
                return const ShowCustomPage(
                  icon: CupertinoIcons.star_lefthalf_fill,
                  title: "You haven't added any reviews yet. Start adding now.",
                );
              }
            } else {
              return Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: const LoadingSpinnerWidget());
            }
          },
        ),
      ),
    );
  }
}

class _BuildNoReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.star_lefthalf_fill,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'You haven\'t any reviews yet.',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
