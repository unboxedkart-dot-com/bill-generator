import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/reviews/reviews_bloc.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class CreateReviewPage extends StatefulWidget {
  int selectedRating;
  final String productId;

  CreateReviewPage({Key key, this.selectedRating = 0, this.productId})
      : super(key: key);

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  TextEditingController reviewTitleController = TextEditingController();
  TextEditingController reviewContentController = TextEditingController();

  _handleSelectRating(int index) {
    setState(() {
      widget.selectedRating = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsBloc(),
      child: BlocBuilder<ReviewsBloc, ReviewsState>(builder: (context, state) {
        if (state is ReviewUpdating) {
          return const LoadingSpinnerWidget();
        } else if (state is ReviewUpdated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        }
        return Scaffold(
          appBar: PreferredSize(
            child: CustomAppBar(
              title: "Review product",
              enableBack: true,
            ),
            preferredSize: const Size.fromHeight(50),
          ),
          bottomSheet: CustomBottomButton(
            title: "Add review",
            function: () {
              BlocProvider.of<ReviewsBloc>(context).add(CreateReview(
                  rating: widget.selectedRating,
                  reviewTitle: reviewTitleController.text,
                  reviewContent: reviewContentController.text,
                  productId: widget.productId));
            },
          ),
          body: ListView(
            children: [
              CustomSizedTextBox(
                paddingWidth: 8,
                addPadding: true,
                textContent: "Select Rating",
                isBold: true,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClickableRatingWidget(
                      rating: 1,
                      selectedRating: widget.selectedRating,
                      function: () {
                        _handleSelectRating(1);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 2,
                      selectedRating: widget.selectedRating,
                      function: () {
                        _handleSelectRating(2);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 3,
                      selectedRating: widget.selectedRating,
                      function: () {
                        _handleSelectRating(3);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 4,
                      selectedRating: widget.selectedRating,
                      function: () {
                        _handleSelectRating(4);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 5,
                      selectedRating: widget.selectedRating,
                      function: () {
                        _handleSelectRating(5);
                      },
                    ),
                  ],
                ),
              ),
              CustomInputWidget(
                placeHolderText: "Title",
                textController: reviewTitleController,
              ),
              CustomInputWidget(
                textController: reviewContentController,
                minLines: 5,
                placeHolderText: "Review content",
              )
            ],
          ),
        );
      }),
    );
  }
}

class ClickableRatingWidget extends StatelessWidget {
  final Function function;
  final int rating;
  final int selectedRating;

  const ClickableRatingWidget(
      {Key key, this.function, this.rating, this.selectedRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: selectedRating >= rating
          ? const Icon(
              CupertinoIcons.star_fill,
              color: CustomColors.blue,
              size: 30,
            )
          : const Icon(
              CupertinoIcons.star,
              color: CustomColors.blue,
              size: 30,
            ),
    );
  }
}
