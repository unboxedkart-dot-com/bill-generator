part of 'ordersummary_bloc.dart';

abstract class OrdersummaryState extends Equatable {
  const OrdersummaryState();

  @override
  List<Object> get props => [];
}

class OrdersummaryInitial extends OrdersummaryState {}

class OrderSummaryItemsLoading extends OrdersummaryState {}

class OrderSummaryItemsLoadedState extends OrdersummaryState {
  final List<CartItemModel> cartItems;
  final int cartTotal;
  final int couponDiscount;
  const OrderSummaryItemsLoadedState(
      {this.cartItems = const <CartItemModel>[],
      this.cartTotal,
      this.couponDiscount});

  @override
  List<Object> get props => [cartItems];
}

class OrderSummaryPaymentLoading extends OrdersummaryState {}

class OrderSummaryPaymentLoaded extends OrdersummaryState {
  final int payableAmount;

  const OrderSummaryPaymentLoaded({this.payableAmount});

  @override
  List<Object> get props => [payableAmount];
}
