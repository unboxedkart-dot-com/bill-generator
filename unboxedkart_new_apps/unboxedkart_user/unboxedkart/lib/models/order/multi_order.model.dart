import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/ordered_item/ordered_item.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

class MultiOrderModel {
  final List<OrderedItemModel> orderItems;
  final StoreLocationModel pickUpStoreDetails;
  final AddressModel addressDetails;
  final String deliveryType;
  final String orderDate;
  final String orderNumber;
  final String paymentType;
  final String paymentMethod;
  final int amountPaid;
  final int amountDue;
  final int couponDiscount;
  final String couponCode;
  final String pickUpTimeInString;
  final String pickUpDateInString;
  final String expectedDeliveryTimeInString;

  MultiOrderModel(
      {this.orderItems,
      this.pickUpStoreDetails,
      this.addressDetails,
      this.deliveryType,
      this.orderDate,
      this.orderNumber,
      this.paymentType,
      this.paymentMethod,
      this.amountPaid,
      this.amountDue,
      this.pickUpTimeInString,
      this.pickUpDateInString,
      this.couponCode,
      this.couponDiscount,
      this.expectedDeliveryTimeInString});

  factory MultiOrderModel.fromDoc(doc) {
    String deliveryType = doc['deliveryType'];
    return MultiOrderModel(
      orderItems: doc['orderItems']
          .map<OrderedItemModel>((doc) => OrderedItemModel.fromDocument(doc))
          .toList(),
      pickUpStoreDetails: deliveryType == "STORE PICKUP"
          ? StoreLocationModel.fromDocument(
              doc["pickUpDetails"]["storeLocation"])
          : null,
      addressDetails: deliveryType == "HOME DELIVERY"
          ? AddressModel.fromDocument(doc["shippingDetails"]["deliveryAddress"])
          : null,
      deliveryType: doc["deliveryType"],
      orderDate: doc["orderDate"],
      orderNumber: doc["orderNumber"],
      paymentType: doc["paymentDetails"]["paymentType"],
      paymentMethod: doc["paymentDetails"]["paymentMethod"],
      amountPaid: doc["paymentDetails"]["amountPaid"],
      amountDue: doc["paymentDetails"]["amountDue"],
      pickUpTimeInString: deliveryType == "STORE PICKUP"
          ? doc["pickUpDetails"]["pickUpTimeInString"]
          : null,
      pickUpDateInString: deliveryType == "STORE PICKUP"
          ? doc['pickUpDetails']['pickUpDateInString']
          : null,
      couponCode: doc['pricingDetails']['couponCode'],
      couponDiscount: doc['pricingDetails']['couponDiscount'],
      expectedDeliveryTimeInString: deliveryType == "HOME DELIVERY"
          ? doc["shippingDetails"]["expectedDeliveryTimeInString"]
          : null,
      // expectedDeliveryTimeInString: doc["shippingDetails"]
      // ["expectedDeliveryTimeInString"],
    );
  }
}
