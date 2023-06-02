part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentOptions extends PaymentEvent {
  @override
  List<Object> get props => [];
}

class IsPaymentProcessing extends PaymentEvent {

}

class IsPaymentDone extends PaymentEvent {

}


