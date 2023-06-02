import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/orders.repository.dart';
import 'package:unboxedkart/data_providers/repositories/reviews.repository.dart';
import 'package:unboxedkart/models/order/order.model.dart';
import 'package:unboxedkart/models/reviews/review.model.dart';

part 'ordertile_event.dart';
part 'ordertile_state.dart';

class OrdertileBloc extends Bloc<OrdertileEvent, OrdertileState> {
  final ReviewsRepository _reviewsRepo = ReviewsRepository();
  final LocalRepository _localRepo = LocalRepository();
  OrdersRepository ordersRepository = OrdersRepository();
  ReviewsRepository reviewsRepository = ReviewsRepository();

  OrdertileBloc() : super(OrdertileInitial()) {
    on<LoadOrderTile>(_onLoadOrderTile);
    on<LoadCancelReasons>(_onLoadCancelReasons);
    on<LoadHelpReasons>(_onLoadHelpReasons);
    on<SendInvoiceCopy>(_onSendInvoiceCopy);
    // on<RateProduct>(_onRateProduct);
    // on<UpdateReview>(_onUpdateReview);
  }

  void _onLoadOrderTile(
      LoadOrderTile event, Emitter<OrdertileState> emit) async {
    emit(OrderTileLoading());
    final String accessToken = await _localRepo.getAccessToken();
    final orderItemDetails =
        await ordersRepository.handleGetOrderItem(accessToken, event.orderId);

    emit(OrdertileLoaded(
        orderItemDetails['orderItem'], orderItemDetails['review']));
  }


  FutureOr<void> _onLoadCancelReasons(
      LoadCancelReasons event, Emitter<OrdertileState> emit) async {
    emit(OrderTileLoading());
    final reasons = await ordersRepository.handleGetCancelReaons();
    emit(CancelReasonsLoaded(reasons));
  }

  FutureOr<void> _onLoadHelpReasons(
      LoadHelpReasons event, Emitter<OrdertileState> emit) async {
    emit(OrderTileLoading());
    final reasons = await ordersRepository.handleGetHelpReasons();
    emit(CancelReasonsLoaded(reasons));
  }

  void _onSendInvoiceCopy(
      SendInvoiceCopy event, Emitter<OrdertileState> emit) async {
    final String accessToken = await _localRepo.getAccessToken();
    await ordersRepository.handleSendInvoiceCopy(accessToken, event.orderId);
  }
}
