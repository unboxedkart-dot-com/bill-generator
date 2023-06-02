part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrdersEvent {}

class LoadOrder extends OrdersEvent {
  final String orderNumber;

  const LoadOrder(this.orderNumber);
}

class CreateOrder extends OrdersEvent {
  final String paymentType;
  final String paymentId;
  final String deliveryType;

  const CreateOrder({this.paymentType, this.paymentId, this.deliveryType});
}

class GetPayableAmount extends OrdersEvent {}

class SetPaymentMethod extends OrdersEvent {
  final String paymentMethod;

  const SetPaymentMethod(this.paymentMethod);
}

class VerifyPaymentSignature extends OrdersEvent {
  final String paymentSignture;
  final String paymentId;
  final String orderId;

  const VerifyPaymentSignature(this.paymentSignture, this.paymentId, this.orderId);
}


class VerifyPartialPaymentSignature extends OrdersEvent {
  final String paymentSignture;
  final String paymentId;
  final String orderId;

  const VerifyPartialPaymentSignature(this.paymentSignture, this.paymentId, this.orderId);
}

class LoadMyReferralOrders extends OrdersEvent {}

class CancelOrder extends OrdersEvent {
  final String orderId;
  final String orderNumber;
  final String reasonTitle;
  final String reasonContent;

  const CancelOrder(
      this.orderId, this.orderNumber, this.reasonTitle, this.reasonContent);
}

class NeedHelp extends OrdersEvent {
  final String orderId;
  final String orderNumber;
  final String reasonTitle;
  final String reasonContent;

  const NeedHelp(this.orderId, this.orderNumber, this.reasonTitle, this.reasonContent);
  
}

class GetPartialPaymentAmount extends OrdersEvent {

}


