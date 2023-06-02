import 'package:unboxedkart/data_providers/apis/orders/orders.api.dart';
import 'package:unboxedkart/models/order/multi_order.model.dart';
import 'package:unboxedkart/models/order/order.model.dart';
import 'package:unboxedkart/models/referral/referral.model.dart';
import 'package:unboxedkart/models/reviews/review.model.dart';
import 'package:unboxedkart/response-models/payable-amount.response.dart';

class OrdersRepository {
  final OrdersApi orderApi = OrdersApi();

  Future getPayableAmount(String accessToken) async {
    final response = await orderApi.getPayableAmount(accessToken);
    PayableAmountResponse payableAmount =
        PayableAmountResponse.fromDoc(response);
    return payableAmount;
  }

  Future handleVerifyPaymentSignature(String accessToken, String orderId,
      String paymentId, String paymentSignature) async {
    final response = await orderApi.verifyPaymentSignature(
        accessToken, paymentSignature, paymentId, orderId);
    return response;
  }

  Future handleVerifyPartialPaymentSignature(String accessToken, String orderId,
      String paymentId, String paymentSignature) async {
    final response = await orderApi.verifyPartialPaymentSignature(
        accessToken, paymentSignature, paymentId, orderId);
    return response;
  }

  Future handleGetOrders(String accessToken) async {
    final response = await orderApi.getOrders(accessToken);
    final List<OrderModel> orders = response
        .map<OrderModel>((product) => OrderModel.fromDocument(product))
        .toList();
    return orders;
  }

  Future handleCreateOrder(String accessToken, String paymentType) async {
    final response = await orderApi.createOrder(accessToken, paymentType);
    return response;
  }

  Future handleGetOrderItem(String accessToken, String orderId) async {
    final response = await orderApi.getOrderItem(accessToken, orderId);
     
    OrderModel orderItem =
        OrderModel.fromDocument(response['data']['orderItem']);
    ReviewModel review = response['data']['reviewData'] == null
        ? null
        : ReviewModel.fromDoc(response['data']['reviewData']);

    return {"orderItem": orderItem, "review": review};
  }

  Future handleGetReferrals(String accessToken) async {
    final response = await orderApi.getReferrals(accessToken);
    final List<ReferralModel> referrals = response
        .map<ReferralModel>((doc) => ReferralModel.fromDocument(doc))
        .toList();
    return referrals;
  }

  Future handleCancelOrder(String accessToken, String orderId,
      String orderNumber, String reasonTitle, String reasonContent) async {
    final response = await orderApi.cancelOrder(
        accessToken, orderId, orderNumber, reasonTitle, reasonContent);
    return response;
  }

  Future handleSetPaymentMethod(
      String accessToken, String paymentMethod) async {
    final response =
        await orderApi.setPaymentMethod(accessToken, paymentMethod);
    return response;
  }

  Future handleGetOrder(String accessToken, String orderNumber) async {
    final response = await orderApi.getOrder(accessToken, orderNumber);
    final MultiOrderModel order = MultiOrderModel.fromDoc(response);
    return order;
  }

  Future handleGetHelpReasons() async {
    final response = await orderApi.helpReasons();
    return response;
  }

  Future handleGetCancelReaons() async {
    final response = await orderApi.cancelReasons();
    return response;
  }

  Future handleSendInvoiceCopy(String accessToken, String orderId) async {
    await orderApi.sendInvoiceCopy(accessToken, orderId);
  }
}
