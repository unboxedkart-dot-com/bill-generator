import 'package:flutter/cupertino.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/presentation/models/product/product_vertical.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;

  const ProductsGrid({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int columnCount = getColumnCount(context);
    return Container(
      // padding: const EdgeInsets.,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          itemCount: products.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return ProductVertical(
              product: products[index],
            );
          }),
    );
  }
}
