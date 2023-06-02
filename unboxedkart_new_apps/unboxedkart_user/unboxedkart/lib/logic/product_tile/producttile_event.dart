part of 'producttile_bloc.dart';

abstract class ProducttileEvent extends Equatable {
  const ProducttileEvent();

  @override
  List<Object> get props => [];
}

class LoadProductTile extends ProducttileEvent {
  final String productId;
  const LoadProductTile({this.productId});
}

class LoadProductSpecs extends ProducttileEvent {
  final String productId;

  const LoadProductSpecs(this.productId);
}

class LoadProductDescription extends ProducttileEvent {
  final String productId;

  const LoadProductDescription(this.productId);
}

class LoadProductReviews extends ProducttileEvent {
  final String productId;

  const LoadProductReviews(this.productId);
}


class LoadProductQandA extends ProducttileEvent {
  final String productId;

  const LoadProductQandA(this.productId);
}


class LoadSimilarProducts extends ProducttileEvent {
  final String productId;

  const LoadSimilarProducts(this.productId);
}

class LoadRelatedProducts extends ProducttileEvent {
  final String productId;

  const LoadRelatedProducts(this.productId);
}

class LoadProductvariants extends ProducttileEvent {
  final String productCode;

  const LoadProductvariants(this.productCode);
}

class LoadSelectedVariant extends ProducttileEvent {
  final GetSelectedVariantDto selectedVariant;

  const LoadSelectedVariant(this.selectedVariant);
}










