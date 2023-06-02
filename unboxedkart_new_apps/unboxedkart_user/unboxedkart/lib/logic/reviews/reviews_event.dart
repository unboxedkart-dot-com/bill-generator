part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class LoadUserReviews extends ReviewsEvent {}

class CreateReview extends ReviewsEvent {
  final int rating;
  final String reviewTitle;
  final String reviewContent;
  final String title;
  final String productId;
  final String productTitle;
  final String imageUrl;

  const CreateReview(
      {this.rating,
      this.reviewTitle,
      this.reviewContent,
      this.productId,
      this.productTitle,
      this.imageUrl,
      this.title});
}

class UpdateReview extends ReviewsEvent {
  String reviewId;
  final int rating;
  final String title;
  final String content;

  UpdateReview({this.reviewId, this.rating, this.title, this.content});
}

class DeleteReview extends ReviewsEvent {
  final String reviewId;

  const DeleteReview({this.reviewId});
}

class LoadAllProductReviews extends ReviewsEvent {
  final String productId;

  const LoadAllProductReviews(this.productId);
}
