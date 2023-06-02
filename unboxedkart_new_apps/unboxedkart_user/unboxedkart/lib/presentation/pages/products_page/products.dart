import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/products_page/products_bloc.dart';
import 'package:unboxedkart/logic/products_page/products_event.dart';
import 'package:unboxedkart/logic/products_page/products_state.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/presentation/models/product/product_horizontal.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ProductsPage extends StatefulWidget {
  String title;
  String category;
  String brand;
  String condition;
  String productCode;
  int pageNumber;
  bool searchByTitle;
  // final bool isExact

  ProductsPage(
      {Key key,
      this.title,
      this.category,
      this.brand,
      this.condition,
      this.pageNumber,
      this.productCode,
      this.searchByTitle = true});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String appBarTitle;
  List<ProductModel> products = [];
  bool isLoading = false;
  ProductsPageBloc productsBloc = ProductsPageBloc();

  final scrollController = ScrollController();

  void setupScrollController(context) {
    print(
        "props ${widget.title} ${widget.category} ${widget.brand} ${widget.condition} ${widget.pageNumber} ${widget.productCode} ${widget.searchByTitle}");
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          isLoading = true;
          print("loading more products");
          productsBloc.add(LoadProductsPage(
              title: widget.title != null
                  ? widget.title.replaceAll(' ', '')
                  : null,
              category: widget.category,
              brand: widget.brand,
              condition: widget.condition,
              pageNumber: widget.pageNumber,
              productCode: widget.productCode));
        }
      }
    });
  }

  getAppBarTitle() {
    if (widget.productCode != null) {
      appBarTitle = widget.productCode.replaceAll('-', "");
    }
    if (widget.title != null) {
      appBarTitle = widget.title;
    } else if (widget.brand != null && widget.category != null) {
      appBarTitle = ' ${widget.category} ( ${widget.brand} )';
    } else if (widget.brand != null && widget.condition != null) {
      appBarTitle = widget.brand;
    } else if (widget.category != null && widget.condition != null) {
      appBarTitle = widget.category;
    }
  }

  @override
  void initState() {
    getAppBarTitle();
    setupScrollController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          isSearchPage: true,
          title: appBarTitle,
          enableSearchBar: true,
        ),
      ),
      body: BlocProvider(
        create: (context) => productsBloc
          ..add(
            LoadProductsPage(
                title: widget.searchByTitle ? widget.title : null,
                category: widget.category,
                brand: widget.brand,
                condition: widget.condition,
                pageNumber: widget.pageNumber,
                productCode: widget.productCode),
          ),
        child: Scaffold(body: Center(
          child: BlocBuilder<ProductsPageBloc, ProductsPageState>(
            builder: (context, state) {
              if (state is ProductsPageLoadingState) {
                if (state.isFirstFetch) {
                  return const LoadingSpinnerWidget();
                } else {
                  products = state.oldProducts;

                  isLoading = true;
                }
              } else if (state is ProductsPageLoadedState) {
                isLoading = false;

                products = state.searchedProducts;
              }
              if (products.isNotEmpty) {
                return ListView.builder(
                    controller: scrollController,
                    itemCount: products.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        return ProductHorizontal(product: products[index]);
                      } else {
                        Timer(const Duration(milliseconds: 30), () {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: LoadingSpinnerWidget(),
                        );
                      }
                    });
              } else {
                return const ShowCustomPage(
                  icon: CupertinoIcons.bag,
                  title:
                      "Sorry, we couldn't find any similar products. Please try searching for other products",
                );
              }
            },
          ),
        )),
      ),
    );
  }
}

class _BuildNoProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.bag,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'No products',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
