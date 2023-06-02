import 'package:flutter/material.dart';
import 'package:unboxedkart/models/category/category.model.dart';
import 'package:unboxedkart/presentation/pages/category_page/category_page.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final String brandName;
  final String conditionName;
  final bool searchByBrand;
  final bool searchByCondition;
  // final bool isProductSearch;

  const CategoryWidget(
      {Key key,
      this.category,
      this.searchByBrand = false,
      this.searchByCondition = false,
      this.brandName,
      this.conditionName})
      : super(key: key);

  // const CategoryWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchByBrand) {
          Navigator.pushNamed(context, "/products",
              arguments:
                  ProductsPage(category: category.slug, brand: brandName));
        } else if (searchByCondition) {
          Navigator.pushNamed(context, "/products",
              arguments: ProductsPage(
                  category: category.slug, condition: conditionName));
        } else {
          Navigator.pushNamed(context, '/category',
              arguments: CategoryPage(
                categoryName: category.categoryName,
                slug: category.slug,
              ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSizedTextBox(
                    addPadding: true,
                    paddingWidth: 10,
                    textContent: category.categoryName,
                    // isBold: true,
                    fontSize: 16,
                    fontName: 'Alegreya Sans',
                    isBold: true,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Center(
                      child: Image(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.45,
                        image: AssetImage(category.imageUrl),
                        fit: BoxFit.contain,
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
