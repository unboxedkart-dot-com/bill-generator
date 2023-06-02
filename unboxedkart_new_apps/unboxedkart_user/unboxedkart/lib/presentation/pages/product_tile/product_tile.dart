import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/cart_page/cart_bloc.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';
import 'package:unboxedkart/logic/product_tile/producttile_bloc.dart';
import 'package:unboxedkart/logic/user/user_bloc.dart';
import 'package:unboxedkart/models/product/product.dart';
import 'package:unboxedkart/models/reviews/reviews_data.model.dart';
import 'package:unboxedkart/presentation/models/product/product_vertical.dart';
import 'package:unboxedkart/presentation/models/product_specs/individual_product_specs.dart';
import 'package:unboxedkart/presentation/models/question_and_answers/question_and_answers.dart';
import 'package:unboxedkart/presentation/models/review/review.dart';
import 'package:unboxedkart/presentation/pages/cart/cart.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_images.dart';
import 'package:unboxedkart/presentation/pages/product_tile/select-variant.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/ask_question.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/product_q_and_a.dart';
import 'package:unboxedkart/presentation/pages/reviews/product_reviews.dart';
import 'package:unboxedkart/presentation/pages/seller_page/seller_page.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_no_items.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/rating_widget.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ProductTile extends StatefulWidget {
  final String productId;

  const ProductTile({Key key, this.productId}) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  String productTitle = '';
  final CustomAlertPopup _customPopup = CustomAlertPopup();
  UsageTrackingApi _usageTrackingApi = UsageTrackingApi();

  final LocalRepository _localRepo = LocalRepository();

  bool isAuthenticated = false;
  bool isFavorite = false;
  bool isAddedToCart = false;

  showCustomLoginPopup(title) {
    return _customPopup.show(
      title: "$title",
      buttonOneText: "Login",
      context: context,
      buttonOneFunction: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/login');
      },
    );
  }

  checkItemInWishlist() async {
    if (await _localRepo.checkForItemInWishlist(widget.productId)) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  checkItemInCart() async {
    if (await _localRepo.checkForItemInCart(widget.productId)) {
      setState(() {
        isAddedToCart = true;
      });
    }
  }

  getAuthenticationStatus() async {
    isAuthenticated = await _localRepo.getAuthStatus();
  }

  @override
  void initState() {
    getAuthenticationStatus();

    checkItemInWishlist();
    checkItemInCart();
    super.initState();
  }

  List _buildOrderItems() {
    List orderItems = [];
    orderItems.add({"productId": widget.productId, "productCount": 1});
    return orderItems;
  }

  _handlePushToOrderSummary() async {
    isAuthenticated = await _localRepo.getAuthStatus();
    if (isAuthenticated) {
      _handleTrackBuyNow();
      BlocProvider.of<OrdersummaryBloc>(context)
          .add(AddOrderSummaryItem(orderItems: _buildOrderItems()));
      Navigator.pushNamed(context, '/order-summary');
    } else {
      showCustomLoginPopup("Please login to buy an product.");
    }
  }

  _handleNeedMoreDiscount() {
    _usageTrackingApi.handleNeedMoreDiscount(widget.productId);
  }

  _handleTrackBuyNow() async {
    await _usageTrackingApi.handleClickedOnBuyNow(widget.productId);
  }

  _handleAddProductToCart() async {
    isAuthenticated = await _localRepo.getAuthStatus();
    if (isAuthenticated) {
      setState(() {
        isAddedToCart = true;
      });
      BlocProvider.of<CartBloc>(context)
          .add(AddCartItem(productId: widget.productId));
    } else {
      showCustomLoginPopup("Please login to add item to cart.");
    }
  }

  _handleAddProductToWishlist() async {
    isAuthenticated = await _localRepo.getAuthStatus();

    if (isAuthenticated) {
      setState(() {
        isFavorite = true;
      });
      BlocProvider.of<UserBloc>(context).add(AddFavoriteItem(widget.productId));
    } else {
      showCustomLoginPopup("Please login to add an item in wishlist.");
    }
  }

  _handleGoToCart() async {
    isAuthenticated = await _localRepo.getAuthStatus();
    if (isAuthenticated) {
      Navigator.pushNamed(context, '/cart',
          arguments: Cart(
            enableBack: true,
          ));
    } else {
      showCustomLoginPopup("Please login to view cart items.");
    }
  }

  _handleRemoveProductFromWishlist() async {
    isAuthenticated = await _localRepo.getAuthStatus();
    if (isAuthenticated) {
      setState(() {
        isFavorite = false;
      });
      BlocProvider.of<UserBloc>(context)
          .add(RemoveFavoriteItem(widget.productId));
    } else {
      showCustomLoginPopup("Please login to remove an item from wishlist.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: '',
          enableBack: true,
          enableSearchBar: true,
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: BlocProvider(
        create: (context) => ProducttileBloc()
          ..add(LoadProductTile(productId: widget.productId)),
        child: BlocBuilder<ProducttileBloc, ProducttileState>(
          builder: (context, state) {
            if (state is ProductTileLoadingState) {
              return const LoadingSpinnerWidget();
              // return Text("hoole");
            } else if (state is ProductTileLoadedState) {
              productTitle = state.product.title;
              return ListView(
                shrinkWrap: true,
                children: [
                  _ShowProductImages(
                    imageUrls: state.product.imageUrls.images,
                  ),
                  _ShowProductTitle(
                    title: state.product.title,
                    rating: state.product.rating,
                    pricing: state.product.pricing,
                    icon: isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    function: () => isFavorite
                        ? _handleRemoveProductFromWishlist()
                        : _handleAddProductToWishlist(),
                  ),
                  _ShowOffers(),
                  // _ShowVariantsWidget(
                  //   productCode: state.product.productCode,
                  //   categoryCode: state.product.categoryCode,
                  //   grade: state.product.condition,
                  //   color: state.product.moreDetails.color,
                  //   storage: state.product.moreDetails.storage,
                  // ),
                  // _ShowAboutCondition(
                  //   condition: "UNBOXED",
                  // ),

                  ElevatedContainer(
                    elevation: 0,
                    // customPadding: 6,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/conditions/detailed-horizontal/${state.product.conditionCode}-detailed.png'),
                    ),
                  ),
                  _ShowAboutProduct(
                    aboutProduct: state.product.aboutProduct,
                  ),
                  _ShowProductHighlights(highlights: state.product.highlights),
                  _BoxContainsWidget(
                    boxContains: state.product.boxContains,
                  ),
                  state.product.warrantyDetails.isUnderWarranty
                      ? _WarrantyDetailsWidget(
                          warrantyDescription:
                              state.product.warrantyDetails.description,
                          warrantyLeft:
                              state.product.warrantyDetails.warrantyLeft,
                        )
                      : const SizedBox(),
                  state.product.quantity == 0
                      ? CustomSizedTextBox(
                          addPadding: true,
                          textContent: "Currently, out of stock",
                          fontSize: 15,
                          isBold: true,
                          color: Colors.red,
                        )
                      : const SizedBox(),

                  _customButton(
                      title: " 🎊 NEED MORE DISCOUNT ? 🎊",
                      // color: "yellow",
                      titleColor: CustomColors.yellow,
                      function: () => _handleNeedMoreDiscount()),
                  // _customButton(
                  //     title: " 🎊 Need More Discount 🎊",
                  //     // color: "yellow",
                  //     titleColor: CustomColors.yellow,
                  //     function: () => _handleNeedMoreDiscount()),
                  state.product.quantity > 0
                      ? _customButton(
                          title: isAddedToCart ? "Go to Cart" : "Add to Cart",
                          function: () {
                            isAddedToCart
                                ? _handleGoToCart()
                                : _handleAddProductToCart();
                          },
                        )
                      : _customButton(
                          title: "Notify me",
                          function: () {
                            isAddedToCart
                                ? _handleGoToCart()
                                : _handleAddProductToCart();
                          },
                        ),
                  state.product.quantity > 0
                      ? _customButton(
                          title: "Buy now",
                          function: () => _handlePushToOrderSummary(),
                        )
                      : _customButton(
                          title: "Show similar",
                          function: () => _handlePushToOrderSummary(),
                        ),

                  _ShowProductSpecs(
                    productId: widget.productId,
                  ),
                  _ShowRatingsAndReviews(
                    productId: widget.productId,
                  ),
                  _ShowSellerDetails(
                    sellerId: state.product.sellerId,
                    sellerName: state.product.sellerName,
                  ),
                  _ShowQuestionsAndAnswers(
                    productId: state.product.id,
                    isAuthenticated: isAuthenticated,
                  ),
                  _ShowSimilarProducts(productId: widget.productId),
                  _ShowRelatedProducts(
                    productId: widget.productId,
                  )
                ],
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        ),
      ),
    );
  }
}

class _ShowProductTitleAndPricing extends StatefulWidget {
  final String title;
  final String productId;
  final Pricing price;
  final bool isFavorite;
  final Function toggleFavorite;
  final double rating;

  const _ShowProductTitleAndPricing(
      {Key key,
      this.title,
      this.productId,
      this.price,
      this.isFavorite,
      this.toggleFavorite,
      this.rating})
      : super(key: key);

  @override
  State<_ShowProductTitleAndPricing> createState() =>
      _ShowProductTitleAndPricingState();
}

class _ShowProductTitleAndPricingState
    extends State<_ShowProductTitleAndPricing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
              textContent: widget.title,
              isBold: true,
              addPadding: true,
              paddingWidth: 10),
          const RatingWidget(
            rating: 4,
          ),
          // Container(
          //   padding: const EdgeInsets.all(2),
          //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(5)),
          //     color: Colors.green,
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          //     child: CustomSizedTextBox(
          //       textContent: '${widget.rating} ★',
          //       fontSize: 12,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomSizedTextBox(
                        textContent: '₹${widget.price.sellingPrice}',
                        fontSize: 20,
                        isBold: true),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomSizedTextBox(
                        textContent: '₹${widget.price.price}',
                        fontSize: 20,
                        isBold: true,
                        color: Colors.grey[800],
                        isLineThrough: true),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomSizedTextBox(
                        textContent:
                            '₹${widget.price.price - widget.price.sellingPrice} off',
                        fontSize: 18,
                        isBold: true,
                        color: Colors.green),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      widget.toggleFavorite();
                    },
                    icon: Icon(
                      widget.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: CustomColors.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ShowProductImages extends StatefulWidget {
  final List imageUrls;

  const _ShowProductImages({Key key, this.imageUrls}) : super(key: key);

  @override
  State<_ShowProductImages> createState() => _ShowProductImagesState();
}

class _ShowProductImagesState extends State<_ShowProductImages> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.width,
              child: PageView.builder(
                  itemCount: widget.imageUrls.length,
                  onPageChanged: (val) {
                    setState(() {
                      imageIndex = val;
                    });
                  },
                  itemBuilder: (item, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/product-images',
                            arguments: ProductImages(
                                imageUrls: widget.imageUrls, index: index));
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrls[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  })),
          Container(
            color: Colors.white,
            height: 18.0,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: widget.imageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: imageIndex == index
                            ? const Color.fromRGBO(0, 0, 0, 0.9)
                            : const Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                })),
          )
        ],
      ),
    );
  }
}

class _ShowProductTitle extends StatelessWidget {
  final String title;
  final num rating;
  final pricing;
  final IconData icon;
  final Function function;

  const _ShowProductTitle(
      {Key key,
      this.pricing,
      this.icon,
      this.function,
      this.title,
      this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomSizedTextBox(
              textContent: title,
              isBold: true,
            ),
          ),
          rating > 0
              ? RatingWidget(
                  rating: rating,
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomSizedTextBox(
                      textContent: '₹${pricing.sellingPrice}',
                      fontSize: 20,
                      isBold: true),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomSizedTextBox(
                      textContent: '₹${pricing.price}',
                      fontSize: 20,
                      isBold: true,
                      color: Colors.grey[800],
                      isLineThrough: true),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomSizedTextBox(
                      textContent:
                          '₹${pricing.price - pricing.sellingPrice} off',
                      fontSize: 18,
                      isBold: true,
                      color: Colors.green),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    function();
                  },
                  icon: Icon(
                    icon,
                    color: CustomColors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShowProductVariants extends StatelessWidget {
  const _ShowProductVariants({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _OfferWidget extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _OfferWidget({Key key, this.title, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              width: MediaQuery.of(context).size.width * 0.11,
              height: MediaQuery.of(context).size.width * 0.11,
              image: AssetImage(imageUrl),
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSizedTextBox(
              isCenter: true,
              textContent: title,
              fontSize: 10,
              isBold: true,
            )
          ]),
    );
  }
}

variantWidget(BuildContext context, {String title, Function function}) {
  return GestureDetector(
    onTap: () => function(),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 30,
            child: Center(
              child: CustomSizedTextBox(
                textContent: title,
                fontSize: 14,
                isBold: true,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _ShowVariantsWidget extends StatelessWidget {
  final String productCode;
  final String categoryCode;
  final String grade;
  final String color;
  final String storage;

  const _ShowVariantsWidget(
      {Key key,
      this.grade,
      this.color,
      this.storage,
      this.categoryCode,
      this.productCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            addPadding: true,
            isBold: true,
            textContent: "Product Variant",
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              variantWidget(context, title: grade),
              variantWidget(context, title: color),
              variantWidget(context, title: storage),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/product-variants',
                      arguments: ProductVariants(
                        productCode: productCode,
                        categoryCode: categoryCode,
                      ));
                },
                child: CustomSizedTextBox(
                    textContent: "Change",
                    isBold: true,
                    color: CustomColors.blue),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ShowOffers extends StatelessWidget {
  // final bool isCertified;

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _OfferWidget(
            title: "Same day pickup",
            imageUrl: "assets/images/product/same_day_pickup.png",
          ),
          _OfferWidget(
            title: "Pay at store",
            imageUrl: "assets/images/product/pay_at_store.png",
          ),
          _OfferWidget(
            title: "Unboxedkart Certified",
            imageUrl: "assets/images/product/unboxedkart_certified.png",
          )
        ],
      ),
    );
  }
}

class _ShowProductHighlights extends StatelessWidget {
  final List highlights;

  const _ShowProductHighlights({Key key, this.highlights}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return highlights.isNotEmpty
        ? ElevatedContainer(
            elevation: 0,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CustomSizedTextBox(
                          textContent: 'Highlights',
                          fontSize: 16,
                          isBold: true),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: highlights
                          .map((e) => CustomSizedTextBox(
                                textContent: '• ${e.trim()}',
                              ))
                          .toList(),
                    ),
                  ],
                )))
        : const SizedBox();
  }
}

class _ShowAboutCondition extends StatelessWidget {
  final String condition;
  const _ShowAboutCondition({Key key, this.condition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Know More About ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'T MS',
                          fontSize: 16)),
                  TextSpan(
                      text: condition,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'T MS',
                          fontSize: 16,
                          color: CustomColors.blue)),
                ]),
              ),
              // CustomSizedTextBox(
              //     textContent: 'Know more about', fontSize: 16, isBold: true),
              const SizedBox(
                height: 5,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: aboutProduct
              //       .map((e) => CustomSizedTextBox(
              //             textContent: '• ${e.trim()}',
              //           ))
              //       .toList(),
              // ),
            ],
          ),
        ));
  }
}

class _ShowAboutProduct extends StatelessWidget {
  final List aboutProduct;

  const _ShowAboutProduct({Key key, this.aboutProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSizedTextBox(
                  textContent: 'About product', fontSize: 16, isBold: true),
              const SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: aboutProduct
                    .map((e) => CustomSizedTextBox(
                          textContent: '• ${e.trim()}',
                        ))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}

class _ShowSellerDetails extends StatelessWidget {
  final String sellerName;
  final String sellerId;

  const _ShowSellerDetails({Key key, this.sellerName, this.sellerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/seller-page',
            arguments: SellerPage(
              sellerId: sellerId,
              sellerName: sellerName,
            ));
      },
      child: ElevatedContainer(
        elevation: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: [
                const TextSpan(
                    text: 'Sold by ',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'T MS',
                        color: Colors.black)),
                TextSpan(
                    text: sellerName,
                    style: const TextStyle(
                        color: CustomColors.blue,
                        fontFamily: 'T MS',
                        fontWeight: FontWeight.bold)),
                const TextSpan(
                    text: " and ", style: TextStyle(color: Colors.black)),
                const TextSpan(
                    text: 'Fulfilled by Unboxedkart',
                    style: TextStyle(
                        color: CustomColors.blue,
                        fontFamily: 'T MS',
                        fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _BoxContainsWidget extends StatelessWidget {
  final String boxContains;

  const _BoxContainsWidget({Key key, this.boxContains}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          CustomSizedTextBox(
              textContent: "What is included ?", fontSize: 16, isBold: true),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedTextBox(
                textContent: boxContains,
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class _WarrantyDetailsWidget extends StatelessWidget {
  final int warrantyLeft;
  final String warrantyDescription;

  const _WarrantyDetailsWidget(
      {Key key, this.warrantyLeft, this.warrantyDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          CustomSizedTextBox(
              textContent: "Warranty details", fontSize: 16, isBold: true),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CustomSizedTextBox(textContent: warrantyDescription)],
          ),
        ]),
      ),
    );
  }
}

class _customButton extends StatelessWidget {
  final Function function;
  final String title;
  final String color;
  final Color titleColor;

  const _customButton(
      {Key key,
      this.function,
      this.title,
      this.color,
      this.titleColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: function,
        child: Container(
            height: 45,
            decoration: BoxDecoration(
                color: color == "yellow"
                    ? Colors.yellow.shade700
                    : CustomColors.blue,
                borderRadius: BorderRadius.circular(6)),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: CustomSizedTextBox(
                    textContent: title,
                    fontSize: 16,
                    isBold: true,
                    color: titleColor),
              ),
            )),
      ),
    );
  }
}

class _ShowQuestionsAndAnswers extends StatelessWidget {
  final String productId;
  final bool isAuthenticated;

  _ShowQuestionsAndAnswers({Key key, this.productId, this.isAuthenticated})
      : super(key: key);
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  showCustomPopup(BuildContext context, String title) async {
    return _customPopup.show(
      title: title,
      buttonOneText: "Login",
      buttonTwoText: "Dismiss",
      context: context,
      buttonOneFunction: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProducttileBloc()..add(LoadProductQandA(productId)),
        child: BlocBuilder<ProducttileBloc, ProducttileState>(
          builder: (context, state) {
            if (state is ProductQuestionsAndAnswersLoaded) {
              return ElevatedContainer(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSizedTextBox(
                          addPadding: true,
                          paddingWidth: 8,
                          textContent: "Questions and answers",
                          isBold: true,
                          fontSize: 14,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (isAuthenticated == true) {
                              Navigator.pushNamed(context, '/ask-question',
                                  arguments: AskQuestion(
                                    productId: productId,
                                  ));
                            } else {
                              showCustomPopup(context,
                                  "Please login using your credentials to ask questions");
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(color: CustomColors.blue)),
                            child: CustomSizedTextBox(
                              textContent: "Ask a question ?",
                              isBold: true,
                              color: CustomColors.blue,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    state.questionAndAnswers.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: state.questionAndAnswers.length,
                                  itemBuilder: (context, index) {
                                    return QuestionAndAnswers(
                                        questionAndAnswers:
                                            state.questionAndAnswers[index]);
                                  }),
                              state.questionAndAnswers.length > 4
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 2, bottom: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/product-q-and-a',
                                              arguments: ProductQandAPage(
                                                productId: productId,
                                              ));
                                        },
                                        child: CustomSizedTextBox(
                                            textContent:
                                                "Show more questions & answers",
                                            isBold: true,
                                            fontSize: 14,
                                            color: CustomColors.blue),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          )
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CustomNoWidget(
                                title: "No questions asked",
                                icon: Icons.question_mark_sharp,
                                iconSize: 40),
                          )
                  ],
                ),
              );
            } else {
              return const CustomLoadingWidget(
                title: "Question and answers",
              );
            }
          },
        ));
  }
}

class IndividualReviewWidget extends StatelessWidget {
  final int rating;
  final totalRatingsCount;
  final int currentRatingsTotal;
  final Color color;

  const IndividualReviewWidget(
      {Key key,
      this.rating,
      this.totalRatingsCount,
      this.currentRatingsTotal,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fillPercentage = (currentRatingsTotal * 2 / totalRatingsCount * 2);
    return Row(
      children: [
        CustomSizedTextBox(
            textContent: '$rating ★', fontSize: 12, isBold: true),
        Container(
            margin: const EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width * 0.3,
            child: LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              percent: fillPercentage > 1 ? 1 : fillPercentage,
              backgroundColor: Colors.white,
              fillColor: Colors.grey,
              progressColor: color,
            ))
      ],
    );
  }
}

class AverageRatingWidget extends StatelessWidget {
  final ReviewsDataModel reviewsData;
  const AverageRatingWidget({Key key, this.reviewsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedTextBox(
              addPadding: true,
              textContent: "Ratings & Reviews",
              fontSize: 14,
              isBold: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    alignment: Alignment.center,
                    child: Align(
                        alignment: Alignment.center,
                        child: CustomSizedTextBox(
                            textContent:
                                '${reviewsData.averageRating.toStringAsFixed(1)} ★',
                            fontSize: 30,
                            isBold: true,
                            color: Colors.black))),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IndividualReviewWidget(
                          color: Colors.green,
                          rating: 5,
                          currentRatingsTotal: reviewsData.fiveStarCount,
                          totalRatingsCount: reviewsData.totalReviewsCount,
                        ),
                        IndividualReviewWidget(
                          color: Colors.green,
                          rating: 4,
                          currentRatingsTotal: reviewsData.fourStarCount,
                          totalRatingsCount: reviewsData.totalReviewsCount,
                        ),
                        IndividualReviewWidget(
                          color: Colors.green,
                          rating: 3,
                          currentRatingsTotal: reviewsData.threeStarCount,
                          totalRatingsCount: reviewsData.totalReviewsCount,
                        ),
                        IndividualReviewWidget(
                          color: Colors.red,
                          rating: 2,
                          currentRatingsTotal: reviewsData.twoStarCount,
                          totalRatingsCount: reviewsData.totalReviewsCount,
                        ),
                        IndividualReviewWidget(
                          color: Colors.red,
                          rating: 1,
                          currentRatingsTotal: reviewsData.oneStarCount,
                          totalRatingsCount: reviewsData.totalReviewsCount,
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ));
  }
}

class _ShowRatingsAndReviews extends StatelessWidget {
  final String productId;

  const _ShowRatingsAndReviews({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProducttileBloc()..add(LoadProductReviews(productId)),
        child: BlocBuilder<ProducttileBloc, ProducttileState>(
          builder: (context, state) {
            if (state is ProductReviewsLoaded) {
              print("reviews loaded");
              if (state.reviewsData != null) {
                return ElevatedContainer(
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AverageRatingWidget(
                        reviewsData: state.reviewsData,
                      ),
                      const Divider(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.productReviews.length,
                          itemBuilder: (context, index) {
                            return Review(review: state.productReviews[index]);
                          }),
                      const Divider(
                        height: 1,
                      ),
                      state.productReviews.length > 5
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/product-reviews',
                                    arguments: ProductReviewsPage(
                                        productId: productId));
                              },
                              child: CustomSizedTextBox(
                                  textContent: "Show more reviews",
                                  isBold: true,
                                  addPadding: true,
                                  fontSize: 14,
                                  color: CustomColors.blue),
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
                // return Column(
                //   children: [
                //     const CustomLoadingWidget(
                //       title: "Ratings and Reviews",
                //     ),
                //     CustomSizedTextBox(
                //       textContent: "Not Enough Ratings",
                //     )
                //   ],
                // );
                // return const SizedBox();
              }
            } else {
              return const SizedBox();
              // return const CustomLoadingWidget(
              //   title: "Ratings and Reviews",
              // );
            }
          },
        ));
  }
}

class _ShowProductSpecs extends StatelessWidget {
  final String productId;

  const _ShowProductSpecs({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProducttileBloc()..add(LoadProductSpecs(productId)),
      child: BlocBuilder<ProducttileBloc, ProducttileState>(
        builder: (context, state) {
          if (state is ProductSpecsLoaded) {
            return ElevatedContainer(
              elevation: 0,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    state.productSpecs != null ? state.productSpecs.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return IndividualProductSpecs(
                    individualProductSpecs: state.productSpecs[index],
                  );
                },
              ),
            );
          } else {
            return const CustomLoadingWidget(
              title: "Products Specifications",
            );
          }
        },
      ),
    );
  }
}

class _ShowSimilarProducts extends StatelessWidget {
  final String productId;

  const _ShowSimilarProducts({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
            textContent: "Similar Products",
            isBold: true,
            fontSize: 18,
            addPadding: true,
          ),
          BlocProvider(
            create: (context) =>
                ProducttileBloc()..add(LoadSimilarProducts(productId)),
            child: BlocBuilder<ProducttileBloc, ProducttileState>(
              builder: (context, state) {
                if (state is SimilarProductsLoaded) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.similarProducts.length,
                        itemBuilder: (context, index) {
                          return ProductVertical(
                              product: state.similarProducts[index]);
                        }),
                  );
                } else {
                  return const CustomLoadingWidget(title: "Similar products");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowRelatedProducts extends StatelessWidget {
  final String productId;

  const _ShowRelatedProducts({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedTextBox(
          textContent: "Related Products",
          isBold: true,
          fontSize: 18,
          addPadding: true,
        ),
        BlocProvider(
          create: (context) =>
              ProducttileBloc()..add(LoadRelatedProducts(productId)),
          child: BlocBuilder<ProducttileBloc, ProducttileState>(
            builder: (context, state) {
              if (state is RelatedProductsLoaded) {
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.relatedProducts.length,
                      itemBuilder: (context, index) {
                        return ProductVertical(
                            product: state.relatedProducts[index]);
                      }),
                );
              } else {
                return const CustomLoadingWidget(
                  title: "Related products",
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomLoadingWidget extends StatelessWidget {
  final String title;

  const CustomLoadingWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomSizedTextBox(
          addPadding: true,
          paddingWidth: 8,
          textContent: title,
          isBold: true,
          fontSize: 14,
        ),
        const SizedBox(
          height: 40,
        ),
        const Center(child: CupertinoActivityIndicator()),

        // const Center(
        //     // child: CupertinoActivityIndicator(),
        //     // child : Skelton()
        //     child: Skeleton(
        //   isLoading: true,
        // )),
        const SizedBox(
          height: 40,
        ),
      ]),
    );
  }
}
