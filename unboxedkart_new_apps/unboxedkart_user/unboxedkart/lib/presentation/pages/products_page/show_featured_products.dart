import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/products_page/bloc.dart';
import 'package:unboxedkart/presentation/models/products/products_grid.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class ShowFeaturedProducts extends StatelessWidget {
  final String brand;
  final String condition;
  final String category;
  final String sellerId;

  const ShowFeaturedProducts(
      {Key key, this.brand, this.condition, this.category, this.sellerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsPageBloc()
        ..add(LoadFeaturedProducts(category, brand, condition)),
      child: BlocBuilder<ProductsPageBloc, ProductsPageState>(
        builder: (context, state) {
          if (state is ProductsPageLoadedState) {
            if (state.searchedProducts.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedTextBox(
                    textContent: "Featured Products",
                    isBold: true,
                    fontSize: 18,
                    addPadding: true,
                  ),
                  ProductsGrid(
                    products: state.searchedProducts,
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const CustomLoadingWidget(
              title: "Featured Products",
            );
          }
        },
      ),
    );
  }
}
