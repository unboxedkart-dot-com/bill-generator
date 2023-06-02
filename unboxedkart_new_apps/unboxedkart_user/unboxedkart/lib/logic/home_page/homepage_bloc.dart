import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/products.repository.dart';
import 'package:unboxedkart/models/product/product.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final ProductsRepository productsRepository = ProductsRepository();
  HomepageBloc(ProductsRepository of) : super(HomePageLoadingState()) {
  }
}
