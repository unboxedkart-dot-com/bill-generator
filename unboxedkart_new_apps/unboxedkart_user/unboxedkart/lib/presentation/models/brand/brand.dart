import 'package:flutter/material.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/presentation/pages/brand_page/brand_page.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';

class BrandWidget extends StatelessWidget {
  final BrandModel brand;
  final String categoryName;
  final String conditionName;
  final bool searchByCategory;
  final bool searchByCondition;

  const BrandWidget(
      {Key key,
      this.brand,
      this.categoryName,
      this.conditionName,
      this.searchByCategory = false,
      this.searchByCondition = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("categorye");
        print(categoryName);
        print(conditionName);
        //   print(brand.slug);
        if (searchByCategory) {
          print("categorye");
          print(categoryName);
          print(conditionName);
          print(brand.slug);

          Navigator.pushNamed(context, "/products",
              arguments:
                  ProductsPage(category: categoryName, brand: brand.slug));
        } else if (searchByCondition) {
          Navigator.pushNamed(context, "/products",
              arguments:
                  ProductsPage(brand: brand.slug, condition: conditionName));
        } else {
          Navigator.pushNamed(context, '/brand',
              arguments: BrandPage(
                brandName: brand.brandName,
                slug: brand.slug,
              ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          image: AssetImage(brand.imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
