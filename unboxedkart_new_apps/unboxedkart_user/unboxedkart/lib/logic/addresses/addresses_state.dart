part of 'addresses_bloc.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object> get props => [];
}

class AddressesLoadingState extends AddressesState {}

class AddressesLoadedState extends AddressesState {
  final List<AddressModel> addresses;
  final List<StoreLocationModel> storeLocations;
  const AddressesLoadedState(
      {this.addresses = const <AddressModel>[],
      this.storeLocations = const <StoreLocationModel>[]});

  @override
  List<Object> get props => [addresses, storeLocations];
}

class SelectAddressLoaded extends AddressesState {
  final List<AddressModel> addresses;
  const SelectAddressLoaded({this.addresses = const <AddressModel>[]});

  @override
  List<Object> get props => [addresses];
}

class SelectStoreLocationLoaded extends AddressesState {
  final List<StoreLocationModel> storeLocations;
  const SelectStoreLocationLoaded(
      {this.storeLocations = const <StoreLocationModel>[]});

  @override
  List<Object> get props => [storeLocations];
}

class UserAddressesLoaded extends AddressesState {
  final List<AddressModel> addresses;

  const UserAddressesLoaded(this.addresses);

  @override
  get props => [addresses];
}

class CreateAddressLoading extends AddressesState {}

class CreateAddressLoaded extends AddressesState {}

class UpdateAddressLoading extends AddressesState {}

class UpdateAddressLoaded extends AddressesState {}
