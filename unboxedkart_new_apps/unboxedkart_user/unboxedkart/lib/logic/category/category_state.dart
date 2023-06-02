part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryPageLoadingState extends CategoryState {}

class CategoryPageLoadedState extends CategoryState {
  final List<BrandModel> brands;
  final List<ConditionModel> conditions;

  const CategoryPageLoadedState({
    this.brands,
    this.conditions,
  });

  @override
  List<Object> get props => [
        brands, conditions,
        //  featuredProducts, bestSellingProducts
      ];
}

class CategoryCarouselItemsLoading extends CategoryState {}

class CategoryCarouselItemsLoaded extends CategoryState {
  final List<CarouselItemModel> carouselItems;

  const CategoryCarouselItemsLoaded(this.carouselItems);

  @override
  List<Object> get props => [carouselItems];
}
