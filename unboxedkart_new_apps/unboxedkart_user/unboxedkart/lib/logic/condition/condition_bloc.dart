
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:unboxedkart/data_providers/repositories/carousel-items.repositoy.dart';
import 'package:unboxedkart/data_providers/repositories/condition.respository.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';
import 'package:unboxedkart/models/category/category.model.dart';

part 'condition_event.dart';
part 'condition_state.dart';

class ConditionBloc extends Bloc<ConditionEvent, ConditionState> {
  final ConditionRepository _conditionRepository = ConditionRepository();
  final CarouselItemsRepository _carouselRepo = CarouselItemsRepository();
  ConditionBloc() : super(ConditionInitial()) {
    on<LoadData>(_onLoadData);
    on<LoadConditionCarouselItems>(_onLoadConditionCarouselItems);
  }

  void _onLoadData(LoadData event, Emitter<ConditionState> emit) async {
    emit(ConditionPageLoadingState());

    //loading local json file
    var jsonData = await rootBundle.loadString('assets/json/condition.json');

    //decoding json file
    var brandJson = json.decode(jsonData);

    final List<CategoryModel> categoriesByCondition =
        _conditionRepository.handleGetCategoriesByCondition(
            brandJson[event.conditionName]['categories']);

    // getting conditionsByBrand from local json
    final List<BrandModel> brandsByCondition = _conditionRepository
        .handleGetBrandsByCondition(brandJson[event.conditionName]['brands']);

    emit(ConditionPageLoadedState(
      categories: categoriesByCondition,
      brands: brandsByCondition,
      // featuredProducts: featuredProducts,
      // bestSellingProducts: bestSellers
    ));
}

  void _onLoadConditionCarouselItems(
      LoadConditionCarouselItems event, Emitter<ConditionState> emit) async {
    emit(ConditionCarouselItemsLoading());
    final response = await _carouselRepo
        .handleGetCarouselItems('/Condition/${event.condition}');
    emit(ConditionCarouselItemsLoaded(response));
  }
}
