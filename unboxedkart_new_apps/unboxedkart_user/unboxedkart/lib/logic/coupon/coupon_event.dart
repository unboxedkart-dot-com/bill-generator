part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class ValidateCoupon extends CouponEvent {
  final String couponCode;
  // final int cartTotal;

  const ValidateCoupon({this.couponCode});
}

class LoadPersonalCoupon extends CouponEvent {}

class LoadUserCoupons extends CouponEvent {}
