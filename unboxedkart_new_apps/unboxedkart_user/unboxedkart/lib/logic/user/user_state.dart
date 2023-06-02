part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserDetailsLoading extends UserState {}

class UserDetailsLoaded extends UserState {
  final UserModel user;

  const UserDetailsLoaded(this.user);

  @override
  get props => [user];
}

class UserDetailsUpdating extends UserState {}

class UserDetailsUpdated extends UserState {}

class PaymentDetailsLoading extends UserState {
 
}

class PaymentDetailsLoaded extends UserState {
  final PaymentDetailModel paymentDetails;

  const PaymentDetailsLoaded({this.paymentDetails});

  @override
  get props => [paymentDetails];
}

class PaymentDetailsUpdated extends UserState {

}
