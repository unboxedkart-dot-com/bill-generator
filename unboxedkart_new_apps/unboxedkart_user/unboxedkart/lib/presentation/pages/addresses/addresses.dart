import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/addresses/addresses_bloc.dart';
import 'package:unboxedkart/presentation/models/address/address.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_page.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({Key key}) : super(key: key);

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(title: 'My Addresses', enableBack: true),
        ),
        body: BlocProvider(
          create: (context) => AddressesBloc()..add(LoadUserAddresses()),
          child: BlocBuilder<AddressesBloc, AddressesState>(
            builder: (context, state) {
              if (state is AddressesLoadedState) {
                return ListView(
                  children: [
                    ShowAddAddressWidget(function: () async {
                      await Navigator.pushNamed(context, '/create-address');
                      BlocProvider.of<AddressesBloc>(context)
                          .add(LoadUserAddresses());
                    }),
                    state.addresses.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: state.addresses.length,
                            itemBuilder: (context, index) {
                              return Address(address: state.addresses[index]);
                            })
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * 0.4),
                            child: ShowCustomPage(
                                icon: CupertinoIcons.location,
                                title:
                                    "You haven't added any addresses. Please add an address now for faster checkout.",
                                buttonText: "Add address",
                                function: () async {
                                  await Navigator.pushNamed(
                                      context, '/create-address');
                                  BlocProvider.of<AddressesBloc>(context)
                                      .add(LoadUserAddresses());
                                }),
                          )
                     
                  ],
                );
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ));
  }
}

class ShowAddAddressWidget extends StatelessWidget {
  final String previousPage;
  final Function function;

  const ShowAddAddressWidget({Key key, this.function, this.previousPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        function();
      },
      child:
      
          Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomSizedTextBox(
                  textContent: "Add new address",
                  isBold: true,
                  fontSize: 18,
                  color: CustomColors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowNoAddressWidget extends StatelessWidget {
  const ShowNoAddressWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            CupertinoIcons.home,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'You haven\'t added any addresses, add one now for faster checkout',
            textAlign: TextAlign.center,
          ))
        ]);
  }
}
