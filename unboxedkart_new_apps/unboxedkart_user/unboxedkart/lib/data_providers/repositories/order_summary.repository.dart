import 'package:unboxedkart/data_providers/apis/order_summary/order_summary.api.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

import '../../models/cart_item/cart_item.model.dart';

class OrderSummaryRepository {
  final OrderSummaryApi orderSummaryApi = OrderSummaryApi();

  Future handleGetOrderSummaryItems(String accessToken) async {
    final response = await orderSummaryApi.getOrderSummaryItems(accessToken);
    
    
    final List<CartItemModel> orderSummaryItems = response
        .map<CartItemModel>((cartItem) => CartItemModel.fromDocument(cartItem))
        .toList();
    return orderSummaryItems;
  }

  Future handleAddCouponCode(String accessToken, String couponCode) async {
    final response = await orderSummaryApi.addCouponCode(accessToken, couponCode);
    
    
    return response;
  }

  Future handleAddOrderSummaryItems(String accessToken, List orderItems) async {
    

    await orderSummaryApi.createOrderSummaryItems(accessToken, orderItems);
  
  }

  Future handleAddDeliveryAddress(
      {AddressModel address,
      String accessToken,
      DateTime deliveryDate,
      String deliveryDateInString}) async {
    await orderSummaryApi.addDeliveryAddress(
        accessToken: accessToken, address: address);
  }

  Future getPayableAmount(String accessToken) async {
    final response = await orderSummaryApi.getPayableAmount(accessToken);
    return response;
  }

  Future handleAddSelectedStoreDetails(
      {String accessToken,
      StoreLocationModel storeLocation,
      DateTime pickUpTimeStart,
      DateTime pickUpTimeEnd,
      DateTime pickUpDate,
      String pickUpTimeInString,
      String pickUpDateInString}) async {
    
    await orderSummaryApi.addStoreLocationDetails(
        accessToken: accessToken,
        storeLocation: storeLocation,
        pickUpTimeEnd: pickUpTimeEnd,
        pickUpTimeStart: pickUpTimeStart,
        pickUpDateInString: pickUpDateInString,
        pickUpDate: pickUpDate,
        pickUpTimeInString: pickUpTimeInString
        );
  }

  Future handleUpdateCount(String accessToken, String productId,
      int updatedCount, int productIndex) async {
    final response = orderSummaryApi.updateProductCount(
        accessToken, productId, updatedCount, productIndex);
    return response;
  }
}
