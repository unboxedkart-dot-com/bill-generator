import 'package:unboxedkart/data_providers/apis/addresses/addresses.api.dart';
import 'package:unboxedkart/models/address/address.model.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';

class AddressesRepository {
  final AddressesApi addressesApi = AddressesApi();

  Future handleGetAddresses(String accessToken) async {
    
    final response = await addressesApi.getAddresses(accessToken);
    
    final List<AddressModel> addresses = response
        .map<AddressModel>((address) => AddressModel.fromDocument(address))
        .toList();
    
    
    return addresses;
  }

  Future handleAddAddress(
      String accessToken, AddressModel address) async {
    final response = await addressesApi.addAddress(accessToken, address);
    return response;
  }

  Future handleUpdateAddress(
      String accessToken, AddressModel address) async {
    final response = await addressesApi.updateAddress(accessToken, address);
    return response;
  }

  Future handleDeleteAddress(String accessToken, String addressId) async {
    final response = await addressesApi.deleteAddress(accessToken, addressId);
    return response;
  }

  Future<List<StoreLocationModel>> handleGetStoreLocations() async {
    final response = await addressesApi.getStoreLocations();
    final List<StoreLocationModel> locations = response
      .map<StoreLocationModel>(
          (product) => StoreLocationModel.fromDocument(product)).toList(); 
    return locations;
  }
}
