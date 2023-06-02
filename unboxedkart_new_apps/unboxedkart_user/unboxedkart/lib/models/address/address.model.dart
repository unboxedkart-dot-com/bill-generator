class AddressModel {
  final String addressId;
  final int pinCode;
  final String doorNo;
  final String lane;
  final String street;
  final String cityName;
  final String stateName;
  final String landmark;
  final String name;
  final int phoneNumber;
  final int alternatePhoneNumber;
  final String addressType;

  AddressModel(
      {this.addressId,
      this.pinCode,
      this.doorNo,
      this.lane,
      this.street,
      this.cityName,
      this.stateName,
      this.landmark,
      this.name,
      this.phoneNumber,
      this.alternatePhoneNumber,
      this.addressType});

  factory AddressModel.fromDocument(doc) {
    return AddressModel(
      addressId: doc['_id'],
      pinCode: doc['pinCode'],
      doorNo: doc['doorNo'],
      lane: doc['lane'],
      street: doc['street'],
      cityName: doc['cityName'],
      stateName: doc['stateName'],
      landmark: doc['landmark'],
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      // alternatePhoneNumber: doc['alternatePhoneNumber'],
      addressType: doc['addressType'],
    );
  }
}
