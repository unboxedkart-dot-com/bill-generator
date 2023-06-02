part of 'producttile_bloc.dart';

abstract class ProducttileState extends Equatable {
  const ProducttileState();

  @override
  List<Object> get props => [];
}

class ProductTileLoadingState extends ProducttileState {}

class ProductTileLoadedState extends ProducttileState {
  final ProductModel product;
  final List<ReviewModel> reviews;
  final ReviewsDataModel reviewsData;
  final List<QuestionAndAnswersModel> questionAndAnswers;
  final List<IndividualProductSpecModel> productSpecs;
  final List<ProductModel> relatedProducts;

  const ProductTileLoadedState(
      {this.product,
      this.relatedProducts,
      this.reviews,
      this.reviewsData,
      this.questionAndAnswers,
      this.productSpecs});

  @override
  List<Object> get props =>
      [product, relatedProducts, questionAndAnswers, reviews, reviewsData];
}

class ProductSpecsLoading extends ProducttileState {}

class ProductSpecsLoaded extends ProducttileState {
  final List<IndividualProductSpecModel> productSpecs;

  const ProductSpecsLoaded(this.productSpecs);

  @override
  get props => [productSpecs];
}

class ProductDescriptionLoading extends ProducttileState {}

class ProductDescriptionLoaded extends ProducttileState {
  final List<String> productDescription;

  const ProductDescriptionLoaded(this.productDescription);

  @override
  get props => [productDescription];
}

class ProductQuestionsAndAnswersLoading extends ProducttileState {}

class ProductQuestionsAndAnswersLoaded extends ProducttileState {
  final List<QuestionAndAnswersModel> questionAndAnswers;

  const ProductQuestionsAndAnswersLoaded(this.questionAndAnswers);

  @override
  get props => [questionAndAnswers];
}

class ProductReviewsLoading extends ProducttileState {}

class ProductReviewsLoaded extends ProducttileState {
  final List<ReviewModel> productReviews;
  final ReviewsDataModel reviewsData;

  const ProductReviewsLoaded(this.productReviews, this.reviewsData);

  @override
  get props => [productReviews, reviewsData];
}

class RelatedProductsLoading extends ProducttileState {}

class RelatedProductsLoaded extends ProducttileState {
  final List<ProductModel> relatedProducts;

  const RelatedProductsLoaded(this.relatedProducts);

  @override
  get props => [relatedProducts];
}

class SimilarProductsLoading extends ProducttileState {}

class SimilarProductsLoaded extends ProducttileState {
  final List<ProductModel> similarProducts;

  const SimilarProductsLoaded(this.similarProducts);

  @override
  get props => [similarProducts];
}

class ProductVariantsLoading extends ProducttileState {}

class ProductVariantsLoaded extends ProducttileState {
  final ProductVariantsData variantsData;
 

  const ProductVariantsLoaded({this.variantsData

      });

  @override
  get props => [
    variantsData

      ];
}

class SelecetedProductVariantLoading extends ProducttileState {}

class SelectedProductVariantLoaded extends ProducttileState {
  final String productId;

  const SelectedProductVariantLoaded(this.productId);

  @override
  get props => [productId];
}
