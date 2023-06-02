import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/logic/addresses/addresses_bloc.dart';
import 'package:unboxedkart/presentation/models/store_location/store_location.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_scaffold.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class ShowStoreLocations extends StatelessWidget {
  const ShowStoreLocations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "Find a Store",
      child: BlocProvider(
        create: (context) => AddressesBloc()..add(LoadStoreLocations()),
        child: BlocBuilder<AddressesBloc, AddressesState>(
          builder: (context, state) {
            if (state is AddressesLoadedState) {
              return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.storeLocations.length,
                  itemBuilder: (context, index) {
                    return StoreLocation(
                      storeLocation: state.storeLocations[index],
                    );
                  });
            } else {
              return const LoadingSpinnerWidget();
            }
          },
        ),
      ),
    );
  }
}
