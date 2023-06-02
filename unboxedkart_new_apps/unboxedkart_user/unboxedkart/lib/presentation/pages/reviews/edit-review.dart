import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/reviews/reviews_bloc.dart';
import 'package:unboxedkart/presentation/pages/reviews/create-review.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_input_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class EditReviewPage extends StatefulWidget {
  final int selectedRating;
  final String reviewId;
  final String reviewTitle;
  final String reviewContent;

  const EditReviewPage(
      {Key key,
      this.selectedRating,
      this.reviewContent,
      this.reviewId,
      this.reviewTitle})
      : super(key: key);

  @override
   
  State<EditReviewPage> createState() => _EditReviewPageState(
      selectedRating: selectedRating,
      reviewId: reviewId,
      reviewTitle: reviewTitle,
      reviewContent: reviewContent);
}

class _EditReviewPageState extends State<EditReviewPage> {
  int selectedRating = 0;
  final String reviewId;
  final String reviewTitle;
  final String reviewContent;

  _EditReviewPageState(
      {this.selectedRating,
      this.reviewContent,
      this.reviewTitle,
      this.reviewId});

  TextEditingController reviewTitleController = TextEditingController();
  TextEditingController reviewContentController = TextEditingController();

  _handleSelectRating(int index) {
    setState(() {
      selectedRating = index;
    });
  }

  @override
  void initState() {
    reviewTitleController.text = reviewTitle;
    reviewContentController.text = reviewContent;
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
            title: "Update review",
            function: () {
              BlocProvider.of<ReviewsBloc>(context).add(UpdateReview(
                  rating: selectedRating,
                  title: reviewTitleController.text,
                  content: reviewContentController.text,
                  reviewId: reviewId));
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
                      selectedRating: selectedRating,
                      function: () {
                        _handleSelectRating(1);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 2,
                      selectedRating: selectedRating,
                      function: () {
                        _handleSelectRating(2);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 3,
                      selectedRating: selectedRating,
                      function: () {
                        _handleSelectRating(3);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 4,
                      selectedRating: selectedRating,
                      function: () {
                        _handleSelectRating(4);
                      },
                    ),
                    ClickableRatingWidget(
                      rating: 5,
                      selectedRating: selectedRating,
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

 
 
 
 

 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
