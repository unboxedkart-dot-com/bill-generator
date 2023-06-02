import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';

class ProductImages extends StatelessWidget {
  final List<dynamic> imageUrls;
  int index;

  ProductImages({
    Key key,
    this.imageUrls,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: index ?? 0);
    return CustomScaffold(
      pageTitle: "Product Images",
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: ((context, index) {
            return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4,
                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                ));
          }),
          itemCount: imageUrls.length,
        ),
      ),
    );
  }
}
