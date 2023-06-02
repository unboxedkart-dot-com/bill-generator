import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/presentation/pages/cart/cart.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class CustomAppBar extends StatelessWidget {
  bool enableBack;
  String title;
  Color backgroundColor;
  bool enableSearchBar;
  bool showLogo;
  bool isSearchPage;
  bool customBack;
  final Function customBackFunction;

  CustomAppBar(
      {Key key,
      this.enableBack = true,
      this.title,
      this.backgroundColor = Colors.white,
      this.enableSearchBar = false,
      this.showLogo = false,
      this.isSearchPage = false,
      this.customBack = false,
      this.customBackFunction})
      : super(key: key);

   

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: enableBack
            ? GestureDetector(
                onTap: () {
                   
                  customBack
                      ? customBackFunction()
                      : Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : const SizedBox(),
        centerTitle: enableBack ? false : true,
        backgroundColor: CustomColors.blue,
        titleSpacing: 0,
        leadingWidth: 50,
        title: showLogo
            ? Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Image(
                      height: 35,
                      width: 35,
                       
                      image: AssetImage(
                          'assets/images/featured_images/logo-transparent.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomSizedTextBox(
                    textContent: "Unboxedkart",
                    color: Colors.white,
                    fontSize: 25,
                    fontName: 'Alegreya Sans',
                  ),
                ],
              )
            : Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
        actions: enableSearchBar
            ? [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: () {
                        isSearchPage
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(context, '/search');
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
