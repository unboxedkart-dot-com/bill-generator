import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/repositories/auth.repository.dart';
import 'package:unboxedkart/data_providers/repositories/brand.repository.dart';
import 'package:unboxedkart/data_providers/repositories/products.repository.dart';
import 'package:unboxedkart/logic/auth/auth_bloc.dart';
import 'package:unboxedkart/logic/cart_page/cart_bloc.dart';
import 'package:unboxedkart/logic/net/network_bloc.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';
import 'package:unboxedkart/logic/product_tile/producttile_bloc.dart';
import 'package:unboxedkart/logic/products_page/products_bloc.dart';
import 'package:unboxedkart/logic/profile_page/profilepage_bloc.dart';
import 'package:unboxedkart/logic/question_and_answer/questionandanswers_bloc.dart';
import 'package:unboxedkart/logic/search_page/search_bloc.dart';
import 'package:unboxedkart/logic/user/user_bloc.dart';
import 'package:unboxedkart/presentation/pages/user_main/user_main.dart';
import 'package:unboxedkart/presentation/router/app_router.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key key}) : super(key: key);
  bool showLogin = true;
  CustomBottomSheet _customBottomSheet = CustomBottomSheet();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<SearchPageBloc>(
            create: (context) => SearchPageBloc(),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(),
          ),
          BlocProvider<ProducttileBloc>(
            create: (context) => ProducttileBloc(),
          ),
          BlocProvider<OrdersummaryBloc>(
            create: (context) => OrdersummaryBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
          BlocProvider<QuestionandanswersBloc>(
            create: (context) => QuestionandanswersBloc(),
          ),
          BlocProvider<ProfilepageBloc>(
            create: (context) => ProfilepageBloc(),
          ),
          BlocProvider<ProductsPageBloc>(
            create: (context) => ProductsPageBloc(),
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => ProductsRepository()),
            RepositoryProvider(create: (context) => AuthRepository()),
            RepositoryProvider(create: (context) => BrandRepository()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Unboxedkart',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'T MS',
                scaffoldBackgroundColor: CustomColors.backgroundGrey),
            onGenerateRoute: _appRouter.onGenerateRoute,
            home: BlocProvider(
              create: (context) => NetworkBloc(),
              child: BlocBuilder<NetworkBloc, NetworkState>(
                builder: (context, state) {
                  // return const ProductTile(
                  //   productId: '64209effe0ae780d8e5cae67',
                  // );
                  return UserMain();
                  // return const PaymentPage();
                  // return UserMain();
                  // return ProductTile(
                  //   productId: "641f3474e0ae780d8e5cad03",
                  // );
                  // return LoginUsingPopup();
                  // return const PaymentPage();
                  // return const OrderSummary();
                },
              ),
            ),
          ),
        ));
  }
}
