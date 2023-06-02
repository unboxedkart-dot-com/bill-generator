import 'package:unboxedkart/data_providers/apis/api_calls.dart';
import 'package:unboxedkart/models/address/address.model.dart';

class AddAddressParams {
  String name;
  int phoneNumber;
  int alternatePhoneNumber;
  String doorNo;
  String street;
  String cityName;
  String landMark;
  String stateName;
  int pinCode;
  String addressType;

  AddAddressParams(
      {this.name,
      this.phoneNumber,
      this.alternatePhoneNumber,
      this.doorNo,
      this.street,
      this.landMark,
      this.cityName,
      this.stateName,
      this.pinCode,
      this.addressType});
}

class AddressesApi {
  ApiCalls apiCall = ApiCalls();

  Future getAddresses(String accessToken) async {
    const url = "https://server.unboxedkart.com/addresses";
    var response = await apiCall.get(url: url, accessToken: accessToken);
    return response;
  }

  Future addAddress(String accessToken, AddressModel address) async {
    const url = "https://server.unboxedkart.com/addresses";
    final postBody = {
      "name": address.name,
      "doorNo": address.doorNo,
      "lane": address.lane,
      "street": address.street,
      "cityName": address.cityName,
      "landmark": address.landmark,
      "stateName": address.stateName,
      "pinCode": address.pinCode,
      "phoneNumber": address.phoneNumber,
      "alternatePhoneNumber": address.alternatePhoneNumber,
      "addressType": address.addressType,
    };
    var response = await apiCall.post(
        url: url, accessToken: accessToken, postBody: postBody);
    return response;
  }

  Future updateAddress(String accessToken, AddressModel address) async {
    const url = "https://server.unboxedkart.com/addresses/update";
    final updateBody = {
      "addressId": address.addressId,
      "name": address.name,
      "doorNo": address.doorNo,
      "lane": address.lane,
      "street": address.street,
      "cityName": address.cityName,
      "landmark": address.landmark,
      "stateName": address.stateName,
      "pinCode": address.pinCode,
      "phoneNumber": address.phoneNumber,
      "alternatePhoneNumber": address.alternatePhoneNumber,
      "addressType": address.addressType,
    };

    final response = await apiCall.post(
        url: url, accessToken: accessToken, postBody: updateBody);
    return response;
  }

  Future deleteAddress(String accessToken, String addressId) async {
    final url = "https://server.unboxedkart.com/addresses/delete?id=$addressId";
         
    var response = await apiCall.delete(url: url, accessToken: accessToken);

    return response;
  }

  Future getStoreLocations() async {
    const url = "https://server.unboxedkart.com/store-location";
    var response = await apiCall.get(url: url);
    return response;
  }
}
