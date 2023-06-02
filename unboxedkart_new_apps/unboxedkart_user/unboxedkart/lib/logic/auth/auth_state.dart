part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class IsAuthLoadingState extends AuthState {}

class IsAuthLoadedState extends AuthState {
  // final String message;
  // final int status;
  final bool authStatus;

  const IsAuthLoadedState(this.authStatus);
}

class AuthErrorState extends AuthState {
  final String message;
  final String content;
  final int status;

  const AuthErrorState({this.message, this.status, this.content});

  @override
  get props => [message, status];
}

class IsAuthenticatedState extends AuthState {}

class IsNotAuthenticatedState extends AuthState {}

class CreateUserDetailsState extends AuthState {}
