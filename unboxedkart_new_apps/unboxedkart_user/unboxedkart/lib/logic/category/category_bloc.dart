import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:unboxedkart/data_providers/repositories/carousel-items.repositoy.dart';
import 'package:unboxedkart/data_providers/repositories/category.repository.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'dart:convert';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final CarouselItemsRepository _carouselRepo = CarouselItemsRepository();
  CategoryBloc() : super(CategoryPageLoadingState()) {
    on<LoadData>(_onLoadData);
    on<LoadCategoryCarouselItems>(_onLoadCategoryCarouselItems);
  }

  void _onLoadData(LoadData event, Emitter<CategoryState> emit) async {
    emit(CategoryPageLoadingState());

    var jsonData = await rootBundle.loadString('assets/json/category.json');

    //decoding json file
    var categoryJson = json.decode(jsonData);

    // getting brandsByCategory from local json

    final List<BrandModel> brands = _categoryRepository
        .handleGetBrandsByCategory(categoryJson[event.categoryName]['brands']);

    // getting conditionsByCategory from local json
    final List<ConditionModel> conditions =
        _categoryRepository.handleGetConditionsByCategory(
            categoryJson[event.categoryName]['conditions']);
    emit(CategoryPageLoadedState(
      brands: brands,
      conditions: conditions,
    ));
  }

  void _onLoadCategoryCarouselItems(
      LoadCategoryCarouselItems event, Emitter<CategoryState> emit) async {
    emit(CategoryCarouselItemsLoading());
    final response = await _carouselRepo
        .handleGetCarouselItems('${event.category}');
    emit(CategoryCarouselItemsLoaded(response));
  }
}
