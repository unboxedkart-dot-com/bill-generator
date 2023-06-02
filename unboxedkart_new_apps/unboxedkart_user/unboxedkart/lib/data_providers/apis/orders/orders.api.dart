// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class OrdersApi {
  ApiCalls apiCalls = ApiCalls();

  Future getPayableAmount(String accessToken) async {
    const url =
        "https://server.unboxedkart.com/order-summary/payable-amount";
    final response = await apiCalls.get(url: url, accessToken: accessToken);
    return response;
  }

  // Future getParitalPaymentAmount(String accessToken) async {
  //   const url = "https://server.unboxedkart.com/order-summary/partial-payment";
  //   final response = await apiCalls.get(url: url, accessToken: accessToken);
  //   return response;
  // }

  Future verifyPaymentSignature(String accessToken, String paymentSignature,
      String paymentId, String orderId) async {
    const url =
        "https://server.unboxedkart.com/order-summary/verify-payment";
    final postBody = {
      "paymentSignature": paymentSignature,
      "paymentId": paymentId,
      "orderId": orderId
    };
    final response = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: postBody);

    return response;
  }

  Future verifyPartialPaymentSignature(String accessToken,
      String paymentSignature, String paymentId, String orderId) async {
    const url =
        "https://server.unboxedkart.com/order-summary/verify-partial-payment";
    final postBody = {
      "paymentSignature": paymentSignature,
      "paymentId": paymentId,
      "orderId": orderId
    };
    final response = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: postBody);

    return response;
  }

  Future getOrders(String accessToken) async {
    const url = "https://server.unboxedkart.com/orders";
    final response = await apiCalls.get(url: url, accessToken: accessToken);

    return response;
  }

  Future getOrder(String accessToken, String orderNumber) async {
    final url =
        "https://server.unboxedkart.com/orders/order?id=$orderNumber";
    final response = await apiCalls.get(url: url, accessToken: accessToken);

    return response;
  }

  Future createOrder(String accessToken, String paymentType) async {
    const url = "https://server.unboxedkart.com/orders/create";
    final postBody = {"paymentType": paymentType};
    final response = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: postBody);
    return response;
  }

  Future getOrderItem(String accessToken, String orderId) async {
    final url =
        "https://server.unboxedkart.com/orders/order-item?id=$orderId";
    final response = await apiCalls.get(url: url, accessToken: accessToken);
    return response;
  }

  Future getReferrals(String accessToken) async {
    const url = "https://server.unboxedkart.com/orders/referrals";
    final response = await apiCalls.get(url: url, accessToken: accessToken);
    return response;
  }

  Future cancelOrder(String accessToken, String orderId, String orderNumber,
      String reasonTitle, String reasonContent) async {
    const url = "https://server.unboxedkart.com/orders/cancel-order";
    final updateBody = {
      "orderId": orderId,
      "orderNumber": orderNumber,
      "reasonTitle": reasonTitle,
      "reasonContent": reasonContent
    };
    final response = await apiCalls.update(
        updateBody: updateBody, accessToken: accessToken, url: url);
    return response;
  }

  Future setPaymentMethod(String accessToken, String paymentMethod) async {
    const url =
        "https://server.unboxedkart.com/order-summary/update/payment-method";
    final updateBody = {"paymentMethod": paymentMethod};
    final response = await apiCalls.update(
        updateBody: updateBody, accessToken: accessToken, url: url);
    return response;
  }

  Future helpReasons() async {
    const url =
        "https://server.unboxedkart.com/order-summary/cancel-reasons";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future cancelReasons() async {
    const url =
        "https://server.unboxedkart.com/order-summary/help-reasons";
    final response = await apiCalls.get(url: url);
    return response;
  }

  Future sendInvoiceCopy(String accessToken, String orderId) async {
    const url =
        "https://server.unboxedkart.com/order-summary/help-reasons";
    final response = await apiCalls.get(url: url);
    return response;
  }
}
