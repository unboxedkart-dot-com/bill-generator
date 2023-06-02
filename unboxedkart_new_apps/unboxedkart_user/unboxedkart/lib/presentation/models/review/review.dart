import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/reviews/reviews_bloc.dart';
import 'package:unboxedkart/models/reviews/review.model.dart';
import 'package:unboxedkart/presentation/pages/reviews/edit-review.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class Review extends StatelessWidget {
  final ReviewModel review;

  const Review({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingWidget(rating: review.rating.toDouble()),
             
              const SizedBox(width: 5),
              CustomSizedTextBox(
                  textContent: review.reviewTitle,
                  fontSize: 14,
                  isBold: true,
                  color: Colors.black)
            ],
          ),
          const SizedBox(height: 10),
          review.reviewContent != null
              ? CustomSizedTextBox(
                  textContent: review.reviewContent,
                  fontSize: 13,
                  isBold: false,
                  color: Colors.black)
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            child: CustomSizedTextBox(
                textContent: 'Review by ${review.userName}',
                fontSize: 12,
                isBold: true,
                color: Colors.blueGrey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            child: CustomSizedTextBox(
                textContent:
                    '✓ certified buyer (${timeAgo.format(review.timestamp)})',
                fontSize: 12,
                isBold: true,
                color: Colors.blueGrey),
          ),
          // Divider(
          // )
        ],
      ),
    );
  }
}

class CustomReview extends StatefulWidget {
  final ReviewModel review;

  const CustomReview({Key key, this.review}) : super(key: key);

  @override
  State<CustomReview> createState() => _CustomReviewState();
}

class _CustomReviewState extends State<CustomReview> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  _handleShowDeleteItemPopup(Function function) {
    return _customPopup.show(
      title: "Would you like to delete your review.",
      buttonOneText: "No",
      buttonTwoText: "Yes",
      context: context,
      buttonTwoFunction: () {
        // _handleRemoveCartItem();
        function();
        Navigator.pop(context);
      },
    );
  }

  _handleUpdateReview() async {
    await Navigator.pushNamed(context, '/update-review',
        arguments: EditReviewPage(
          selectedRating: widget.review.rating,
          reviewContent: widget.review.reviewContent,
          reviewTitle: widget.review.reviewTitle,
          reviewId: widget.review.reviewId,
        ));
    BlocProvider.of<ReviewsBloc>(context).add(LoadUserReviews());
  }

  _handleDeleteReview() {
    BlocProvider.of<ReviewsBloc>(context)
        .add(DeleteReview(reviewId: widget.review.reviewId));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 2,
                child: Image(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.15,
                  image: NetworkImage(widget.review.imageUrl),
                )),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedTextBox(
                    textContent: widget.review.productTitle,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomSizedTextBox(
                      textContent: widget.review.reviewTitle,
                      fontSize: 14,
                      isBold: true,
                      color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                  _RatingIconWidget(widget.review.rating),
                ],
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          CustomSizedTextBox(
              textContent: widget.review.reviewContent,
              fontSize: 13,
              isBold: false,
              color: Colors.black),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // _handleShowDeleteItemPopup();
                        _handleShowDeleteItemPopup(() => {
                              BlocProvider.of<ReviewsBloc>(context).add(
                                  DeleteReview(
                                      reviewId: widget.review.reviewId))
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete_outline,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomSizedTextBox(
                              textContent: 'Delete', fontSize: 12),
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    // width: 1,
                    thickness: 0.5,
                  ),
                  // const VerticalDivider(
                  //   width: 1,
                  // ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _handleUpdateReview();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesome.edit,
                            color: Colors.grey,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomSizedTextBox(textContent: 'Edit', fontSize: 12)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _RatingIconWidget extends StatelessWidget {
  final int rating;

  const _RatingIconWidget(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        rating > 0
            ? const Icon(
                CupertinoIcons.star_fill,
                color: CustomColors.blue,
                size: 20,
              )
            : const Icon(
                CupertinoIcons.star,
                color: CustomColors.blue,
                size: 20,
              ),
        rating > 1
            ? const Icon(
                CupertinoIcons.star_fill,
                color: CustomColors.blue,
                size: 20,
              )
            : const Icon(
                CupertinoIcons.star,
                color: CustomColors.blue,
                size: 20,
              ),
        rating > 2
            ? const Icon(
                CupertinoIcons.star_fill,
                color: CustomColors.blue,
                size: 20,
              )
            : const Icon(
                CupertinoIcons.star,
                color: CustomColors.blue,
                size: 20,
              ),
        rating > 3
            ? const Icon(
                CupertinoIcons.star_fill,
                color: CustomColors.blue,
                size: 20,
              )
            : const Icon(
                CupertinoIcons.star,
                color: CustomColors.blue,
                size: 20,
              ),
        rating > 4
            ? const Icon(
                CupertinoIcons.star_fill,
                color: CustomColors.blue,
                size: 20,
              )
            : const Icon(
                CupertinoIcons.star,
                color: CustomColors.blue,
                size: 20,
              )
      ],
    );
  }
}






