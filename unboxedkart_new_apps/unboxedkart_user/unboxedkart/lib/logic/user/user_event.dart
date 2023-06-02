part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserDetails extends UserEvent {}

class UpdateUserDetails extends UserEvent {
  final String name;
  final String gender;

  const UpdateUserDetails(this.name, this.gender);
}

class AddFavoriteItem extends UserEvent {
  final String productId;

  const AddFavoriteItem(this.productId);
}

class RemoveFavoriteItem extends UserEvent {
  final String productId;

  const RemoveFavoriteItem(this.productId);
}

class AddOrderSummary extends UserEvent {}

class AddDeliveryTypeToOrderSummary extends UserEvent {
  final String deliveryType;

  const AddDeliveryTypeToOrderSummary(this.deliveryType);
}

class AddDeliveryAddressToOrderSummary extends UserEvent {
  final AddressModel address;

  const AddDeliveryAddressToOrderSummary(this.address);
}

class AddCouponCodeToOrderSummary extends UserEvent {
  final String couponCode;
  final int discountAmount;

  const AddCouponCodeToOrderSummary(this.couponCode, this.discountAmount);
}


class LoadPaymentDetails extends UserEvent {

}

class UpdatePaymentDetails extends UserEvent {
  final String upiName;
  final String upiId;

  const UpdatePaymentDetails(this.upiName, this.upiId);
}
