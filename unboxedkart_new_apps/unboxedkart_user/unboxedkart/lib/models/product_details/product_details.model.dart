class ProductsSpecs {
  final List<IndividualProductSpecModel> productSpecs;

  ProductsSpecs({this.productSpecs});

  factory ProductsSpecs.fromDocument(doc) {
    return ProductsSpecs(
        productSpecs: doc['productSpecs']
            .map((spec) => IndividualProductSpecModel.fromDocument(spec))
            .toList()
        // productSpecs: doc['productSpecs'] != null ? doc['productSpecs']
        //     .map((spec) => IndividualProductSpecModel.fromDocument(spec))
        //     .toList() : null,
        );
  }
}

class IndividualProductSpecModel {
  final String title;
  final Map values;

  IndividualProductSpecModel({this.title, this.values});

  factory IndividualProductSpecModel.fromDocument(doc) {
    return IndividualProductSpecModel(
      title: doc['title'],
      values: doc['values'],
    );
  }
}

// class ProductSpec {

// }
