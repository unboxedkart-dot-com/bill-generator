part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends CategoryEvent {
  final String categoryName;

  const LoadData(this.categoryName);
}

class LoadCategoryCarouselItems extends CategoryEvent {
  final String category;

  const LoadCategoryCarouselItems(this.category);

}
