import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/user.repository.dart';
import 'package:unboxedkart/data_providers/repositories/wishlist.repository.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/user/user.model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LocalRepository _localRepo = LocalRepository();
  UserRepository userRepository = UserRepository();
  final WishlistRepository _wishlistRepository = WishlistRepository();

  UserBloc() : super(UserInitial()) {
    on<LoadUserDetails>(_onLoadUserDetails);
    on<UpdateUserDetails>(_onUpdateUserDetails);
    on<AddFavoriteItem>(_onAddFavoriteItem);
    on<RemoveFavoriteItem>(_onRemoveFavoriteItem);
    on<LoadPaymentDetails>(_onLoadPaymentDetails);
    on<UpdatePaymentDetails>(_onUpdatePaymentDetails);
  }

  void _onLoadUserDetails(
      LoadUserDetails event, Emitter<UserState> emit) async {
    emit(UserDetailsLoading());
    final String accessToken = await _localRepo.getAccessToken();
    final UserModel user =
        await userRepository.handleGetUserDetails(accessToken);

    emit(UserDetailsLoaded(user));
  }

  void _onUpdateUserDetails(
      UpdateUserDetails event, Emitter<UserState> emit) async {
    emit(UserDetailsUpdating());
    final String accessToken = await _localRepo.getAccessToken();
    final response = await userRepository.handleUpdateUserDetails(
        accessToken, event.name, event.gender);
    emit(UserDetailsUpdated());
  }

  void _onLoadPaymentDetails(
      LoadPaymentDetails event, Emitter<UserState> emit) async {
    emit(PaymentDetailsLoading());
    final String accessToken = await _localRepo.getAccessToken();
    final PaymentDetailModel paymentDetails =
        await userRepository.handleGetPaymentDetails(accessToken);
    emit(PaymentDetailsLoaded(paymentDetails: paymentDetails));
  }

  void _onUpdatePaymentDetails(
      UpdatePaymentDetails event, Emitter<UserState> emit) async {
    emit(PaymentDetailsLoading());
    final String accessToken = await _localRepo.getAccessToken();
    await userRepository.handleUpdateUserDetails(
        accessToken, event.upiName, event.upiId);
    emit(PaymentDetailsUpdated());
  }

  void _onAddFavoriteItem(
      AddFavoriteItem event, Emitter<UserState> emit) async {
    await _localRepo.addWishlistItem(event.productId);
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _wishlistRepository.handleAddWishlistItem(
        accessToken, event.productId);
  }

  void _onRemoveFavoriteItem(
      RemoveFavoriteItem event, Emitter<UserState> emit) async {
    await _localRepo.removeWishlistItem(event.productId);
    final String accessToken = await _localRepo.getAccessToken();
    final response = await _wishlistRepository.handleRemoveWishlistItem(
        accessToken, event.productId);
  }
}
