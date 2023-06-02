import 'package:flutter/cupertino.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class SearchTerm extends StatelessWidget {
  final String searchTerm;

  SearchTerm({Key key, this.searchTerm}) : super(key: key);

  UsageTrackingApi _usageTrackingApi = UsageTrackingApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _usageTrackingApi.handleAddSearchTerm(searchTerm);
        Navigator.pushNamed(context, '/products',
            arguments: ProductsPage(title: searchTerm.toLowerCase()));
      },
      child: ElevatedContainer(
        elevation: 0,
        // padding: const EdgeInsets.all(8),
        // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.search,
                color: CustomColors.blue,
                size: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomSizedTextBox(
                textContent: searchTerm,
                fontSize: 20,
                color: CustomColors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
