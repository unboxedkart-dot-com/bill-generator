import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class CouponsApi {
  ApiCalls apiCalls = ApiCalls();

  Future validateCoupon(String accessToken, String couponCode) async {
    final url =
        "https://server.unboxedkart.com/coupons/validate?couponCode=$couponCode";
    final response = await apiCalls.get(url: url, accessToken: accessToken);

    return response;
  }

  Future getPersonalCoupon(String accessToken) async {
    const url =
        'https://server.unboxedkart.com/coupons/referral-coupon';
    final response = await apiCalls.get(url: url, accessToken: accessToken);

    return response;
  }

  Future getCoupons() async {
    const url = 'https://server.unboxedkart.com/coupons';
    final response = await apiCalls.get(url: url);

    return response;
  }
}
