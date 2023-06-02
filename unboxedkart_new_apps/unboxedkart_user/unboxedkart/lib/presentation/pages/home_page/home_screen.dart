import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/apis/usage-tracking/usage-tracking.api.dart';
import 'package:unboxedkart/data_providers/repositories/home_screen.repository.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/products.repository.dart';
import 'package:unboxedkart/logic/home_page/homepage_bloc.dart';
import 'package:unboxedkart/models/brand/brand.model.dart';
import 'package:unboxedkart/models/category/category.model.dart';
import 'package:unboxedkart/models/condition/condition.model.dart';
import 'package:unboxedkart/presentation/carousels/show-carousel.dart';
import 'package:unboxedkart/presentation/models/brand/brand.dart';
import 'package:unboxedkart/presentation/models/category/category.dart';
import 'package:unboxedkart/presentation/models/condition/condition.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/pay_at_store.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/url_actions.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenRepository homeScreenRepository = HomeScreenRepository();
  BrandModel brand = BrandModel(brandName: "apple", imageUrl: "", slug: "");
  int caourselImageIndex = 0;
  final LocalRepository _localRepository = LocalRepository();
  final UsageTrackingApi _trackingApi = UsageTrackingApi();

  // @override
  // initState() {
  //   // _localRepository.setRefreshToken("ea83588e-5a23-48f2-9fb6-4fd477d6b18c");
  // }

  @override
  void initState() {
    super.initState();
    // _tryPasteCurrentPhone();
    // Future<void>.delayed(
    //     const Duration(milliseconds: 300), _tryPasteCurrentPhone);
  }

  Future _tryPasteCurrentPhone() async {
    String mobileNumber = (await MobileNumber.mobileNumber);
    print("phone number is ${mobileNumber}");
    // if (!mounted) return;
    // try {
    //   final autoFill = SmsAutoFill();
    //   final phone = await autoFill.hint;
    //   if (phone == null) return;
    //   if (!mounted) return;
    //   // _textController.value = phone;
    //   print("autofill plugin");
    //   print(phone);
    // } on PlatformException catch (e) {
    //   print('Failed to get mobile number because of: ${e.message}');
    // }
  }

  Map newValues = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
  };

  static List<String> imageUrls = [
    'assets/images/carousel_images/iphone.webp',
    'assets/images/carousel_images/iwatch.webp',
    'assets/images/carousel_images/airpods.webp',
    'assets/images/carousel_images/macbook.webp',
    'assets/images/carousel_images/homepod.webp',
  ];

  List<Widget> carouselImages = [
    Image(
      image: AssetImage(imageUrls[0]),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage(imageUrls[1]),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage(imageUrls[2]),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage(imageUrls[3]),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage(imageUrls[4]),
      fit: BoxFit.contain,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomepageBloc(RepositoryProvider.of<ProductsRepository>(context)),
      child: Scaffold(body: Center(
        child: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: const Color(0xffF6F6F9),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: CustomColors.blue,
                leadingWidth: 45,
                leading: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Image(
                    image: AssetImage(
                        'assets/images/featured_images/logo-transparent.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                actions: [
                  // CustomSizedTextBox(
                  //   textContent: "About",
                  //   fontSize: 10,
                  //   color: Colors.white,
                  // )
                  // Icon(Icons.explore)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () async {
                        await _trackingApi.handleKnowMoreAboutUnboxedkart();
                        Navigator.pushNamed(context, '/about-unboxedkart');
                      },
                      child: const Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(
                            'assets/images/featured_images/about_icon.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
                titleSpacing: 5,
                centerTitle: false,
                title: CustomSizedTextBox(
                  textContent: "Unboxedkart",
                  color: Colors.white,
                  fontSize: 25,
                  fontName: 'Alegreya Sans',
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     PayAtStoreWidget(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal : 5.0),
                    //   child: CarouselSlider(
                    //       items: homeScreenRepository
                    //           .handleGetHomeScreenCarouselItems(),
                    //       options: CarouselOptions(
                    //           viewportFraction: 1, autoPlay: true)),
                    // ),
                    ShowCarouselItems(
                      isVertical: false,
                      placement: 'home',
                    ),

                    CustomSizedTextBox(
                      textContent: "Shop by Brand",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _ProductsByBrand(
                      productsData: homeScreenRepository.brandsData
                          .map<BrandModel>(
                              (product) => BrandModel.fromDocument(product))
                          .toList(),
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Category",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _ProductsByCategory(
                      categoriesData: homeScreenRepository.categoriesData
                          .map<CategoryModel>(
                              (product) => CategoryModel.fromDocument(product))
                          .toList(),
                    ),
                    CustomSizedTextBox(
                      textContent: "Shop by Product Condition",
                      isBold: true,
                      fontSize: 18,
                      addPadding: true,
                    ),
                    _ProductsByCondition(
                      conditionsData: homeScreenRepository.conditionsData
                          .map<ConditionModel>(
                              (product) => ConditionModel.fromDocument(product))
                          .toList(),
                    ),
                    BuildNeedHelpWidget(),
                    BuildGetDirectionsWidget(),
                    ElevatedContainer(
                      elevation: 0,
                      child: const Image(
                        // height: 120,
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/images/featured_images/unboxedkart_bottom.png'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}

class _ProductsByBrand extends StatelessWidget {
  final productsData;
  const _ProductsByBrand({this.productsData});

  @override
  Widget build(BuildContext context) {
    int columnCount = getColumnCount(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: columnCount),
        itemCount: productsData.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return BrandWidget(brand: productsData[index]);
        });
  }
}

class _ProductsByCategory extends StatelessWidget {
  final categoriesData;

  const _ProductsByCategory({this.categoriesData});

  @override
  Widget build(BuildContext context) {
    int columnCount = getColumnCount(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // maxCrossAxisExtent: 200,
            crossAxisCount: columnCount,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: categoriesData.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return CategoryWidget(category: categoriesData[index]);
        });
  }
}

class _ProductsByCondition extends StatelessWidget {
  final conditionsData;

  const _ProductsByCondition({this.conditionsData});

  @override
  Widget build(BuildContext context) {
    int columnCount = getColumnCount(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // maxCrossAxisExtent: 200,
            crossAxisCount: columnCount,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: conditionsData.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return ConditionWidget(condition: conditionsData[index]);
        });
  }
}

class BuildNeedHelpWidget extends StatelessWidget {
  BuildNeedHelpWidget({Key key}) : super(key: key);
  final UrlActions urlActions = UrlActions();
  UsageTrackingApi _usageTrackingApi = UsageTrackingApi();

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedTextBox(
              textContent: 'Need help while shopping with us?',
              fontSize: 20,
              addPadding: true,
              paddingWidth: 8,
              isBold: true),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Hello 👋\n'
                "Do you have any concerns as you shop? We'll work with you to improve your shopping experience with us."
                // 'Any questions while you shop? We\'ll help you to make your shopping experience with us even more better.'
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                urlActions.makePhoneCall();
                _usageTrackingApi.handleClickedToCall();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'CALL NOW',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: CustomSizedTextBox(
            textContent: '850-8484848',
            fontSize: 12,
            color: CustomColors.blue,
          )),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

class BuildGetDirectionsWidget extends StatelessWidget {
  BuildGetDirectionsWidget({Key key}) : super(key: key);
  final UsageTrackingApi _trackingApi = UsageTrackingApi();

  void _launchLocationUrl() async {
    String _url =
        "https://www.google.com/maps/dir//unboxedkart/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x3bae17fd7fc6cba1:0x4f9ea766e78d8fe0?sa=X&ved=2ahUKEwiv9d--6qj3AhW96XMBHX3YCaEQ9Rd6BAg4EAQ";
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // _launchLocationUrl();
        await _trackingApi.handleFindStores();
        Navigator.pushNamed(context, '/store-locations');
      },
      child: ElevatedContainer(
        elevation: 0,
          // margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSizedTextBox(
                    textContent: "Find our stores",
                    isBold: true,
                  ),
                  // Text('Find a store'),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class BuildHomeScreenCarousel extends StatefulWidget {
  const BuildHomeScreenCarousel({Key key}) : super(key: key);

  @override
  State<BuildHomeScreenCarousel> createState() =>
      _BuildHomeScreenCarouselState();
}

class _BuildHomeScreenCarouselState extends State<BuildHomeScreenCarousel> {
  int imageIndex = 0;
  List<String> imageUrls = [
    'assets/images/carousel_images/iphone.webp',
    'assets/images/carousel_images/iwatch.webp',
    'assets/images/carousel_images/airpods.webp',
    'assets/images/carousel_images/macbook.webp',
    'assets/images/carousel_images/homepod.webp',
  ];

  final PageController _carouselController = PageController(initialPage: 0);
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width * 0.48,
                child: PageView.builder(
                    controller: _carouselController,
                    itemCount: imageUrls.length,
                    padEnds: true,
                    onPageChanged: (val) {
                      setState(() {
                        imageIndex = val;
                      });
                    },
                    itemBuilder: (item, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: AssetImage(imageUrls[index]),
                          fit: BoxFit.contain,
                        ),
                      );
                    })),
            Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: Container(
                height: 10,
                alignment: Alignment.center,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: imageIndex == index
                                ? const Color.fromRGBO(0, 0, 0, 0.9)
                                : const Color.fromRGBO(0, 0, 0, 0.4)),
                      );
                    })),
              ),
            )
          ],
        ));
  }
}
