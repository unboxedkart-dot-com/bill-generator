import 'package:http/http.dart' as http;
import 'package:unboxedkart/data_providers/apis/api_calls.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

class OrderSummaryApi {
  ApiCalls apiCall = ApiCalls();

  Future addCouponCode(String accessToken, String couponCode) async {
    const url = "https://server.unboxedkart.com/order-summary/update/coupon";
    final updateBody = {
      "couponCode": couponCode,
    };
    final response = await apiCall.update(
        updateBody: updateBody, accessToken: accessToken, url: url);
    return response;
  }

  Future updateProductCount(String accessToken, String productId,
      int updatedCount, int productIndex) async {
    const url = "https://server.unboxedkart.com/order-summary/update";
    final updateBody = {
      "productId": productId,
      "updatedCount": updatedCount,
      "productIndex": productIndex
    };
    final response = await apiCall.update(
        updateBody: updateBody, accessToken: accessToken, url: url);
    return response;
  }

  Future addDeliveryAddress({String accessToken, AddressModel address}) async {
    const url =
        "https://server.unboxedkart.com/order-summary/update/address-details";
    final updateBody = {
      "name": address.name,
      "doorNo": address.doorNo,
      "street": address.street,
      "cityName": address.cityName,
      "landmark": address.landmark,
      "stateName": address.stateName,
      "pinCode": address.pinCode,
      "addressType": address.addressType,
      "phoneNumber": address.phoneNumber,
      "alternatePhoneNumber": address.alternatePhoneNumber
    };

    final response = await apiCall.update(
        url: url, updateBody: updateBody, accessToken: accessToken);
  }

  Future addStoreLocationDetails(
      {String accessToken,
      StoreLocationModel storeLocation,
      DateTime pickUpTimeStart,
      DateTime pickUpTimeEnd,
      DateTime pickUpDate,
      String pickUpTimeInString,
      String pickUpDateInString}) async {
    const url =
        "https://server.unboxedkart.com/order-summary/update/store-details";
    final updateBody = {
      "storeName": storeLocation.storeName,
      "streetName": storeLocation.streetName,
      "cityName": storeLocation.cityName,
      "pinCode": storeLocation.pinCode,
      "directionsUrl": storeLocation.directionsUrl,
      "storeOpenDays": storeLocation.storeOpenDays,
      "storeTimings": storeLocation.storeTimings,
      "contactNumber": storeLocation.contactNumber,
      "alternateContactNumber": storeLocation.alternateContactNumber,
      "pickUpTimeStart": pickUpTimeStart.toString(),
      "pickUpTimeEnd": pickUpTimeEnd.toString(),
      "pickUpDate": pickUpDate.toString(),
      "pickUpDateInString": pickUpDateInString,
      "pickUpTimeInString": pickUpTimeInString
    };

    final response = await apiCall.update(
        url: url, updateBody: updateBody, accessToken: accessToken);
  }

  Future getOrderSummaryItems(String accessToken) async {
    const url = "https://server.unboxedkart.com/order-summary";
    final response = apiCall.get(url: url, accessToken: accessToken);
    return response;
  }

  Future createOrderSummaryItems(String accessToken, List orderItems) async {
    const url = "https://server.unboxedkart.com/order-summary/add";

    final postBody = {"orderItems": orderItems};
    var response = await apiCall.post(
        url: url, accessToken: accessToken, postBody: postBody);
  }

  Future getCartItems(String accessToken) async {
    const url = "https://server.unboxedkart.com/cart";
    final response = apiCall.get(url: url, accessToken: accessToken);

    return response;
  }

  Future deleteCartItem(String accessToken, String cartItemId) async {
    final url = "https://server.unboxedkart.com/cart/delete/$cartItemId";

    http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );
    return response.body;
  }

  Future addCartItem(String accessToken, String productId) async {
    const url = "https://server.unboxedkart.com/cart/add";

    final postBody = {"productId": productId, "productCount": 1};
    var response = await apiCall.post(
        url: url, accessToken: accessToken, postBody: postBody);
    return response;
  }

  Future updateCartItem(
      String accessToken, String productId, int productCount) async {
    const url = "https://server.unboxedkart.com/cart/update";

    final updateBody = {"productId": productId, "productCount": productCount};

    var response = await apiCall.update(
        url: url, accessToken: accessToken, updateBody: updateBody);
    return response;
  }

  Future getPayableAmount(String accessToken) async {
    const url = "https://server.unboxedkart.com/order-summary/payable-amount";
    final response = apiCall.get(url: url, accessToken: accessToken);
    return response;
  }

}
