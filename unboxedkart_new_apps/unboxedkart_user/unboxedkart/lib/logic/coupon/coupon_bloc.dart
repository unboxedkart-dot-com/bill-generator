import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/coupon.repository.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/models/coupon/coupon.model.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponRespository _couponRepository = CouponRespository();
  final LocalRepository _localRepo = LocalRepository();
  CouponBloc() : super(CouponInitial()) {
    on<ValidateCoupon>(_onvalidateCoupon);
    on<LoadPersonalCoupon>(_onLoadPersonalCoupon);
    on<LoadUserCoupons>(_onLoadUserCoupons);
  }

  _onvalidateCoupon(ValidateCoupon event, Emitter<CouponState> emit) async {
    
    emit(ApplyCouponLoadingState());
    final accessToken = await _localRepo.getAccessToken();
    var response = await _couponRepository.handleValidateCoupon(
        accessToken, event.couponCode);
    if (response['isValid']) {
      emit(ApplyCouponLoadedState(
          isValid: response['isValid'],
          coupon: CouponModel.fromDocument(response['couponDetails']),
          errorText: response['errorText']));
    } else {
      emit(ApplyCouponLoadedState(
          isValid: response['isValid'], errorText: response['errorText']));
    }
  }

  void _onLoadPersonalCoupon(
      LoadPersonalCoupon event, Emitter<CouponState> emit) async {
    emit(CouponLoading());
    final String accessToken = await _localRepo.getAccessToken();
    final CouponModel coupon =
        await _couponRepository.handleGetPersonalCoupon(accessToken);
    
    emit(CouponLoaded(coupon));
  }

  void _onLoadUserCoupons(
      LoadUserCoupons event, Emitter<CouponState> emit) async {
    emit(CouponLoading());
    final List<CouponModel> coupons =
        await _couponRepository.handleGetCoupons();

    emit(UserCouponsLoaded(coupons: coupons));
  }
}
