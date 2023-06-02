

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';

part 'profilepage_event.dart';
part 'profilepage_state.dart';

class ProfilepageBloc extends Bloc<ProfilepageEvent, ProfilepageState> {
  final LocalRepository _localRepo = LocalRepository();
  ProfilepageBloc() : super(ProfilepageInitial()) {
    on<LoadProfilePage>(_onLoadProfilePage);
  }

  void _onLoadProfilePage(
      LoadProfilePage event, Emitter<ProfilepageState> emit) async {
    emit(ProfilePageLoading());
    final authStatus = await _localRepo.getAuthStatus();
    emit(ProfilePageLoaded(authStatus));
  }

}
