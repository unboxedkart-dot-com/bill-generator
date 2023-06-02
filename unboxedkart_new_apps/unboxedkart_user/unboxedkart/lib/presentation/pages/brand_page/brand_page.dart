import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/repositories/brand.repository.dart';
import 'package:unboxedkart/logic/brand/brand_bloc.dart';
import 'package:unboxedkart/models/category/category.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';
import 'package:unboxedkart/presentation/carousels/show-carousel.dart';
import 'package:unboxedkart/presentation/models/category/category.dart';
import 'package:unboxedkart/presentation/models/condition/condition.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_best_sellers.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_featured_products.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class BrandPage extends StatelessWidget {
  final String brandName;
  final String slug;
  const BrandPage({Key key, this.brandName, this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: brandName,
          enableSearchBar: true,
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: BlocProvider(
          create: (context) =>
              BrandBloc(RepositoryProvider.of<BrandRepository>(context))
                ..add(LoadData(slug)),
          child: BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state is BrandPageLoadingState) {
                return const LoadingSpinnerWidget();
              } else if (state is BrandPageLoadedState) {
                return ListView(
                  children: [
                    ShowCarouselItems(
                      isVertical: true,
                      placement: 'brand/${brandName.toLowerCase()}',
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Category",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _BuildCategoriesByBrand(
                      categories: state.categories,
                      brandName: slug,
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Product Condition",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _BuildConditionsByBrand(
                      conditions: state.conditions,
                      brandName: slug,
                    ),
                    ShowFeaturedProducts(brand: slug),
                    ShowBestSellers(brand: slug),
                    
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

class _BuildCategoriesByBrand extends StatelessWidget {
  final String brandName;
  final List<CategoryModel> categories;
  const _BuildCategoriesByBrand({Key key, this.categories, this.brandName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int columnCount = getColumnCount(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: categories.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return CategoryWidget(
            category: categories[index],
            searchByBrand: true,
            brandName: brandName,
          );
        });
  }
}

class _BuildConditionsByBrand extends StatelessWidget {
  final String brandName;
  final List<ConditionModel> conditions;
  const _BuildConditionsByBrand({Key key, this.conditions, this.brandName})
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
            searchByBrand: true,
            brandName: brandName,
          );
        });
  }
}
