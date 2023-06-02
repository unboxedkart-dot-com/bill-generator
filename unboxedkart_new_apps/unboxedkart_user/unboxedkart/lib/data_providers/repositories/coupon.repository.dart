import 'package:unboxedkart/data_providers/apis/coupon/coupon.api.dart';
import 'package:unboxedkart/models/coupon/coupon.model.dart';


class CouponRespository {
  CouponsApi couponsApi = CouponsApi();

  handleValidateCoupon(
      String accessToken, String couponCode) async {
    
    final response =
        await couponsApi.validateCoupon(accessToken, couponCode);
    
    
    return response;
  }

  handleGetPersonalCoupon(String accessToken) async {
    final response = await couponsApi.getPersonalCoupon(accessToken);
    final CouponModel coupon = CouponModel.fromDocument(response);
    return coupon;
  }

  handleGetCoupons() async {
    final response = await couponsApi.getCoupons();
    List<CouponModel> coupons = response
        .map<CouponModel>((doc) => CouponModel.fromDocument(doc))
        .toList();
    return coupons;
  }
}
