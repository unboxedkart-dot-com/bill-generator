import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class FaqsApi {
  ApiCalls apiCalls = ApiCalls();

  Future getFaqs() async {
    
    const url = "https://server.unboxedkart.com/faqs";
    final response = await apiCalls.get(url: url);
    
    
    return response;
  }
}
