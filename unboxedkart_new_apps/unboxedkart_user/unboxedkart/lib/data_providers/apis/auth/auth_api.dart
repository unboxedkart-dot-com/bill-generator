import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class AuthApi {
  ApiCalls apiCalls = ApiCalls();

  Future sendOtp(int phoneNumber) async {
    final url =
        "https://server.unboxedkart.com/auth/send-otp?phoneNumber=$phoneNumber";
    final response = apiCalls.get(url: url);
    return response;
  }

  Future resendOtp(int phoneNumber) async {
    final url =
        "https://server.unboxedkart.com/auth/resend-otp?phoneNumber=$phoneNumber";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future loginUser(int phoneNumber, int otp) async {
    const url = "https://server.unboxedkart.com/auth/login";
    final postBody = {
      "phoneNumber": phoneNumber,
      "otp": otp,
    };
    final response = await apiCalls.post(url: url, postBody: postBody);
    return response;
  }

  Future validateOtp(String phoneNumber, String otp) async {
    final url =
        "https://server.unboxedkart.com/auth/validate-otp?phoneNumber=$phoneNumber&otp=$otp";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future createUser({
    int phoneNumber,
    int otp,
    String deviceId,
    String gender,
    String emailAddress,
    String name,
  }) async {
    const url = "https://server.unboxedkart.com/auth/signup";
    final postBody = {
      "phoneNumber": phoneNumber,
      "otp": otp,
      "name": name,
      "emailId": emailAddress,
      "gender": gender,
    };

    final response = await apiCalls.post(url: url, postBody: postBody);

    return response;
  }

  Future getUserData(String accessToken) async {
    const url = "https://server.unboxedkart.com/user-details/user-data";
    final response = await apiCalls.get(url: url, accessToken: accessToken);

    return response;
  }
}
