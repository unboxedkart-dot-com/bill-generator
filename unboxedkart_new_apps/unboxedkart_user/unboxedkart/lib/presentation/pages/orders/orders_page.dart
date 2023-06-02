import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/orders/orders_bloc.dart';
import 'package:unboxedkart/presentation/models/order/order.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class Orderspage extends StatefulWidget {
  const Orderspage({Key key}) : super(key: key);

  @override
  _OrderspageState createState() => _OrderspageState();
}

class _OrderspageState extends State<Orderspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(title: 'My Orders', enableBack: true)),
      body: BlocProvider(
        create: (context) => OrdersBloc()..add(LoadOrders()),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoadedState) {
              return state.orders.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return Order(order: state.orders[index]);
                      })
                  : ShowCustomPage(
                      icon: CupertinoIcons.cube_box,
                      title:
                          "You haven't ordered anything yet. You can start shopping now",
                      buttonText: "Start shopping",
                      function: () => Navigator.pushNamed(context, '/'),
                    );
            } else {
              return const LoadingSpinnerWidget();
            }
          },
        ),
      ),
    );
  }
}

class BuildNoOrders extends StatelessWidget {
  const BuildNoOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              CupertinoIcons.cube_box,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'You haven\'t ordered anything yet.',
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
