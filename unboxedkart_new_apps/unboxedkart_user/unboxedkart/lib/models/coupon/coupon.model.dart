class CouponModel {
  final String couponCode;
  final int discountAmount;
  final String couponDescription;
  final String discountType;
  final String expiryType;
  final String redemptionType;
  final DateTime expiryTime;
  final bool isActive;
  final bool isPersonalCoupon;
  final int minimumOrderTotal;

  CouponModel(
      {this.couponCode,
      this.discountAmount,
      this.couponDescription,
      this.discountType,
      this.expiryType,
      this.redemptionType,
      this.expiryTime,
      this.isActive,
      this.isPersonalCoupon,
      this.minimumOrderTotal});

  factory CouponModel.fromDocument(doc) {
    String expiryType = doc['expiryType'];
    print("expirty type");
    print(doc);
    return CouponModel(
        couponCode: doc['couponCode'],
        discountAmount: doc['discountAmount'],
        couponDescription: doc['couponDescription'],
        discountType: doc['discountType'],
        expiryType: doc['expiryType'],
        redemptionType: doc['redemptionType'],
        expiryTime: expiryType != "NON EXPIRABLE"
            ? DateTime.tryParse(doc['expiryTime']).toLocal()
            : null,
        isActive: doc['isActive'],
        isPersonalCoupon: doc['isPersonalCoupon'],
        minimumOrderTotal: doc['minimumOrderTotal']);
  }
}
