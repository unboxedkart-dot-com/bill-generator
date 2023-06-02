class GetSelectedVariantDto {
  final String productCode;
  final String conditionCode;
  final String storageCode;
  final String colorCode;
  final String processorCode;
  final String ramCode;
  final String combinationCode;
  final String screenSizeCode;

  GetSelectedVariantDto(
     { this.productCode,
      this.conditionCode,
      this.storageCode,
      this.colorCode,
      this.processorCode,
      this.ramCode,
      this.combinationCode,
      this.screenSizeCode});
}
