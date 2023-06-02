import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/apis/version.api.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/auth/auth_bloc.dart';
import 'package:unboxedkart/models/app_version.model.dart';
import 'package:unboxedkart/presentation/pages/authentication/login_using_mobile_number.dart';
import 'package:unboxedkart/presentation/pages/authentication/login_using_popup.dart';
import 'package:unboxedkart/presentation/pages/cart/cart.dart';
import 'package:unboxedkart/presentation/pages/home_page/home_screen.dart';
import 'package:unboxedkart/presentation/pages/profile_page/profile_page.dart';
import 'package:unboxedkart/presentation/pages/search/search_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:unboxedkart/presentation/pages/wishlist/wishlist.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_sheet.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/url_actions.dart';
import 'package:version/version.dart';

class UserMain extends StatefulWidget {
  int index;
  UserMain({Key key, this.index = 0}) : super(key: key);
  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  PageController pageController;
  final LocalRepository _localRepo = LocalRepository();
  final VersionApi versionApi = VersionApi();
  CustomAlertPopup customPopup = CustomAlertPopup();
  CustomBottomSheet _customBottomSheet = CustomBottomSheet();

  static const String oneSignalAppId = "12fb7561-03e6-409e-bc03-a558aee286de";
  Future<void> intiPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  Future<AppVersionModel> getLatestAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var currentAppVersionInInt = Version.parse(packageInfo.version);
    final AppVersionModel appVersion = await versionApi.checkLatestVersion();
    print("app versions");
    print(currentAppVersionInInt);
    print(appVersion.version);
    if (currentAppVersionInInt < appVersion.version) {
      if (currentAppVersionInInt < appVersion.minAppVersion) {
        customPopup.show(
          dismissable: false,
          context: context,
          title: "New Update is available.",
          subTitle: appVersion.description,
          buttonOneText: "update now",
          buttonOneFunction: () => UrlActions.handleOpenStore(),
        );
        return appVersion;
      } else {
        customPopup.show(
          dismissable: false,
          context: context,
          title: "New Update is available.",
          subTitle: appVersion.description,
          buttonOneFunction: () => UrlActions.handleOpenStore(),
          buttonOneText: "Update now",
          buttonTwoText: "dismiss",
        );
      }
    }
  }

  void getUserData() async {
    if (await _localRepo.getAuthStatus()) {
      BlocProvider.of<AuthBloc>(context).add(LoadUserData());
    } else {
      await _localRepo
          .addPopularSearchTerms(['iphone', 'airpods pro', 'macbook pro']);
    }
  }

  bool showLogin = true;

  @override
  void initState() {
    super.initState();
    // getLatestAppVersion();
    intiPlatformState();
    getUserData();
    pageController = PageController(initialPage: widget.index ?? 0);
    // _showLoginPopup(context);
    // showStatus();
  }

  showStatus() async {
    _localRepo.setFirstLoadNotCompleted();
    print("stats");
    print(await _localRepo.getIfFirstLoadCompleted());
  }

  _showLoginPopup(BuildContext context) {
    _customBottomSheet.show(context: context, child: LoginUsingPopup());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String loadStatus = await _localRepo.getIfFirstLoadCompleted();
      if (loadStatus == null) {
        _showLoginPopup(context);
        await _localRepo.setFirstLoadCompleted();
        String loadStatus = await _localRepo.getIfFirstLoadCompleted();
      }
    });
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // showLogin ? LoginUsingMobileNumberPageUpdated() : HomeScreen(),
          HomeScreen(),
          SearchPage(enableBack: false),
          const Wishlist(
            enableBack: false,
          ),
          Cart(enableBack: false),
          const ProfilePage(enableBack: false),
        ],
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            widget.index = value;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        currentIndex: widget.index,
        onTap: (index) {
          pageController.jumpToPage(index);
          // _showLoginPopup();
        },
        activeColor: CustomColors.blue,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.home,
              size: 22,
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.search,
            size: 22,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.heart,
            size: 22,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.bag,
            size: 22,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            FontAwesome.bars,
            size: 20,
          )),
        ],
      ),
    );
  }
}
