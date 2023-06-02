import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentsApi {
  Future createPayment() async {

  }

  Future getSearchedProducts(String title, String category, String brand,
      String condition, int pageNumber) async {
    final String url =
        "https://server.unboxedkart.com/search?title=$title&category=$category&brand=$brand&condition=$condition&pageNumber=$pageNumber";
    http.Response response = await http.get(Uri.parse(url));
    final products = json.decode(response.body);
    return products;
  }

}
