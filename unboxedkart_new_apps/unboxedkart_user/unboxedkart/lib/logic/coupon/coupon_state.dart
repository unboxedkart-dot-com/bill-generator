part of 'coupon_bloc.dart';

abstract class CouponState extends Equatable {
  const CouponState();

  @override
  List<Object> get props => [];
}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponLoaded extends CouponState {
  final CouponModel coupon;

  const CouponLoaded(this.coupon);

  @override
  get props => [coupon];
}

class UserCouponsLoaded extends CouponState {
  final List<CouponModel> coupons;

  const UserCouponsLoaded({this.coupons = const <CouponModel>[]});

  @override
  get props => [coupons];
}

class ApplyCouponLoadedState extends CouponState {
  final bool isValid;
  final String errorText;
  final CouponModel coupon;

  const ApplyCouponLoadedState({this.errorText, this.coupon, this.isValid});

  @override
  List<Object> get props => [errorText, coupon];
}

class ApplyCouponLoadingState extends CouponState {}
