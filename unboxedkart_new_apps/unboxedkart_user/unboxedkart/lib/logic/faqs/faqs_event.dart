part of 'faqs_bloc.dart';

abstract class FaqsEvent extends Equatable {
  const FaqsEvent();

  @override
  List<Object> get props => [];
}

class LoadFaqs extends FaqsEvent{

}

// class AddFaq extends FaqsEvent {

// }

// class DeleteFaq extends FaqsEvent {

// }

// class UpdateFaq extends FaqsEvent {

// }
