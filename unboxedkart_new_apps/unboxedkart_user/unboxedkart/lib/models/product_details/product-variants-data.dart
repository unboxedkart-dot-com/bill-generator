import 'package:unboxedkart/presentation/pages/product_tile/select-variant.dart';

class ProductVariantsData {
  final String productCode;
  final List<VariantData> conditions = [
    VariantData(
      title: "UNBOXED",
      code: "unboxed",
    ),
    VariantData(
      title: "Grade A",
      code: "grade-a",
    ),
    VariantData(
      title: "Grade B",
      code: "grade-b",
    ),
    VariantData(
      title: "Grade C",
      code: "grade-c",
    )
  ];
  final List<VariantData> colors;
  final List<VariantData> storages;

  final List<VariantData> combinations;

  final List<VariantData> screenSizes;

  final List<VariantData> connectivty;

  final List<VariantData> processors;
  final List<VariantData> rams;

  ProductVariantsData(
      {this.productCode,
      this.colors,
      this.storages,
      this.combinations,
      this.screenSizes,
      this.connectivty,
      this.processors,
      this.rams});

  factory ProductVariantsData.fromDocument(doc) {
    return ProductVariantsData(
      productCode: doc['productCode'],
      colors: doc['colors'] != null
          ? doc['colors']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
      storages: doc['storages'] != null
          ? doc['storages']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
      combinations: doc['combinations'] != null
          ? doc['combinations']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
      screenSizes: doc['screenSizes'] != null
          ? doc['screenSizes']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
      connectivty: doc['connectivity'] != null
          ? doc['connectivity']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
      processors: doc['processors'] != null
          ? doc['processors']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
      rams: doc['rams'] != null
          ? doc['rams']
              .map<VariantData>((doc) => VariantData.fromDocument(doc))
              .toList()
          : [],
    );
  }
}
