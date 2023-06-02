import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/faqs.repository.dart';
import 'package:unboxedkart/models/faq/faq.model.dart';

part 'faqs_event.dart';
part 'faqs_state.dart';

class FaqsBloc extends Bloc<FaqsEvent, FaqsState> {
  FaqsRepository faqsRepository = FaqsRepository();
  FaqsBloc() : super(FaqsInitial()) {
    on<LoadFaqs>(_onLoadFaqs);
  }

  void _onLoadFaqs(LoadFaqs event, Emitter<FaqsState> emit) async {
    emit(FaqsLoading());
    final faqs = await faqsRepository.handleGetFaqs();
    
    
    emit(FaqsLoaded(faqs: faqs));
  }
}
