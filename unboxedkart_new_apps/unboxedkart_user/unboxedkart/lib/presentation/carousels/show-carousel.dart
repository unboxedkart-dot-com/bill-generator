import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/category/category_bloc.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/carousel_item.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/carousel_placeholder.dart';

class ShowCarouselItems extends StatelessWidget {
  final bool isVertical;
  final String placement;

  ShowCarouselItems({Key key, this.isVertical = false, this.placement})
      : super(key: key);

  List<CarouselPlaceholder> verticalPlaceHolderItems = [
    const CarouselPlaceholder(
      isVertical: true,
    ),
    const CarouselPlaceholder(
      isVertical: true,
    ),
    const CarouselPlaceholder(
      isVertical: true,
    ),
  ];

  List<CarouselPlaceholder> horizontalPlaceholderItems = [
    const CarouselPlaceholder(
      isVertical: false,
    ),
    const CarouselPlaceholder(
      isVertical: false,
    ),
    const CarouselPlaceholder(
      isVertical: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(viewportFraction: 0.8);
    return BlocProvider(
      create: (context) =>
          CategoryBloc()..add(LoadCategoryCarouselItems('mobile/$placement')),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return SizedBox(
              // height:  isVertical
              //             ? MediaQuery.of(context).size.height * 0.6
              //             : MediaQuery.of(context).size.height * 0.3,
              child: (state is CategoryCarouselItemsLoaded)
                  ? SizedBox(
                      child: isVertical
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: state.carouselItems.length,
                                  itemBuilder: ((context, index) {
                                    return CarouselItem(
                                      carouselItem: state.carouselItems[index],
                                    );
                                  })),
                            )
                          : CarouselSlider(
                              items: state.carouselItems
                                  .map((e) => CarouselItem(
                                        carouselItem: e,
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                  viewportFraction: 1, autoPlay: false)),
                    )
                  :
                  // const SizedBox()

                  isVertical
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: PageView.builder(
                              controller: _pageController,
                              itemCount: verticalPlaceHolderItems.length,
                              itemBuilder: ((context, index) {
                                return verticalPlaceHolderItems[index];
                              })))
                      : CarouselSlider(
                          items: horizontalPlaceholderItems,
                          options: CarouselOptions(
                              viewportFraction: 1, autoPlay: false)));
        },
      ),
    );
  }
}
