class StoreLocationModel {
  final String storeName;
  final String streetName;
  final String cityName;
  final int pinCode;
  final String directionsUrl;
  final String storeTimings;
  final String storeOpenDays;
  final int contactNumber;
  final int alternateContactNumber;

  StoreLocationModel(
      {this.storeName,
      this.streetName,
      this.cityName,
      this.pinCode,
      this.directionsUrl,
      this.storeTimings,
      this.storeOpenDays,
      this.contactNumber,
      this.alternateContactNumber});

  factory StoreLocationModel.fromDocument(doc) {
    return StoreLocationModel(
        storeName: doc['storeName'],
        streetName: doc['streetName'],
        cityName: doc['cityName'],
        pinCode: doc['pinCode'],
        directionsUrl: doc['directionsUrl'],
        storeOpenDays: doc['storeOpenDays'],
        storeTimings: doc['storeTimings'],
        contactNumber: doc['contactNumber'],
        alternateContactNumber: doc['alternateContactNumber']);
  }
}
