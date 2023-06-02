part of 'ordertile_bloc.dart';

abstract class OrdertileEvent extends Equatable {
  const OrdertileEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderTile extends OrdertileEvent {
  final String orderId;

  const LoadOrderTile(this.orderId);

}

class RateProduct extends OrdertileEvent {
  final int rating;
  final String productId;
  final String productTitle;
  final String imageUrl;

  const RateProduct({this.rating, this.productId, this.productTitle, this.imageUrl});
}

class UpdateReview extends OrdertileEvent {
  String reviewId;
  final int rating;
  final String title;
  final String content;

  UpdateReview({this.reviewId, this.rating, this.title, this.content});
}

class LoadHelpReasons extends OrdertileEvent {


}

class LoadCancelReasons extends OrdertileEvent {

}

class SendInvoiceCopy extends OrdertileEvent {
  final String orderId;

  const SendInvoiceCopy(this.orderId);

}


