import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class CarouselItemsApi {
  ApiCalls apiCalls = ApiCalls();

  Future getCaourelItems(String placement) async {
    print('getting carousel items');
    final url = "https://server.unboxedkart.com/carousel-items?placement=$placement";
    print(url);
    final response = await apiCalls.get(url: url);

    return response;
  }
}
