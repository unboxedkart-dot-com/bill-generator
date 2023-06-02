part of 'condition_bloc.dart';

abstract class ConditionState extends Equatable {
  const ConditionState();

  @override
  List<Object> get props => [];
}

class ConditionInitial extends ConditionState {}

class ConditionPageLoadingState extends ConditionState {}

class ConditionPageLoadedState extends ConditionState {
  final List<CategoryModel> categories;
  final List<BrandModel> brands;

  const ConditionPageLoadedState(
      {this.categories,
      this.brands,
      });

  @override
  List<Object> get props =>
      [categories, brands, 
      ];
}

class ConditionCarouselItemsLoading extends ConditionState {}

class ConditionCarouselItemsLoaded extends ConditionState {
  final List<CarouselItemModel> carouselItems;

  const ConditionCarouselItemsLoaded(this.carouselItems);

  @override
  List<Object> get props => [carouselItems];
}

