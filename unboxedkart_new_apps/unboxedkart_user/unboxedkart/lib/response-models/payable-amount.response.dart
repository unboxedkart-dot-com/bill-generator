class PayableAmountResponse {
  final int payableAmount;
  final int partialPaymentAmount;
  final String partialPaymentOrderId;
  final String name;
  final int phoneNumber;
  final String email;
  final String paymentOrderId;

  const PayableAmountResponse(
      {this.payableAmount,
      this.name,
      this.partialPaymentAmount,
      this.partialPaymentOrderId,
      this.phoneNumber,
      this.email,
      this.paymentOrderId});

  factory PayableAmountResponse.fromDoc(doc) {
    return PayableAmountResponse(
      name: doc["name"],
      phoneNumber: doc["phoneNumber"],
      email: doc["email"],
      // name: "sunil",
      // phoneNumber: 9494111131,
      // email: "hello@imsunil.com",
      payableAmount: doc["payableAmount"],
      partialPaymentAmount: doc["partialPaymentAmount"],
      partialPaymentOrderId: doc["partialPaymentOrderId"],
      paymentOrderId: doc["paymentOrderId"],
    );
  }
}
