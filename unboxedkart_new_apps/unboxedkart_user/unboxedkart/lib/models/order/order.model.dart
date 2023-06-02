import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

import '../cart_item/cart_item.model.dart';

class OrderModel {
  _ShippingDetails shippingDetails;
  _PickUpDetails pickUpDetails;
  PricingDetails pricingDetails;
  ProductDetails productDetails;
  _OrderDetails orderDetails;
  _ReviewDetails reviewDetails;
  _PaymentDetails paymentDetails;
  String deliveryType;
  String orderId;
  String orderNumber;
  DateTime orderDate;
  DateTime deliveryDate;

  String orderStatus;

  OrderModel(
      {this.orderDate,
      this.deliveryType,
      this.pickUpDetails,
      this.orderDetails,
      this.orderId,
      this.orderNumber,
      this.orderStatus,
      this.pricingDetails,
      this.productDetails,
      this.paymentDetails,
      this.shippingDetails,
      this.reviewDetails,
      this.deliveryDate});

  factory OrderModel.fromDocument(doc) {
    final String deliveryType = doc['deliveryType'];
    return OrderModel(
        pickUpDetails: deliveryType == "STORE PICKUP"
            ? _PickUpDetails.fromDoc(doc['pickUpDetails'])
            : null,
        shippingDetails: deliveryType == "HOME DELIVERY"
            ? _ShippingDetails.fromDocument(doc['shippingDetails'])
            : null,
        pricingDetails: PricingDetails.fromDocument(doc['pricingDetails']),
        paymentDetails: _PaymentDetails.fromDoc(doc['paymentDetails']),
        productDetails: ProductDetails.fromDocument(doc['productDetails']),
        orderDetails: _OrderDetails.fromDocument(doc['orderDetails']),
        deliveryType: doc['deliveryType'],
        // reviewDetails: _ReviewDetails.fromDocument(doc['reviewDetails']),
        orderId: doc['_id'],
        orderNumber: doc['orderNumber'],
        orderDate: DateTime.fromMillisecondsSinceEpoch(
            int.parse(doc['orderDate'])),
        // DateTime.fromMillisecondsSinceEpoch(int.parse(doc['orderDate'])),
        // .toLocal(),
        // DateTime.parse("2022-05-19T21:11:14.473+00:00",).toLocal(),
        // DateTime.now(),
        // DateTime.parse(doc['orderDate']),
        orderStatus: doc['orderStatus']);
  }
}

class _ReviewDetails {
  bool isReviewed;
  int rating;
  String reviewTitle;
  String reviewContent;

  _ReviewDetails(
      {this.isReviewed, this.rating, this.reviewContent, this.reviewTitle});

  factory _ReviewDetails.fromDocument(doc) {
    return _ReviewDetails(
        isReviewed: doc['isReviewed'],
        rating: doc['rating'],
        reviewTitle: doc['reviewTitle'],
        reviewContent: doc['reviewContent']);
  }
}

class _PickUpDetails {
  final DateTime pickUpDate;
  final StoreLocationModel storeLocation;
  final bool isPickedUp;
  final String pickUpTimeInString;
  final String pickUpDateInString;

  _PickUpDetails(
      {this.pickUpDate,
      this.storeLocation,
      this.isPickedUp,
      this.pickUpDateInString,
      this.pickUpTimeInString});

  factory _PickUpDetails.fromDoc(doc) {
    return _PickUpDetails(
        pickUpDate: DateTime.now(),
        storeLocation: StoreLocationModel.fromDocument(doc['storeLocation']),
        isPickedUp: doc['isPickedUp'],
        pickUpDateInString: doc['pickUpDateInString'],
        pickUpTimeInString: doc['pickUpTimeInString']);
  }
}

class _OrderDetails {
  String productId;
  int pricePerItem;
  int productCount;

  _OrderDetails({this.pricePerItem, this.productCount, this.productId});

  factory _OrderDetails.fromDocument(doc) {
    return _OrderDetails(
        pricePerItem: doc['pricePerItem'],
        productId: doc['productId'],
        productCount: doc['productCount']);
  }
}

class PricingDetails {
  bool isPaid;
  int billTotal;
  num payableTotal;
  String couponCode;
  int couponDiscount;
  int price;
  int sellingPrice;

  PricingDetails(
      {this.billTotal,
      this.couponCode,
      this.couponDiscount,
      this.isPaid,
      this.payableTotal,
      this.price,
      this.sellingPrice});

  factory PricingDetails.fromDocument(doc) {
    return PricingDetails(
        isPaid: doc['isPaid'],
        price: doc['price'],
        sellingPrice: doc['price'],
        billTotal: doc['billTotal'],
        payableTotal: doc['payableTotal'],
        couponCode: doc['couponCode'],
        couponDiscount: doc['couponDiscount']);
  }
}

class _ShippingDetails {
  DateTime deliveryDate;
  String deliveryDateInString;
  AddressModel address;
  bool isdelivered;

  _ShippingDetails(
      {this.deliveryDate,
      this.address,
      this.isdelivered,
      this.deliveryDateInString});

  factory _ShippingDetails.fromDocument(doc) {
    return _ShippingDetails(
        deliveryDate: DateTime.parse(doc['deliveryDate']),
        deliveryDateInString: doc['deliveryDateInString'],
        // isdelivered: doc['isDelivered'],
        address: AddressModel.fromDocument(doc['deliveryAddress']));
  }
}

class _PaymentDetails {
  final String paymentType;
  final int amountPaid;
  final int totalAmount;
  final int amountDue;
  final String paymentMethod;

  _PaymentDetails(
      {this.paymentType,
      this.amountPaid,
      this.totalAmount,
      this.amountDue,
      this.paymentMethod});

  factory _PaymentDetails.fromDoc(doc) {
    return _PaymentDetails(
        paymentType: doc['paymentType'],
        amountPaid: doc['amountPaid'].toInt(),
        amountDue: doc['amountDue'].toInt(),
        totalAmount: doc['payableAmount'],
        paymentMethod: doc['paymentMethod']);
  }
}
