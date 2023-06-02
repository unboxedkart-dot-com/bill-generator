import 'package:unboxedkart/models/reviews/reviews_data.model.dart';

class ProductModel {
  final String id;
  final String sku;
  final String productCode;
  final String title;
  final String modelNumber;
  final String brand;
  final String brandCode;
  final String category;
  final String categoryCode;
  final String condition;
  final String conditionCode;
  final ImageUrls imageUrls;
  final Pricing pricing;
  final num rating;
  final int quantity;
  final List<dynamic> aboutProduct;
  final List<dynamic> highlights;
  final List<dynamic> searchCases;
  final bool isBestSeller;
  final bool isFeatured;
  final MoreDetails moreDetails;
  List<ReviewsDataModel> reviewsData;
  final _WarrantyDetails warrantyDetails;
  final String boxContains;
  final String sellerName;
  final String sellerId;

  ProductModel(
      {this.id,
      this.sku,
      this.productCode,
      this.rating,
      this.title,
      this.modelNumber,
      this.brand,
      this.brandCode,
      this.category,
      this.categoryCode,
      this.condition,
      this.conditionCode,
      this.imageUrls,
      this.pricing,
      this.quantity,
      this.aboutProduct,
      this.highlights,
      this.searchCases,
      this.isBestSeller,
      this.reviewsData,
      this.isFeatured,
      this.moreDetails,
      this.warrantyDetails,
      this.boxContains,
      this.sellerId,
      this.sellerName});

  factory ProductModel.fromDoc(doc) {
    print("reviewsdata");
    print(doc);
    // print(doc['rating']);
    bool reviewsIsEmpty =
        doc['rating'] != null && doc['rating'].isNotEmpty ? false : true;
    print("reviewsbool");
    print(reviewsIsEmpty);
    print(doc['reviews']);
    // print(double.parse(doc['reviews'][0]['averageRating']));
    // print(doc['reviews'][0]);
    // double rating = doc['reviews'] != null
    //     ? double.parse(doc['reviews'][0]['averageRating'])
    //     : 0;
    // final doc = doc[]
    // final document = doc['document'];
    return ProductModel(
        id: doc['_id'],
        sku: doc['SKU'],
        title: doc['title'],
        productCode: doc['productCode'],
        modelNumber: doc['modelNumber'],
        brand: doc['brand'],
        brandCode: doc['brandCode'],
        category: doc['category'],
        categoryCode: doc['categoryCode'],
        condition: doc['condition'],
        conditionCode: doc['conditionCode'],
        imageUrls: ImageUrls.fromDocument(doc['imageUrls']),
        pricing: Pricing.fromDocument(doc['pricing']),
        quantity: doc['quantity'],
        aboutProduct: doc['aboutProduct'],
        highlights: doc['highlights'],
        searchCases: doc['searchCases'],
        isBestSeller: doc['isBestSeller'],
        isFeatured: doc['isFeatured'],
        moreDetails: MoreDetails.fromDocument(doc['moreDetails']),
        warrantyDetails: _WarrantyDetails.fromDoc(doc['warrantyDetails']),
        rating: reviewsIsEmpty ? 0 : doc['rating'][0]['averageRating'],
        boxContains: doc['boxContains'],
        sellerId: doc['sellerDetails']['sellerId'],
        sellerName: doc['sellerDetails']['sellerName']);
  }
}

// class QAndA {}

class ImageUrls {
  String coverImage;
  List images;

  ImageUrls({this.images, this.coverImage});

  factory ImageUrls.fromDocument(doc) {
    return ImageUrls(coverImage: doc['coverImage'], images: doc['images']);
  }
}

class Pricing {
  int price;
  int sellingPrice;

  Pricing({this.price, this.sellingPrice});

  factory Pricing.fromDocument(doc) {
    return Pricing(price: doc['price'], sellingPrice: doc['sellingPrice']);
  }
}

class MoreDetails {
  String color;
  String colorCode;
  String storage;
  String storageCode;
  String ram;
  String ramCode;
  String processor;
  String processorCode;

  MoreDetails(
      {this.color,
      this.colorCode,
      this.storage,
      this.storageCode,
      this.processor,
      this.processorCode,
      this.ram,
      this.ramCode});

  factory MoreDetails.fromDocument(doc) {
    return MoreDetails(
        color: doc['color'],
        colorCode: doc['colorCode'],
        storage: doc['storage'],
        storageCode: doc['storageCode'],
        ram: doc['ram'],
        ramCode: doc['ramCode'],
        processor: doc['processor'],
        processorCode: doc['processorCode']);
  }
}

class _WarrantyDetails {
  final String description;
  final DateTime expiryDate;
  final int warrantyLeft;
  final bool isUnderWarranty;

  _WarrantyDetails(
      {this.description,
      this.expiryDate,
      this.warrantyLeft,
      this.isUnderWarranty});

  factory _WarrantyDetails.fromDoc(doc) {
    return _WarrantyDetails(
        description: doc['description'],
        expiryDate: doc['expiryDate'],
        warrantyLeft: doc['warrantyLeft'],
        isUnderWarranty: doc['isUnderWarranty']);
  }
}
