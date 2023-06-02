import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:unboxedkart/data_providers/repositories/brand.repository.dart';
import 'package:unboxedkart/data_providers/repositories/carousel-items.repositoy.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';
import 'package:unboxedkart/models/category/category.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/carousel_item.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository _brandRepository;
  final CarouselItemsRepository _carouselRepo = CarouselItemsRepository();
  // BrandRepository _brandRepository = BrandRepository();
  BrandBloc(this._brandRepository) : super(BrandPageLoadingState()) {
    on<LoadData>(_onLoadData);
    on<LoadBrandCarouselItems>(_onLoadBrandCarouselItems);
  }

  void _onLoadData(LoadData event, Emitter<BrandState> emit) async {
    emit(BrandPageLoadingState());

    //loading local json file
    var jsonData = await rootBundle.loadString('assets/json/brand.json');

    //decoding json file
    var brandJson = json.decode(jsonData);

    // getting categoriesByBrand from local json
    final List<CategoryModel> categoriesByBrand = _brandRepository
        .handleGetCategoriesByBrand(brandJson[event.brandName]['categories']);

    // getting conditionsByBrand from local json
    final List<ConditionModel> conditionsByBrand = _brandRepository
        .handleGetConditionsByBrand(brandJson[event.brandName]['conditions']);
    emit(BrandPageLoadedState(
      categories: categoriesByBrand,
      conditions: conditionsByBrand,

    ));
  }

  void _onLoadCategoriesByBrand() {}

  void _onLoadBrandsByBrand() {}

  void _onLoadFeaturedProductsByBrand() async {}

  void _onLoadBestSellingProductsByBrand() async {}

  void _onLoadBrandCarouselItems(
      LoadBrandCarouselItems event, Emitter<BrandState> emit) async {
    emit(BrandCarouselItemsLoading());
    final response =
        await _carouselRepo.handleGetCarouselItems('/brand/${event.brand}');
    // emit(BrandCarouselItemsLoaded(response));
  }
}
