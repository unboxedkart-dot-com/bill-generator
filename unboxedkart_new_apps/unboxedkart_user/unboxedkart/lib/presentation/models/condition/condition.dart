import 'package:flutter/material.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';
import 'package:unboxedkart/presentation/pages/condition_page/condition_page.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';

class ConditionWidget extends StatelessWidget {
  final ConditionModel condition;
  final String categoryName;
  final String brandName;
  final bool searchByCategory;
  final bool searchByBrand;

  const ConditionWidget(
      {Key key,
      this.condition,
      this.brandName,
      this.categoryName,
      this.searchByBrand = false,
      this.searchByCategory = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(condition.slug);
        if (searchByCategory) {
          print("values");
          print(categoryName);
          print(brandName);
          print(condition.slug);
          Navigator.pushNamed(context, "/products",
              arguments: ProductsPage(
                  category: categoryName, condition: condition.slug));
        } else if (searchByBrand) {
          Navigator.pushNamed(context, "/products",
              arguments:
                  ProductsPage(brand: brandName, condition: condition.slug));
        } else {
          Navigator.pushNamed(context, '/condition',
              arguments: ConditionPage(
                conditionName: condition.conditionName,
                slug: condition.slug,
              ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          // elevation: 2,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.5,
            // height: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        image: AssetImage(condition.imageUrl),
                        fit: BoxFit.cover,
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
