import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/cart_page/cart_bloc.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';
import 'package:unboxedkart/models/cart_item/cart_item.model.dart';
import 'package:unboxedkart/presentation/models/cart_item/cart_item.dart';
import 'package:unboxedkart/presentation/models/cart_item/save_later.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/show_signin_page.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

 
class Cart extends StatefulWidget {
  bool enableBack;
  Cart({Key key, this.enableBack}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isAuth = false;
  final LocalRepository _localRepo = LocalRepository();

  void _getUserStatus() async {
    bool authStatus = await _localRepo.getAuthStatus();
    setState(() {
      isAuth = authStatus;
    });
  }

  @override
  void initState() {
    _getUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
     

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Cart",
            enableBack: widget.enableBack ? true : false,
          )),
      body: BlocProvider(
        create: (context) => CartBloc()..add(LoadCartItems()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (isAuth) {
              if (state is CartLoadedState) {
                if (state.cartItems.isNotEmpty) {
                  return Scaffold(
                    bottomSheet: _BuildBottomSheet(
                      cartTotal: state.cartTotal,
                      cartItems: state.cartItems,
                    ),
                    body: Container(
                      margin: const EdgeInsets.only(bottom: 80),
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.cartItems.length,
                              itemBuilder: (context, index) {
                                return CartItem(
                                  cartItem: state.cartItems[index],
                                );
                              }),
                          const SizedBox(
                            height: 100,
                          ),
                          state.saveLaterItems.isNotEmpty
                              ? CustomSizedTextBox(
                                  isBold: true,
                                  paddingWidth: 12,
                                  addPadding: true,
                                  textContent:
                                      "Saved for later (${state.saveLaterItems.length})",
                                )
                              : const SizedBox(),
                          state.saveLaterItems.isNotEmpty
                              ? ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.saveLaterItems.length,
                                  itemBuilder: (context, index) {
                                    return SaveLaterProduct(
                                      saveLaterProduct:
                                          state.saveLaterItems[index],
                                    );
                                  })
                              : const SizedBox(),
                          
                        ],
                      ),
                    ),
                  );
                } else if (state.saveLaterItems.isNotEmpty) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ShowCustomPage(
                            title:
                                "Your shopping cart is empty. Please start adding products to your shopping cart.",
                            icon: CupertinoIcons.bag_fill,
                            buttonText: "Start Shopping now",
                            function: () => Navigator.pushNamed(context, '/')),
                      ),
                      CustomSizedTextBox(
                        isBold: true,
                        paddingWidth: 12,
                        addPadding: true,
                        textContent:
                            "Saved for later (${state.saveLaterItems.length})",
                      ),
                      ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.saveLaterItems.length,
                          itemBuilder: (context, index) {
                            return SaveLaterProduct(
                              saveLaterProduct: state.saveLaterItems[index],
                            );
                          }),
                    ],
                  );
                }
                {
                  return ShowCustomPage(
                    title:
                        "Your shopping cart is empty. Please start adding products to your shopping cart.",
                    icon: CupertinoIcons.bag_fill,
                    buttonText: "Start Shopping now",
                    function: () => Navigator.pushNamed(context, '/'),
                  );
                }
              } else {
                return const LoadingSpinnerWidget();
              }
            } else {
              return const ShowSignInPage(
                title:
                    "Your cart is not visible. Please sign in to see your wishlist",
                icon: CupertinoIcons.bag_fill,
              );
               
               
               
               
            }
          },
        ),
      ),
    );
  }
}

class _BuildBottomSheet extends StatelessWidget {
  int cartTotal;
  List<CartItemModel> cartItems;
  _BuildBottomSheet({this.cartTotal, this.cartItems});

  List _buildOrderItems() {
    List orderItems = [];
    for (var element in cartItems) {
      orderItems.add({
        "productId": element.productId,
        "productCount": element.productCount
      });
    }
    return orderItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 15, top: 10, left: 30, right: 20),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Center(
                        child: CustomSizedTextBox(
                            textContent: '₹$cartTotal',
                            fontSize: 20,
                            isBold: true,
                            color: Colors.black))),
              ),
              GestureDetector(
                onTap: () async {
                  BlocProvider.of<OrdersummaryBloc>(context)
                      .add(AddOrderSummaryItem(orderItems: _buildOrderItems()));
                  Navigator.pushNamed(context, '/order-summary');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: CustomColors.blue,
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Center(
                    child: CustomSizedTextBox(
                        textContent: 'Buy Now',
                        fontSize: 16,
                        isBold: true,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
