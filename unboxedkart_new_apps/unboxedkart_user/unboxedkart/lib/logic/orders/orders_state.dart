part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  final List<OrderModel> orders;

  const OrdersLoadedState({this.orders = const <OrderModel>[]});

  @override
  List<Object> get props => [];
}

class OrdersPaymentLoaded extends OrdersState {
  final int payableAmount;
  final int partialPaymentAmount;
  final String partialPaymentOrderId;
  final String name;
  final int phoneNumber;
  final String email;
  final String paymentOrderId;

  const OrdersPaymentLoaded(
      {this.payableAmount,
      this.name,
      this.partialPaymentAmount,
      this.partialPaymentOrderId,
      this.phoneNumber,
      this.email,
      this.paymentOrderId});

  @override
  List<Object> get props => [
        payableAmount,
        name,
        partialPaymentAmount,
        partialPaymentOrderId,
        phoneNumber,
        email,
        paymentOrderId
      ];
}

class CreateOrderLoading extends OrdersState {}

class OrderLoadedState extends OrdersState {
  final MultiOrderModel order;

  const OrderLoadedState(this.order);

  @override
  get props => [order];
}

class CreateOrderLoaded extends OrdersState {
  final String orderDate;
  final String orderNumber;
  final String paymentType;
  final String deliveryType;
  final AddressModel selectedAddress;
  final String expectedDeliveryDate;
  final String selectedPickUpDate;
  final StoreLocationModel selectedStoreLocation;
  final List<OrderedItemModel> orderItems;

  const CreateOrderLoaded(
      {this.orderDate,
      this.orderNumber,
      this.paymentType,
      this.orderItems,
      this.deliveryType,
      this.selectedAddress,
      this.selectedStoreLocation,
      this.expectedDeliveryDate,
      this.selectedPickUpDate});
}

class OrdersPaymentVerifying extends OrdersState {}

class OrdersPaymentVerified extends OrdersState {
  final String orderNumber;

  const OrdersPaymentVerified(this.orderNumber);

  @override
  get props => [orderNumber];
}

class OrdersPaymentNotVerified extends OrdersState {}

class ReferralsLoaded extends OrdersState {
  final List<ReferralModel> referrals;

  const ReferralsLoaded({this.referrals = const <ReferralModel>[]});

  @override
  get props => [referrals];
}

class CancelOrderLoading extends OrdersState {}

class CancelOrderLoaded extends OrdersState {}

class PartialPaymentLoaded extends OrdersState {
  final int payableAmount;
  final String name;
  final int phoneNumber;
  final String email;
  final String paymentOrderId;

  const PartialPaymentLoaded(
      {this.payableAmount,
      this.name,
      this.phoneNumber,
      this.email,
      this.paymentOrderId});
}

class PartialPaymentLoading extends OrdersState {}
