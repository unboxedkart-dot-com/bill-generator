part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandPageLoadingState extends BrandState {}

class BrandPageLoadedState extends BrandState {
  final List<CategoryModel> categories;
  final List<ConditionModel> conditions;

  const BrandPageLoadedState({
    this.categories,
    this.conditions,
  });

  @override
  List<Object> get props => [
        categories, conditions,
      ];
}

class BrandCarouselItemsLoading extends BrandState {}

class BrandCarouselItemsLoaded extends BrandState {
  final List<CarouselItemModel> carouselItems;

  const BrandCarouselItemsLoaded(this.carouselItems);

  @override
  List<Object> get props => [
        carouselItems
      ];
}
