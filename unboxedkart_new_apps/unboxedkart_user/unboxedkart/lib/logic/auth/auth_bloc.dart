import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/auth.repository.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/response-models/login_user.response.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository = AuthRepository();
  final LocalRepository _localRepo = LocalRepository();

  AuthBloc() : super(IsNotAuthenticatedState()) {
    on<LoadAuthStatus>(_onLoadAuthStatus);
    on<SendOtp>(_onSendOtp);
    on<ResendOtp>(_onResendOtp);
    on<CreateUser>(_onCreateUser);
    on<LoginUser>(_onLoginUser);
    on<LogoutUser>(_onLogoutUser);
    on<ValidateOtp>(_onValidateOtp);
    on<LoadUserData>(_onLoadUserData);
  }

  void _onLoadAuthStatus(LoadAuthStatus event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());
    final authStatus = await _localRepo.getAuthStatus();
    emit(IsAuthLoadedState(authStatus));
  }

  void _onValidateOtp(ValidateOtp event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());
    final response =
        await authRepository.handleValidateOtp(event.phoneNumber, event.otp);
    if (response['status'] == "success") {
      emit(CreateUserDetailsState());
    } else {
      emit(AuthErrorState(
          message: response['message'], content: response['content']));
    }
  }

  void _onSendOtp(SendOtp event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());

    final response = await authRepository.handleSendOtp(event.phoneNumber);

    emit(IsNotAuthenticatedState());
  }

  void _onResendOtp(ResendOtp event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());
    final response = await authRepository.handleResendOtp(event.phoneNumber);
    emit(IsNotAuthenticatedState());
  }

  void _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());
    final UserLoggedInResponse userDetails =
        await authRepository.handleLoginUser(event.phoneNumber, event.otp);
    if (userDetails.status == "success") {
      for (var item in userDetails.wishlist) {
        await _localRepo.addWishlistItem(item);
      }
      for (var item in userDetails.cart) {
        await _localRepo.addCartItem(item);
      }
      for (var item in userDetails.recentSearches) {
        await _localRepo.addRecentSearchTerm(item);
      }
      // await _localRepo.addPopularSearchTerms(userDetails.popularSearches);
      await _localRepo.addPurchasedItems(userDetails.purchasedItemIds);
      await _localRepo.setIsAuthenticated(
          userDetails.accessToken, userDetails.userId);
      emit(IsAuthenticatedState());
      // emit(const IsAuthLoadedState(true));
    } else {
       
      emit(AuthErrorState(
          message: userDetails.message, content: userDetails.content));
    }
  }

  void _onCreateUser(CreateUser event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());
    final UserLoggedInResponse userDetails =
        await authRepository.handleCreateUser(
            phoneNumber: event.phoneNumber,
            otp: event.otp,
            name: event.userName,
            emailAddress: event.emailAddress,
            gender: event.gender);
    if (userDetails.status == "success") {
      await _localRepo.setIsAuthenticated(
          userDetails.accessToken, userDetails.userId);
      emit(IsAuthenticatedState());
    } else {
      emit(AuthErrorState(
          message: userDetails.message, content: userDetails.content));
    }
  }

  void _onLoadUserData(LoadUserData event, Emitter<AuthState> emit) async {
    final userId = await _localRepo.getAccessToken();
  }

  void _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(IsAuthLoadingState());
    await _localRepo.setIsNotAuthenticated();
    emit(const IsAuthLoadedState(false));
  }
}


      






