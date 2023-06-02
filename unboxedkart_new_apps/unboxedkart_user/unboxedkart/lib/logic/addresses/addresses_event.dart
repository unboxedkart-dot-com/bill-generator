part of 'addresses_bloc.dart';

abstract class AddressesEvent extends Equatable {
  const AddressesEvent();

  @override
  List<Object> get props => [];
}

// class LoadAddresses extends AddressesEvent {
//   final int deliveryType;

//   const LoadAddresses({this.deliveryType});
// }

class LoadSelectAddress extends AddressesEvent {
  final int deliveryType;

  const LoadSelectAddress({this.deliveryType});
}

class LoadSelectStoreLocation extends AddressesEvent {
  final int deliveryType;

  const LoadSelectStoreLocation({this.deliveryType});
}

class LoadStoreLocations extends AddressesEvent {
  
}

class LoadUserAddresses extends AddressesEvent {}

class AddAddress extends AddressesEvent {
  AddressModel address;
  

  AddAddress({this.address

      });
}

class UpdateAddress extends AddressesEvent {
  final AddressModel address;


  const UpdateAddress({this.address});
}

class DeleteAddress extends AddressesEvent {
  String addressId;
  DeleteAddress({this.addressId});
}
