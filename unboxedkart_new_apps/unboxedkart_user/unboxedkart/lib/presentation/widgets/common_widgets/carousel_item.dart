import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/models/carousel/carousel_item.model.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';

class CarouselItem extends StatelessWidget {
  final CarouselItemModel carouselItem;
  final bool isVertical;
  final UsageTrackingApi _trackingApi = UsageTrackingApi();

  CarouselItem({Key key, this.carouselItem, this.isVertical = false})
      : super(key: key);

  handleNavigate(BuildContext context) {
    _trackingApi.handleViewedCarouselItem(carouselItem.carouselId);
    if (carouselItem.routeName == null) {
      if (carouselItem.productId != null) {
        Navigator.pushNamed(context, '/product',
            arguments: ProductTile(
              productId: carouselItem.productId,
            ));
      } else {
        print("productcode${carouselItem.productCode}");
        Navigator.pushNamed(context, '/products',
            arguments: ProductsPage(
              title: carouselItem.title,
              // notByTitle: true,
              searchByTitle: false,
              productCode: carouselItem.productCode,
              category: carouselItem.categoryCode,
              brand: carouselItem.brandCode,
              condition: carouselItem.conditionCode,
            ));
      }
    } else {
      // print("route${carouselItem.routeName}");
      Navigator.pushNamed(context, carouselItem.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleNavigate(context);
      },
      child: isVertical
          ? Container(
              margin: const EdgeInsets.all(10),
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  // child: Center(
                  //   child: FadeInImage.assetNetwork(
                  //     placeholder: 'assets/images/placeholder-vertical.png',
                  //     image: 'https://picsum.photos/250?image=9',
                  //   ),
                  // ),
                  child: CachedNetworkImage(
                    // placeholder: 'assets/images/placeholder-horizontal.png',
                    // placeholder: (context, url) {
                    //   return const Image(
                    //       image: AssetImage(
                    //           'assets/images/placeholder-vertical.png'));
                    // },
                    imageUrl: carouselItem.imageUrl,
                  ),
                  // child: Image(
                  //   image: NetworkImage(carouselItem.imageUrl),
                  // ),
                ),
              ),
            )
          : Container(
              margin:
                  const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: carouselItem.imageUrl,
                    // placeholder: 'assets/images/placeholder-horizontal.png',
                    // placeholder: (context, url) => const LoadingSpinnerWidget(),
                    fit: BoxFit.cover,
                  )),
            ),
    );
  }
}
