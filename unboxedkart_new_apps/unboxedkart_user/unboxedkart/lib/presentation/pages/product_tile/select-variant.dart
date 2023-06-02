import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/dtos/get-selected-variant.dto.dart';
import 'package:unboxedkart/logic/product_tile/producttile_bloc.dart';
import 'package:unboxedkart/models/product_details/product-variants-data.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ProductVariants extends StatefulWidget {
  final String productCode;
  final String categoryCode;

  const ProductVariants({Key key, this.productCode, this.categoryCode})
      : super(key: key);
  @override
  State<ProductVariants> createState() => _ProductVariantsState();
}

class _ProductVariantsState extends State<ProductVariants> {
  ProducttileBloc productsBloc = ProducttileBloc();
  ProductVariantsData productVariants;
  bool hasCombinations = false;
  String selectedColor;
  String selectedStorage;
  String selectedCondition;
  String selectedProcessor;
  String selectedColorCode;
  String selectedStorageCode;
  String selectedConditionCode;
  String selectedProcessorCode;
  String selectedRam;
  String selectedRamCode;
  String selectedScreenSizeCode;
  String selectedCombinationCode;
  String selectedCombination;
  String screenSize;
  bool errorShown = false;

  final CustomAlertPopup _customPopup = CustomAlertPopup();

  showCustomPopUp(String title) {
    return _customPopup.show(
        title: title,
        buttonOneText: "Dismiss",
        buttonTwoText: "Okay",
        context: context,
        buttonOneFunction: () =>
            productsBloc.add(const LoadProductvariants('samsung-galaxy-s10')));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "Select variant",
      bottomButton: CustomBottomButton(
        title: "Search product",
        function: () {
          productsBloc.add(LoadSelectedVariant(GetSelectedVariantDto(
              productCode: 'apple-iphone-11',
              conditionCode: selectedConditionCode,
              storageCode: selectedStorageCode,
              processorCode: selectedProcessorCode,
              colorCode: 'black',
              ramCode: selectedRamCode,
              combinationCode: selectedCombinationCode,
              screenSizeCode: selectedScreenSizeCode)));
        },
      ),
      child: BlocProvider(
          create: (context) =>
              productsBloc..add(LoadProductvariants(widget.productCode)),
          child: BlocBuilder<ProducttileBloc, ProducttileState>(
            builder: (context, state) {
              if (state is ProductVariantsLoaded) {
                hasCombinations =
                    state.variantsData.combinations.isNotEmpty ? true : false;
                productVariants = state.variantsData;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    _ShowVariantsList(
                        items: state.variantsData.conditions,
                        title: "Product condition",
                        selectedValue: selectedCondition,
                        function: (code, value) {
                          setState(() {
                            selectedCondition = value;
                            selectedConditionCode = code;
                          });
                        }),
                    _ShowVariantsList(
                        items: state.variantsData.colors,
                        title: "Color",
                        selectedValue: selectedColor,
                        function: (code, value) {
                          setState(() {
                            selectedColor = value;
                            selectedColorCode = code;
                          });
                        }),
                    !hasCombinations
                        ? _ShowVariantsList(
                            items: state.variantsData.storages,
                            title: "Storage",
                            selectedValue: selectedStorage,
                            function: (code, value) {
                              setState(() {
                                selectedStorage = value;
                                selectedStorageCode = code;
                              });
                            })
                        : const SizedBox(),
                    _ShowVariantsList(
                        items: state.variantsData.processors,
                        title: "Processor",
                        selectedValue: selectedProcessor,
                        function: (VariantData variant) {
                          setState(() {
                            selectedProcessor = variant.title;
                            selectedProcessorCode = variant.code;
                          });
                        }),
                    !hasCombinations
                        ? _ShowVariantsList(
                            items: state.variantsData.rams,
                            title: "Rams",
                            selectedValue: selectedRam,
                            function: (VariantData variant) {
                              setState(() {
                                selectedRam = variant.title;
                                selectedRamCode = variant.code;
                              });
                            })
                        : const SizedBox(),
                    _ShowVariantsList(
                        items: state.variantsData.combinations,
                        title: "Combinations",
                        selectedValue: selectedCombination,
                        function: (code, value) {
                          setState(() {
                            selectedCombination = value;
                            selectedConditionCode = code;
                          });
                        }),
                  ],
                );
              } else if (state is SelectedProductVariantLoaded) {
                if (state.productId == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showCustomPopUp("could not find product");
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, '/product',
                        arguments: ProductTile(
                          productId: state.productId,
                        ));
                  });
                }
              }
              return const LoadingSpinnerWidget();
            },
          )),
    );
  }
}

class _ShowVariantsList extends StatefulWidget {
  final String selectedValue;
  final List<VariantData> items;
  final String title;
  final Function function;

  const _ShowVariantsList(
      {Key key, this.items, this.title, this.function, this.selectedValue})
      : super(key: key);

  @override
  State<_ShowVariantsList> createState() => _ShowVariantsListState();
}

class _ShowVariantsListState extends State<_ShowVariantsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isNotEmpty) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: CustomSizedTextBox(
                  textContent: widget.title, fontSize: 14, isBold: true),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.function(
                          widget.items[index].code, widget.items[index].title);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 10,
                          width: 100,
                          margin: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: widget.selectedValue ==
                                      widget.items[index].title
                                  ? Colors.green
                                  : Colors.white),
                          child: CustomSizedTextBox(
                              textContent: widget.items[index].title,
                              fontSize: 12,
                              isBold: true,
                              color: widget.selectedValue ==
                                      widget.items[index].title
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
          ]);
    } else {
      return const SizedBox();
    }
  }
}

class VariantData {
  final String title;
  final String code;

  VariantData({this.title, this.code});

  factory VariantData.fromDocument(doc) {
    return VariantData(
      title: doc['title'],
      code: doc['code'],
    );
  }
}
