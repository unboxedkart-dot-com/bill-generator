import 'package:unboxedkart/data_providers/apis/faq/faq.api.dart';
import 'package:unboxedkart/models/faq/faq.model.dart';

class FaqsRepository {
  final FaqsApi faqsApi = FaqsApi();

  Future<List<FaqModel>> handleGetFaqs() async {
    final response = await faqsApi.getFaqs();
    final List<FaqModel> faqs =
        response.map<FaqModel>((doc) => FaqModel.fromDoc(doc)).toList();
    return faqs;
  }
}
