import 'package:unboxedkart/data_providers/apis/carousel_items/carousel_items.api.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';

class CarouselItemsRepository {
  final CarouselItemsApi carouselItemsApi = CarouselItemsApi();

  Future<List<CarouselItemModel>> handleGetCarouselItems(
      String placement) async {
    final response = await carouselItemsApi.getCaourelItems(placement);
    final List<CarouselItemModel> carouselItems = response
        .map<CarouselItemModel>((product) => CarouselItemModel.fromDoc(product))
        .toList();
    return carouselItems;
  }
}
