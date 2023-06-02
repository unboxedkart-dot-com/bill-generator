import 'package:unboxedkart/data_providers/apis/auth/auth_api.dart';
import 'package:unboxedkart/response-models/login_user.response.dart';

class AuthRepository {
  final AuthApi authApi = AuthApi();

  Future handleSendOtp(int phoneNumber) async {
    final response = await authApi.sendOtp(phoneNumber);
    return response;
  }

  Future handleResendOtp(int phoneNumber) async {
    final response = await authApi.resendOtp(phoneNumber);
    return response;
  }

  Future handleLoginUser(int phoneNumber, int otp) async {
    final response = await authApi.loginUser(phoneNumber, otp);

     
     
    final userDetails = UserLoggedInResponse.fromDocument(response);
    return userDetails;
  }

  Future handleValidateOtp(String phoneNumber, String otp) async {
    final response = await authApi.validateOtp(phoneNumber, otp);
    return response;
  }

  Future handleCreateUser(
      {int phoneNumber,
      int otp,
      String emailAddress,
      String name,
      String gender,
      String deviceId}) async {
    final response = await authApi.createUser(
        phoneNumber: phoneNumber,
        otp: otp,
        emailAddress: emailAddress,
        name: name,
        gender: gender,
        deviceId: deviceId);
    final UserLoggedInResponse userDetails =
        UserLoggedInResponse.fromDocument(response);

    return userDetails;
  }

  Future handleGetUserData(String accessToken) async {
    final response = await authApi.getUserData(accessToken);
    return response;
  }
}
