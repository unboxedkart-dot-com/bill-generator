import 'package:flutter/material.dart';

class CarouselPlaceholder extends StatelessWidget {
  final bool isVertical;

  const CarouselPlaceholder({Key key, this.isVertical = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Material(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Center(
                      child: Image(
                          image: AssetImage(
                              'assets/images/placeholder-vertical.png')),
                    ),
                  ),
                )

                // Image(
                //     image: AssetImage('assets/images/placeholder-vertical.png')),
                ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Material(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Center(
                      child: Image(
                          image: AssetImage(
                              'assets/images/placeholder-horizontal.png')),
                    ),
                  ),
                )

                // Image(
                //     image: AssetImage('assets/images/placeholder-vertical.png')),
                ),
          );
  }
}
