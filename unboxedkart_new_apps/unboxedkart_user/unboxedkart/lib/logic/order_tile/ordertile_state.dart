part of 'ordertile_bloc.dart';

abstract class OrdertileState extends Equatable {
  const OrdertileState();

  @override
  List<Object> get props => [];
}

class OrdertileInitial extends OrdertileState {}

class OrderTileLoading extends OrdertileState {}

class OrdertileLoaded extends OrdertileState {
  final OrderModel order;
  final ReviewModel review;

  const OrdertileLoaded(this.order, this.review);

  @override
  get props => [order, review];
}

class HelpReasonsLoaded extends OrdertileState {
  final List<String> reasons;
  const HelpReasonsLoaded(this.reasons);

  @override
  get props => [reasons];
}

class CancelReasonsLoaded extends OrdertileState {
  final List<String> reasons;
  const CancelReasonsLoaded(this.reasons);

  @override
  get props => [reasons];
}
