import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/condition/condition_bloc.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/category/category.model.dart';
import 'package:unboxedkart/presentation/carousels/show-carousel.dart';
import 'package:unboxedkart/presentation/models/brand/brand.dart';
import 'package:unboxedkart/presentation/models/category/category.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_best_sellers.dart';
import 'package:unboxedkart/presentation/pages/products_page/show_featured_products.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ConditionPage extends StatelessWidget {
  final String conditionName;
  final String slug;
  const ConditionPage({Key key, this.conditionName, this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("slug");
    print(slug);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: conditionName,
          enableSearchBar: true,
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: BlocProvider(
          create: (context) => ConditionBloc()..add(LoadData(slug)),
          child: BlocBuilder<ConditionBloc, ConditionState>(
            builder: (context, state) {
              if (state is ConditionPageLoadingState) {
                return const LoadingSpinnerWidget();
              } else if (state is ConditionPageLoadedState) {
                return ListView(
                  children: [
                    ElevatedContainer(
                      elevation: 0,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                           'assets/images/conditions/detailed-horizontal/${slug}-detailed.png'),
                            // 'assets/images/conditions/$slug-detailed.png'),
                      ),
                    ),
                    ShowCarouselItems(
                      isVertical: true,
                      placement: 'condition/$slug',
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Brand",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _BuildBrandsByCondition(
                      brands: state.brands,
                      conditionName: slug,
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Category",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _BuildCategoriesByCondition(
                      categories: state.categories,
                      conditionName: slug,
                    ),
                    ShowFeaturedProducts(condition: slug),
                    ShowBestSellers(condition: slug),
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

class _BuildBrandsByCondition extends StatelessWidget {
  final List<BrandModel> brands;
  final String conditionName;
  const _BuildBrandsByCondition({Key key, this.brands, this.conditionName})
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
            searchByCondition: true,
            conditionName: conditionName,
          );
        });
  }
}

class _BuildCategoriesByCondition extends StatelessWidget {
  final List<CategoryModel> categories;
  final String conditionName;
  const _BuildCategoriesByCondition(
      {Key key, this.categories, this.conditionName})
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
        itemCount: categories.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return CategoryWidget(
            category: categories[index],
            searchByCondition: true,
            conditionName: conditionName,
          );
        });
  }
}
