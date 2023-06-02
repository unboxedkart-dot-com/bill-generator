import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/reviews.repository.dart';
import 'package:unboxedkart/models/reviews/review.model.dart';
import 'package:unboxedkart/models/reviews/reviews_data.model.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewsRepository _reviewsRepo = ReviewsRepository();
  final LocalRepository _localRepo = LocalRepository();
  List<ReviewModel> reviews = [];

  ReviewsBloc() : super(ReviewsInitial()) {
    on<LoadUserReviews>(_onLoadUserReviews);
    on<CreateReview>(_onCreateReview);
    on<UpdateReview>(_onUpdateReview);
    on<DeleteReview>(_onDeleteReview);
    on<LoadAllProductReviews>(_onLoadAllProductReviews);
  }

  void _onLoadUserReviews(
      LoadUserReviews event, Emitter<ReviewsState> emit) async {
    emit(ReviewsLoading());
    final String accessToken = await _localRepo.getAccessToken();
    final List<ReviewModel> reviews =
        await _reviewsRepo.handleGetUserReviews(accessToken);
    this.reviews = reviews;
    emit(ReviewsLoaded(reviews: reviews));
  }

  void _onCreateReview(CreateReview event, Emitter<ReviewsState> emit) async {
    emit(ReviewUpdating());
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _reviewsRepo.handleCreateReview(
        accessToken: accessToken,
        productId: event.productId,
        productTitle: event.productTitle,
        imageUrl: event.imageUrl,
        rating: event.rating,
        reviewTitle: event.reviewTitle,
        reviewContent: event.reviewContent);
    emit(ReviewUpdated());
  }

  void _onUpdateReview(UpdateReview event, Emitter<ReviewsState> emit) async {
    emit(ReviewUpdating());
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _reviewsRepo.handleUpdateReview(
        accessToken: accessToken,
        reviewId: event.reviewId,
        reviewTitle: event.title,
        reviewContent: event.content,
        rating: event.rating);
    emit(ReviewUpdated());
  }

  void _onDeleteReview(DeleteReview event, Emitter<ReviewsState> emit) async {
    emit(ReviewsLoading());
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _reviewsRepo.handleDeleteReview(
        accessToken: accessToken, reviewId: event.reviewId);
    int deletedReviewIndex =
        reviews.indexWhere((element) => element.reviewId == event.reviewId);
    
    
    
    reviews.removeAt(deletedReviewIndex);
    
    emit(ReviewsLoaded(reviews: reviews));
  }

  void _onLoadAllProductReviews(
      LoadAllProductReviews event, Emitter<ReviewsState> emit) async {
    emit(AllProductReviewsLoading());
    final response =
        await _reviewsRepo.handleGetProductReviews(event.productId);
    emit(AllProductReviewsLoaded(response['reviews'], response['reviewsData']));
  }
}
