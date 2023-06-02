import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/products.repository.dart';
import 'package:unboxedkart/data_providers/repositories/questions_and_answers.repository.dart';
import 'package:unboxedkart/data_providers/repositories/reviews.repository.dart';
import 'package:unboxedkart/dtos/get-selected-variant.dto.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/models/product_details/product-variants-data.dart';
import 'package:unboxedkart/models/product_details/product_details.model.dart';
import 'package:unboxedkart/models/question_and_answers/question_and_answers.model.dart';
import 'package:unboxedkart/models/reviews/reviews_data.model.dart';

import '../../models/reviews/review.model.dart';

part 'producttile_event.dart';
part 'producttile_state.dart';

class ProducttileBloc extends Bloc<ProducttileEvent, ProducttileState> {
  final ReviewsRepository _reviewsRepo = ReviewsRepository();
  final QuestionsAndAnswersRepository _qAndARepository =
      QuestionsAndAnswersRepository();
  final LocalRepository _localRepo = LocalRepository();
  final ProductsRepository productsRepository = ProductsRepository();
// ProductsRepository of
  ProducttileBloc() : super(ProductTileLoadingState()) {
    on<LoadProductTile>(_onLoadProductTile);
    on<LoadProductSpecs>(_onLoadProductSpecs);
    on<LoadProductDescription>(_onLoadProductDescription);
    on<LoadProductReviews>(_onLoadProductReviews);
    on<LoadProductQandA>(_onLoadProductQandA);
    on<LoadSimilarProducts>(_onLoadSimilarProducts);
    on<LoadRelatedProducts>(_onLoadRelatedProducts);
    on<LoadProductvariants>(_onLoadProductVariants);
    on<LoadSelectedVariant>(_onLoadSelectedProductVariant);
  }

  _onLoadProductTile(
      LoadProductTile event, Emitter<ProducttileState> emit) async {
    emit(ProductTileLoadingState());
    final String accessToken = await _localRepo.getAccessToken();
    final productDetails =
        await productsRepository.handleGetProduct(event.productId, accessToken: accessToken);
    emit(ProductTileLoadedState(
      product: productDetails['product'],
    ));
  }

  void _onLoadProductSpecs(
      LoadProductSpecs event, Emitter<ProducttileState> emit) async {
    emit(ProductSpecsLoading());
    final response =
        await productsRepository.handleGetProductSpecs(event.productId);
    emit(ProductSpecsLoaded(response));
  }

  void _onLoadProductDescription(
      LoadProductDescription event, Emitter<ProducttileState> emit) async {
    emit(ProductDescriptionLoading());
    final response =
        await productsRepository.handleGetProductDescription(event.productId);
    emit(ProductDescriptionLoaded(response));
  }

  void _onLoadProductReviews(
      LoadProductReviews event, Emitter<ProducttileState> emit) async {
    emit(ProductReviewsLoading());
    final response =
        await _reviewsRepo.handleGetProductReviews(event.productId);
    emit(ProductReviewsLoaded(response['reviews'], response['reviewsData']));
  }

  void _onLoadProductQandA(
      LoadProductQandA event, Emitter<ProducttileState> emit) async {
    emit(ProductQuestionsAndAnswersLoading());
    final response = await _qAndARepository
        .handleGetProductQuestionAndAnswers(event.productId);
    emit(ProductQuestionsAndAnswersLoaded(response));
  }

  void _onLoadSimilarProducts(
      LoadSimilarProducts event, Emitter<ProducttileState> emit) async {
    emit(SimilarProductsLoading());
    final response =
        await productsRepository.handleGetSimilarProducts(event.productId);
    emit(SimilarProductsLoaded(response));
  }

  void _onLoadRelatedProducts(
      LoadRelatedProducts event, Emitter<ProducttileState> emit) async {
    emit(RelatedProductsLoading());
    final response =
        await productsRepository.handleGetRelatedProducts(event.productId);
    emit(RelatedProductsLoaded(response));
  }

  void _onLoadProductVariants(
      LoadProductvariants event, Emitter<ProducttileState> emit) async {
    emit(ProductVariantsLoading());
    final ProductVariantsData variantsData =
        await productsRepository.handleGetProductVariants(event.productCode);
    emit(ProductVariantsLoaded(variantsData: variantsData));
  }

  void _onLoadSelectedProductVariant(
      LoadSelectedVariant event, Emitter<ProducttileState> emit) async {
    emit(SelecetedProductVariantLoading());
    final response = await productsRepository
        .handleGetSelectedProductVariant(event.selectedVariant);
    emit(SelectedProductVariantLoaded(response));
  }
}
