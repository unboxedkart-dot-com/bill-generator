import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class UserApi {
  ApiCalls apiCalls = ApiCalls();
  Future getUserDetails(String accessToken) async {
    const url = "https://server.unboxedkart.com/user-details";
    final response = await apiCalls.get(url: url, accessToken: accessToken);

    return response;
  }

  Future updateUserDetails(
      String accessToken, String name, String gender) async {
    const url = "https://server.unboxedkart.com/user-details/update";
    final updateBody = {"name": name, "gender": gender};
    final response = await apiCalls.update(
        url: url, accessToken: accessToken, updateBody: updateBody);
    return response;
  }

  Future getPaymentDetails(String accessToken) async {
    const url = "https://server.unboxedkart.com/user-details/payment-details";
    final response = await apiCalls.get(url: url, accessToken: accessToken);
    return response;
  }

  Future updatePaymentDetails(
      String accessToken, String upiName, String upiId) async {
    const url = "https://server.unboxedkart.com/user-details/payment-details";
    final updateBody = {"upiName": upiName, "upiId": upiId};
    final response = await apiCalls.update(
        url: url, accessToken: accessToken, updateBody: updateBody);
    return response;
  }
}
