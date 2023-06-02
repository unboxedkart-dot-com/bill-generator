
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/order_summary.repository.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/cart_item/cart_item.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

part 'ordersummary_event.dart';
part 'ordersummary_state.dart';

class OrdersummaryBloc extends Bloc<OrdersummaryEvent, OrdersummaryState> {
  final OrderSummaryRepository _orderSummaryRepository =
      OrderSummaryRepository();
  final LocalRepository localRepo = LocalRepository();
  List<CartItemModel> cartItems;
  int cartTotal = 0;
  OrdersummaryBloc() : super(OrdersummaryInitial()) {
    on<LoadOrderSummaryItems>(_onLoadOrderSummaryItems);
    on<AddOrderSummaryItem>(_onAddOrderSummaryItems);
    on<UpdateOrderSummaryItem>(_onUpdateOrderSummaryItem);
    on<AddCouponCodeToOrderSummary>(_onAddCouponToOrderSummary);
    // on<AddDeliveryDetailsToOrderSummary>(_onAddDeliveryDetailsToOrderSummary);
    on<AddPickUpDetails>(_onAddPickUpDetails);
    on<AddShippingDetails>(_onAddShippingDetails);
    // on<GetPayableAmount>(_onGetPayableAmount);
  }

  void _onLoadOrderSummaryItems(
      LoadOrderSummaryItems event, Emitter<OrdersummaryState> emit) async {
    emit(OrderSummaryItemsLoading());
    final accessToken = await localRepo.getAccessToken();
    
    final List<CartItemModel> cartItems =
        await _orderSummaryRepository.handleGetOrderSummaryItems(accessToken);
    
    
    this.cartItems = cartItems;
    cartTotal = _getCartTotal();
    emit(OrderSummaryItemsLoadedState(
        cartItems: this.cartItems, cartTotal: cartTotal));
  }

  void _onAddOrderSummaryItems(
      AddOrderSummaryItem event, Emitter<OrdersummaryState> emit) async {
    
    final accessToken = await localRepo.getAccessToken();
    await _orderSummaryRepository.handleAddOrderSummaryItems(
        accessToken, event.orderItems);
    
  }

  void _onUpdateOrderSummaryItem(
      UpdateOrderSummaryItem event, Emitter<OrdersummaryState> emit) async {
    emit(OrderSummaryItemsLoading());
    
    final String accessToken = await localRepo.getAccessToken();
    // final accessToken = await localRepo.getAccessToken();
    
    final updatedItemIndex = cartItems
        .indexWhere((element) => element.productId == event.productId);
    
    
    cartItems[updatedItemIndex].productCount = event.updatedProductCount;
    
    cartTotal = _getCartTotal();
    
    await _orderSummaryRepository.handleUpdateCount(accessToken,
        event.productId, event.updatedProductCount, updatedItemIndex);
    emit(OrderSummaryItemsLoadedState(
        cartItems: cartItems, cartTotal: cartTotal));
    
  }

  int _getCartTotal() {
    int total = 0;
    for (var item in cartItems) {
      int itemPrice = item.pricingDetails.sellingPrice * item.productCount;
      total += itemPrice;
    }
    
    return total;
  }

  void _onAddCouponToOrderSummary(AddCouponCodeToOrderSummary event,
      Emitter<OrdersummaryState> emit) async {
    emit(OrderSummaryItemsLoading());
    final String accessToken = await localRepo.getAccessToken();
    cartTotal -= event.discountAmount;
    final response = await _orderSummaryRepository.handleAddCouponCode(
        accessToken, event.couponCode);
    emit(OrderSummaryItemsLoadedState(
        cartItems: cartItems,
        cartTotal: cartTotal,
        couponDiscount: event.discountAmount));
  }

  void _onAddDeliveryDetailsToOrderSummary(
      AddDeliveryDetailsToOrderSummary event,
      Emitter<OrdersummaryState> emit) async {
    
    

    
    
    
    final accessToken = await localRepo.getAccessToken();
    if (event.deliveryType == 0) {
      await _orderSummaryRepository.handleAddSelectedStoreDetails(
          accessToken: accessToken,
          storeLocation: event.storeLocation,
          pickUpTimeEnd: event.pickUpTimeEnd,
          pickUpTimeStart: event.pickUpTimeStart);
    } else if (event.deliveryType == 1) {
      await _orderSummaryRepository.handleAddDeliveryAddress(
          address: event.address, accessToken: accessToken);
    }
    
    
    
  }

  void _onAddPickUpDetails(
      AddPickUpDetails event, Emitter<OrdersummaryState> emit) async {
    final accessToken = await localRepo.getAccessToken();
    await _orderSummaryRepository.handleAddSelectedStoreDetails(
        accessToken: accessToken,
        storeLocation: event.storeLocation,
        pickUpTimeEnd: event.pickUpTimeEnd,
        pickUpTimeStart: event.pickUpTimeStart,
        pickUpDate: event.pickUpDate,
        pickUpDateInString: event.pickUpDateInString,
        pickUpTimeInString: event.pickUpTimeInString);
  }

  void _onAddShippingDetails(
      AddShippingDetails event, Emitter<OrdersummaryState> emit) async {
    final accessToken = await localRepo.getAccessToken();
    await _orderSummaryRepository.handleAddDeliveryAddress(
        address: event.address, accessToken: accessToken);
  }
}
