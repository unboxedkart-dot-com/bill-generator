part of 'profilepage_bloc.dart';

abstract class ProfilepageState extends Equatable {
  const ProfilepageState();

  @override
  List<Object> get props => [];
}

class ProfilepageInitial extends ProfilepageState {}

class ProfilePageLoading extends ProfilepageState {}

class ProfilePageLoaded extends ProfilepageState {
  final bool authStatus;

  const ProfilePageLoaded(this.authStatus);

  @override
  get props => [authStatus];
}
