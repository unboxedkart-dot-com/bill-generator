import 'package:flutter/cupertino.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_best_sellers.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_featured_products.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class SellerPage extends StatelessWidget {
  final String sellerId;
  final String sellerName;

  const SellerPage({Key key, this.sellerId, this.sellerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: sellerName,
      child: ListView(
        children: [
          ElevatedContainer(
            elevation: 0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomSizedTextBox(
                textContent: sellerName,
                addPadding: true,
                isBold: true,
                fontSize: 25,
              ),
              CustomSizedTextBox(
                addPadding: true,
                textContent:
                    "Sharadha Enterprises is commited to providing each customer with the highest standard of customer service",
              )
            ]),
          ),
          ShowFeaturedProducts(sellerId: sellerId),
          ShowBestSellers(sellerId: sellerId),
        ],
      ),
    );
  }
}
