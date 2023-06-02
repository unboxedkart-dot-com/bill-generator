import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/wishlist/wishlist_bloc.dart';
import 'package:unboxedkart/presentation/models/wishlist_item/wishlist_item.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/show_signin_page.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class Wishlist extends StatefulWidget {
  final bool enableBack;
  const Wishlist({Key key, this.enableBack = true}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final LocalRepository _localRepo = LocalRepository();
  bool isAuthenticated = false;

  void getAuthStatus() async {
    isAuthenticated = await _localRepo.getAuthStatus();
  }

  @override
  void initState() {
    getAuthStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(title: 'Wishlist', enableBack: widget.enableBack),
      ),
      body: BlocProvider(
        create: (context) => WishlistBloc()..add(LoadWishlistItems()),
        child: Scaffold(body: Center(
          child: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistLoadingState) {
                return const LoadingSpinnerWidget();
              } else if (state is WishlistLoadedState) {
                if (isAuthenticated) {
                  if (state.products.isNotEmpty) {
                    return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return WishlistItem(product: state.products[index]);
                        });
                  } else {
                    return ShowCustomPage(
                        // hasRoundedCorners: true,
                        title:
                            "Your wishlist is empty. Please add products to your wishlist.",
                        icon: CupertinoIcons.heart,
                        buttonText: "Start Shopping now",
                        function: () => Navigator.pushNamed(context, '/'));
                  }
                } else {
                  return const ShowSignInPage(
                    title:
                        "Your wishlist is not visible. Please sign in to see your wishlist",
                    icon: CupertinoIcons.heart_fill,
                  );
                }
              } else {
                return const Text("Something went wrong");
              }
            },
          ),
        )),
      ),
    );
  }
}

class _BuildShowSignInButton extends StatelessWidget {
  final String title;

  const _BuildShowSignInButton({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.profile_circled,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Please sign in using your credentials to see your wishlist.',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}

class _BuildEmptyWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.suit_heart,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'You haven\'t added any products to your bag',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
