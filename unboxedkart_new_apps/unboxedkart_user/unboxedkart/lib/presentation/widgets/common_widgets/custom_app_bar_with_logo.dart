import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/presentation/pages/cart/cart.dart';

class CustomAppBarWithLogo extends StatelessWidget {
  bool enableBack;
  String title;
  Color backgroundColor;
  bool enableSearchBar;

  CustomAppBarWithLogo(
      {Key key,
      this.enableBack = true,
      this.title,
      this.backgroundColor = Colors.white,
      this.enableSearchBar = false})
      : super(key: key);

   

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: enableBack
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 18,
                ),
              )
            : const SizedBox(),
        centerTitle: enableBack ? false : true,
        backgroundColor: CustomColors.blue,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: enableSearchBar
            ? [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      child: const Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/wishlist');
                    },
                    child: const Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cart',
                          arguments: Cart(
                            enableBack: true,
                          ));
                    },
                    child: const Icon(
                      CupertinoIcons.bag,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
            : []);
  }
}
