part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewModel> reviews;

  const ReviewsLoaded({this.reviews});

  @override
  get props => [reviews];
}

class ReviewUpdating extends ReviewsState {}

class ReviewUpdated extends ReviewsState {}

class AllProductReviewsLoading extends ReviewsState {}

class AllProductReviewsLoaded extends ReviewsState {
  final List<ReviewModel> reviews;
  final ReviewsDataModel reviewsData;

  const AllProductReviewsLoaded(this.reviews, this.reviewsData);

  @override
  get props => [reviews, reviewsData];
}
