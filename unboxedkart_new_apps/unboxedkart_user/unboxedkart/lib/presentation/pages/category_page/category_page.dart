import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/category/category_bloc.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';
import 'package:unboxedkart/presentation/carousels/show-carousel.dart';
import 'package:unboxedkart/presentation/models/brand/brand.dart';
import 'package:unboxedkart/presentation/models/condition/condition.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_best_sellers.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_featured_products.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;
  final String slug;
  const CategoryPage({Key key, this.categoryName, this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: categoryName,
          enableSearchBar: true,
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: BlocProvider(
          create: (context) => CategoryBloc()..add(LoadData(slug)),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryPageLoadingState) {
                return const LoadingSpinnerWidget();
              } else if (state is CategoryPageLoadedState) {
                return ListView(
                  children: [
                    ShowCarouselItems(
                      isVertical: true,
                      placement: 'category/$slug',
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Brand",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _BuildBrandsByCategory(
                      brands: state.brands,
                      categoryName: slug,
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Product Condition",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _BuildConditionsByCategory(
                        conditions: state.conditions, categoryName: slug),
                    ShowFeaturedProducts(category: slug),
                    ShowBestSellers(category: slug),
                  ],
                );
              } else {
                return const Text("Something went wrong");
              }
            },
          )),
    );
  }
}

class _BuildBrandsByCategory extends StatelessWidget {
  final String categoryName;
  final List<BrandModel> brands;
  const _BuildBrandsByCategory({Key key, this.brands, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int columnCount = getColumnCount(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: brands.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return BrandWidget(
            brand: brands[index],
            searchByCategory: true,
            categoryName: categoryName,
          );
        });
  }
}

class _BuildConditionsByCategory extends StatelessWidget {
  final String categoryName;
  final List<ConditionModel> conditions;
  const _BuildConditionsByCategory(
      {Key key, this.conditions, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int columnCount = getColumnCount(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: conditions.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return ConditionWidget(
            condition: conditions[index],
            categoryName: categoryName,
            searchByCategory: true,
          );
        });
  }
}
