import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/auth/auth_bloc.dart';
import 'package:unboxedkart/presentation/pages/authentication/login_using_mobile_number.dart';
import 'package:unboxedkart/presentation/pages/cart/cart.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final bool enableBack;
  const ProfilePage({Key key, this.enableBack}) : super(key: key);


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAuth = false;

  final LocalRepository _localRepo = LocalRepository();
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  showLogoutPopup(Function logoutFunction) {
    return _customPopup.show(
      title: "Would you like to logout",
      buttonOneText: "Yes",
      buttonTwoText: "No",
      buttonOneFunction: () {
        Navigator.pop(context);
        logoutFunction();

      },
      context: context,
    );
  }

  @override
  void initState() {
    _getUserStatus();
    super.initState();
  }

  void _getUserStatus() async {
    bool authStatus = await _localRepo.getAuthStatus();
    setState(() {
      isAuth = authStatus;
    });
  }

  void _handlePushToNextPage(String routeName, {Object arguments}) async {
    if (isAuth) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      await Navigator.pushNamed(context, '/login',
          arguments: const LoginUsingMobileNumberPageUpdated(
            showProfile: true,
          ));
      BlocProvider.of<AuthBloc>(context).add(LoadAuthStatus());
    }
  }

  void _handleRateUs() async {
    const url = 'https://www.trustpilot.com/review/unboxedkart.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            enableBack: false,
            title: "Profile",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: BlocProvider(
              create: (context) => AuthBloc()..add(LoadAuthStatus()),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is IsAuthLoadedState) {
                    isAuth = state.authStatus;
                     
                    return ListView(
                      children: [
                        // (state is IsAuthenticatedState)
                        state.authStatus
                            ? _CustomListTileWidget(
                                title: "Account Settings",
                                icon: CupertinoIcons.profile_circled,
                                function: () async {
                                  await Navigator.pushNamed(
                                      context, '/user-details');
                                })
                            : _CustomListTileWidget(
                                title: "Login",
                                icon: CupertinoIcons.profile_circled,
                                function: () async {
                                  await Navigator.pushNamed(context, '/login',
                                      arguments:
                                          const LoginUsingMobileNumberPageUpdated(
                                        showProfile: true,
                                      ));
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(LoadAuthStatus());
                                  setState(() {
                                  });
                                }

                                ),
                        _CustomListTileWidget(
                          title: "My Orders",
                          icon: CupertinoIcons.cube_box_fill,
                          function: () => _handlePushToNextPage('/orders'),
                        ),
                        _CustomListTileWidget(
                          title: "My Shopping cart",
                          icon: CupertinoIcons.bag_fill,
                          function: () => _handlePushToNextPage('/cart',
                              arguments: Cart(
                                enableBack: true,
                              )),
                        ),
                        _CustomListTileWidget(
                            title: "My Wishlist",
                            icon: CupertinoIcons.heart_fill,
                            function: () => _handlePushToNextPage('/wishlist')),
                        _CustomListTileWidget(
                          title: "My Addresses",
                          icon: Icons.location_on,
                          function: () => _handlePushToNextPage('/addresses'),
                        ),
                        _CustomListTileWidget(
                          title: "My Coupons",
                          icon: Icons.money,
                          function: () => _handlePushToNextPage('/coupons'),
                        ),
                        _CustomListTileWidget(
                          title: "Refer and Earn",
                          icon: CupertinoIcons.group_solid,
                          function: () => _handlePushToNextPage('/refer'),
                        ),
                        _CustomListTileWidget(
                          title: "My Reviews",
                          icon: CupertinoIcons.star_lefthalf_fill,
                          function: () => _handlePushToNextPage('/reviews'),
                        ),
                        _CustomListTileWidget(
                          title: "My Question and answers",
                          icon: Icons.comment_rounded,
                          function: () => _handlePushToNextPage('/q-and-a'),
                        ),
                        _CustomListTileWidget(
                          title: "FAQ's",
                          icon: FontAwesome.comments_o,
                          function: () => Navigator.pushNamed(context, '/faqs'),
                        ),
                        _CustomListTileWidget(
                            hasDivider: false,
                            title: "Rate Us",
                            icon: CupertinoIcons.star_fill,
                            function: () => _handleRateUs()),
                        state.authStatus
                            ? _CustomListTileWidget(
                                hasDivider: false,
                                title: "Logout",
                                icon:
                                    CupertinoIcons.rectangle_stack_badge_minus,
                                function: () => showLogoutPopup(() {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(LogoutUser());
                                }),
                              )
                            : const SizedBox()
                      ],
                    );
                  } else {
                    return const LoadingSpinnerWidget();
                  }
                },
              ),
            ),
          ),
        ));
  }
}

class _CustomListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function function;
  final bool hasDivider;

  const _CustomListTileWidget(
      {this.function, this.icon, this.title, this.hasDivider = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      child: Material(
        color: Colors.white,
        elevation: 0,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          margin: const EdgeInsets.all(2),
          child: Column(
            children: [
              TextButton(
                onPressed: function,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      size: 25,
                      color: CustomColors.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Text(
                        title,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              hasDivider
                  ? const Divider(
                      height: 0,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );

  }
}
