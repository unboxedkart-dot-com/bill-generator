part of 'ordersummary_bloc.dart';

abstract class OrdersummaryEvent extends Equatable {
  const OrdersummaryEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderSummaryItems extends OrdersummaryEvent {}

class AddOrderSummaryItem extends OrdersummaryEvent {
  final List orderItems;
  const AddOrderSummaryItem({this.orderItems});
}

class UpdateOrderSummaryItem extends OrdersummaryEvent {
  final String productId;
  final int updatedProductCount;
  const UpdateOrderSummaryItem({this.productId, this.updatedProductCount});
}


class AddDeliveryDetailsToOrderSummary extends OrdersummaryEvent {
  final AddressModel address;
  final int deliveryType;
  final StoreLocationModel storeLocation;
  final DateTime pickUpTimeStart;
  final DateTime pickUpTimeEnd;
  final String pickUpTimeInString;
  final String pickUpDateInString;
  final DateTime pickUpDate;

  const AddDeliveryDetailsToOrderSummary(
      {this.address,
      this.deliveryType,
      this.storeLocation,
      this.pickUpTimeEnd,
      this.pickUpTimeStart,
      this.pickUpDate,
      this.pickUpDateInString,
      this.pickUpTimeInString});
}

class AddShippingDetails extends OrdersummaryEvent {
  final AddressModel address;
  final int deliveryType;
  final DateTime deliveryDate;
  final String deliveryDateInString;

  const AddShippingDetails(
      {this.address,
      this.deliveryType,
      this.deliveryDate,
      this.deliveryDateInString});
}

class AddPickUpDetails extends OrdersummaryEvent {
  final int deliveryType;
  final StoreLocationModel storeLocation;
  final DateTime pickUpTimeStart;
  final DateTime pickUpTimeEnd;
  final DateTime pickUpDate;
  final String pickUpTimeInString;
  final String pickUpDateInString;

  const AddPickUpDetails(
      {this.deliveryType,
      this.storeLocation,
      this.pickUpTimeEnd,
      this.pickUpTimeStart,
      this.pickUpDate,
      this.pickUpDateInString,
      this.pickUpTimeInString});
}

class AddCouponCodeToOrderSummary extends OrdersummaryEvent {
  final String couponCode;
  final int discountAmount;

  const AddCouponCodeToOrderSummary({this.couponCode, this.discountAmount});
}

// class GetPayableAmount extends OrdersummaryEvent {

// }
