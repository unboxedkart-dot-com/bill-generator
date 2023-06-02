import 'package:unboxedkart/data_providers/apis/user/user.api.dart';
import 'package:unboxedkart/models/user/user.model.dart';

class UserRepository {
  UserApi userApi = UserApi();

  Future handleGetUserDetails(String accessToken) async {
    final response = await userApi.getUserDetails(accessToken);

    final UserModel user = UserModel.fromDocument(response);
    return user;
  }

  Future handleUpdateUserDetails(
      String accessToken, String name, String gender) async {
    final response =
        await userApi.updatePaymentDetails(accessToken, name, gender);
    return response;
  }

  Future handleGetPaymentDetails(String accessToken) async {
    final response = await userApi.getPaymentDetails(accessToken);
    print(response);
    final PaymentDetailModel paymentDetails =
        PaymentDetailModel.fromDoc(response);
    print("payment details");
    print(paymentDetails.upiName);
    print(paymentDetails.upiId);
    return paymentDetails;
  }

  Future handleUpdatePaymentDetails(
      String accessToken, String upiName, String upiId) async {
    final response =
        await userApi.updatePaymentDetails(accessToken, upiName, upiId);
    return response;
  }
}
