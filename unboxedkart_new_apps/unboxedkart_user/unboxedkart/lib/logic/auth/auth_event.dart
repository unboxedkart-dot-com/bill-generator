part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoadAuthStatus extends AuthEvent {}

class SendOtp extends AuthEvent {
  final int phoneNumber;
  const SendOtp({this.phoneNumber});
}

class ResendOtp extends AuthEvent {
  final int phoneNumber;
  final int type;
  const ResendOtp({this.phoneNumber, this.type});
}


class CreateUser extends AuthEvent {
  final int phoneNumber;
  final int otp;
  final String userName;
  final String emailAddress;
  final String gender;

  const CreateUser(
      {this.emailAddress,
      this.otp,
      this.phoneNumber,
      this.userName,
      this.gender});
}

class LoginUser extends AuthEvent {
  final int phoneNumber;
  final int otp;

  const LoginUser({this.otp, this.phoneNumber});
}

// class LogoutUser extends AuthEvent {

// }

class ValidateOtp extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const ValidateOtp(this.phoneNumber, this.otp);

  
}

class LoadUserData extends AuthEvent {

}

class LogoutUser extends AuthEvent {
  
}
