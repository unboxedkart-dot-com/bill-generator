import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/addresses.repository.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

import '../../models/address/address.model.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final LocalRepository _localRepo = LocalRepository();
  List<AddressModel> addresses = [];
  final AddressesRepository addressesRepository = AddressesRepository();
  AddressesBloc() : super(AddressesLoadingState()) {
    on<LoadSelectAddress>(_onLoadSelectAddress);
    on<LoadSelectStoreLocation>(_onLoadSelectStoreLocation);
    on<LoadStoreLocations>(_onLoadStoreLocations);
    on<LoadUserAddresses>(_onLoadUserAddresses);
    on<AddAddress>(_onAddAddress);
    on<DeleteAddress>(_onDeleteAddress);
    on<UpdateAddress>(_onUpdateAddress);
  }

  void _onLoadSelectAddress(
      LoadSelectAddress event, Emitter<AddressesState> emit) async {
    emit(AddressesLoadingState());
    final accessToken = await _localRepo.getAccessToken();
    final List<AddressModel> addresses =
        await addressesRepository.handleGetAddresses(accessToken);
    emit(AddressesLoadedState(addresses: addresses));
  }

  void _onLoadSelectStoreLocation(
      LoadSelectStoreLocation event, Emitter<AddressesState> emit) async {
    emit(AddressesLoadingState());
    final accessToken = await _localRepo.getAccessToken();

    final List<StoreLocationModel> storeLocations =
        await addressesRepository.handleGetStoreLocations();

    emit(AddressesLoadedState(storeLocations: storeLocations));
  }

  void _onLoadStoreLocations(
      LoadStoreLocations event, Emitter<AddressesState> emit) async {
    emit(AddressesLoadingState());
    final List<StoreLocationModel> storeLocations =
        await addressesRepository.handleGetStoreLocations();
    emit(AddressesLoadedState(storeLocations: storeLocations));
  }

  void _onLoadUserAddresses(
      LoadUserAddresses event, Emitter<AddressesState> emit) async {
    emit(AddressesLoadingState());
    final accessToken = await _localRepo.getAccessToken();
    final List<AddressModel> addresses =
        await addressesRepository.handleGetAddresses(accessToken);
    this.addresses = addresses;
    emit(AddressesLoadedState(addresses: addresses));
  }

  void _onAddAddress(AddAddress event, Emitter<AddressesState> emit) async {
    emit(CreateAddressLoading());
    final accessToken = await _localRepo.getAccessToken();
    final response =
        await addressesRepository.handleAddAddress(accessToken, event.address);

    emit(CreateAddressLoaded());
  }

  void _onDeleteAddress(
      DeleteAddress event, Emitter<AddressesState> emit) async {
    emit(AddressesLoadingState());
    final accessToken = await _localRepo.getAccessToken();
    await addressesRepository.handleDeleteAddress(accessToken, event.addressId);
    final deletedItemIndex =
        addresses.indexWhere((element) => element.addressId == event.addressId);
    addresses.removeAt(deletedItemIndex);
    emit(AddressesLoadedState(addresses: addresses));
  }

  void _onUpdateAddress(
      UpdateAddress event, Emitter<AddressesState> emit) async {
    emit(UpdateAddressLoading());
    final accessToken = await _localRepo.getAccessToken();
    final response = await addressesRepository.handleUpdateAddress(
        accessToken, event.address);
    emit(UpdateAddressLoaded());
  }
}
