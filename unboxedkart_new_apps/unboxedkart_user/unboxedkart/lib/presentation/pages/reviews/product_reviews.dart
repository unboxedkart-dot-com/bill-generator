import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/reviews/reviews_bloc.dart';
import 'package:unboxedkart/presentation/models/review/review.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ProductReviewsPage extends StatelessWidget {
   
   
  final String productId;

  const ProductReviewsPage({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        pageTitle: "Product reviews",
        child: BlocProvider(
          create: (context) =>
              ReviewsBloc()..add(LoadAllProductReviews(productId)),
          child: BlocBuilder<ReviewsBloc, ReviewsState>(
            builder: (context, state) {
              if (state is AllProductReviewsLoaded) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    AverageRatingWidget(
                      reviewsData: state.reviewsData,
                    ),
                    const Divider(),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.reviews.length,
                        itemBuilder: (context, index) {
                          return Review(review: state.reviews[index]);
                        }),
                     
                    const Divider(
                      height: 1,
                    ),
                    const Divider(
                      height: 3,
                    ),
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
