part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends BrandEvent{
  final String brandName;

  const LoadData(this.brandName);
}

class LoadBrandCarouselItems extends BrandEvent {
  final String brand;

  const LoadBrandCarouselItems(this.brand);

}

