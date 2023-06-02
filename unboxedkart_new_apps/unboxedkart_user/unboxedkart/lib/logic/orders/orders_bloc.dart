
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/orders.repository.dart';
import 'package:unboxedkart/models/order/multi_order.model.dart';
import 'package:unboxedkart/models/ordered_item/ordered_item.model.dart';
import 'package:unboxedkart/models/referral/referral.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';
import 'package:unboxedkart/response-models/payable-amount.response.dart';

import '../../models/address/address.model.dart';
import '../../models/order/order.model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersRepository ordersRepository = OrdersRepository();
  LocalRepository localRepo = LocalRepository();

  OrdersBloc() : super(OrdersLoadingState()) {
    on<LoadOrders>(_onLoadOrders);
    on<CreateOrder>(_onCreateOrder);
    on<GetPayableAmount>(_onGetPayableAmount);
    on<SetPaymentMethod>(_onSetPaymentMethod);
    on<GetPartialPaymentAmount>(_onGetPartialPaymentAmount);
    on<VerifyPaymentSignature>(_onVerifyPaymentSignature);
    on<VerifyPartialPaymentSignature>(_onVerifyPartialPaymentSignature);
    on<LoadMyReferralOrders>(_onLoadReferralOrders);
    on<CancelOrder>(_onCancelOrder);
    on<LoadOrder>(_onLoadOrder);
  }

  void _onLoadOrders(LoadOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadingState());
    final bloc1 = OrdersBloc();

    final accessToken = await localRepo.getAccessToken();

    final List<OrderModel> orders =
        await ordersRepository.handleGetOrders(accessToken);
    emit(OrdersLoadedState(orders: orders));
    final bloc2 = OrdersBloc();
  }

  void _onGetPayableAmount(
      GetPayableAmount event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadingState());

    final String accessToken = await localRepo.getAccessToken();
    final PayableAmountResponse payableAmountData =
        await ordersRepository.getPayableAmount(accessToken);

    emit(OrdersPaymentLoaded(
        payableAmount: payableAmountData.payableAmount,
        name: payableAmountData.name,
        email: payableAmountData.email,
        phoneNumber: payableAmountData.phoneNumber,
        paymentOrderId: payableAmountData.paymentOrderId,
        partialPaymentAmount: payableAmountData.partialPaymentAmount,
        partialPaymentOrderId: payableAmountData.partialPaymentOrderId));
  }

  void _onCreateOrder(CreateOrder event, Emitter<OrdersState> emit) async {
    emit(CreateOrderLoading());
    final String accessToken = await localRepo.getAccessToken();
    final response = await ordersRepository.handleCreateOrder(
        accessToken, event.paymentType);

    List<OrderedItemModel> orderedItems = response['orderItems']['orderItems']
        .map<OrderedItemModel>((item) => OrderedItemModel.fromDocument(item))
        .toList();
    if (response['deliveryType'] == "HOME DELIVERY") {
      AddressModel selectedAddress =
          AddressModel.fromDocument(response['selectedAddress']);
      emit(CreateOrderLoaded(
          selectedAddress: selectedAddress,
          orderItems: orderedItems,
          deliveryType: response['deliveryType'],
          paymentType: response['paymentType'],
          orderNumber: response['orderNumber'],
          expectedDeliveryDate: '${response['deliveryDate']}'));
    } else {
      StoreLocationModel selecedStoreLocation =
          StoreLocationModel.fromDocument(response['selectedStore']);
      for (var i in orderedItems) {
        await localRepo.removeCartItem(i.productId);
      }
      emit(CreateOrderLoaded(
          selectedStoreLocation: selecedStoreLocation,
          orderItems: orderedItems,
          deliveryType: response['deliveryType'],
          paymentType: response['paymentType'],
          orderNumber: response['orderNumber'],
          expectedDeliveryDate:
              '${response['pickUpDateInString']} (${response['pickUpTimeInString']})'));
    }
  }

  void _onVerifyPaymentSignature(
      VerifyPaymentSignature event, Emitter<OrdersState> emit) async {
    emit(OrdersPaymentVerifying());
    final String accessToken = await localRepo.getAccessToken();
    final response = await ordersRepository.handleVerifyPaymentSignature(
        accessToken, event.orderId, event.paymentId, event.paymentSignture);
    if (response['status'] == 'success') {
      emit(OrdersPaymentVerified(response['orderNumber']));
    } else {
      emit(OrdersPaymentNotVerified());
    }
  }

  void _onLoadReferralOrders(
      LoadMyReferralOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadingState());
    final String accessToken = await localRepo.getAccessToken();
    final List referrals =
        await ordersRepository.handleGetReferrals(accessToken);
    emit(ReferralsLoaded(referrals: referrals));
  }

  void _onCancelOrder(CancelOrder event, Emitter<OrdersState> emit) async {
    emit(CancelOrderLoading());
    final String accessToken = await localRepo.getAccessToken();
    final response = await ordersRepository.handleCancelOrder(
        accessToken,
        event.orderId,
        event.orderNumber,
        event.reasonTitle,
        event.reasonContent);

    emit(CancelOrderLoaded());
  }

  void _onGetPartialPaymentAmount(
      GetPartialPaymentAmount event, Emitter<OrdersState> emit) async {
    emit(PartialPaymentLoading());
    final String accessToken = await localRepo.getAccessToken();
    final payableAmountData =
        await ordersRepository.getPayableAmount(accessToken);
    emit(PartialPaymentLoaded(
      payableAmount: payableAmountData['payableAmount'],
      name: payableAmountData['name'],
      email: payableAmountData['email'],
      phoneNumber: payableAmountData['phoneNumber'],
      paymentOrderId: payableAmountData['orderId'],
    ));
  }

  void _onVerifyPartialPaymentSignature(
      VerifyPartialPaymentSignature event, Emitter<OrdersState> emit) async {
    emit(OrdersPaymentVerifying());
    final String accessToken = await localRepo.getAccessToken();
    final response = await ordersRepository.handleVerifyPartialPaymentSignature(
        accessToken, event.orderId, event.paymentId, event.paymentSignture);
    if (response['status'] == 'success') {
      emit(OrdersPaymentVerified(response['orderNumber']));
    } else {
      emit(OrdersPaymentNotVerified());
    }
  }

  void _onSetPaymentMethod(
      SetPaymentMethod event, Emitter<OrdersState> emit) async {
    emit(OrdersPaymentVerifying());
    final String accessToken = await localRepo.getAccessToken();
    final response = await ordersRepository.handleSetPaymentMethod(
        accessToken, event.paymentMethod);
     
    emit(OrdersPaymentVerified(response['orderNumber']));
  }

  void _onLoadOrder(LoadOrder event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadingState());
    final String accessToken = await localRepo.getAccessToken();
    final response =
        await ordersRepository.handleGetOrder(accessToken, event.orderNumber);
    emit(OrderLoadedState(response));
  }
}
