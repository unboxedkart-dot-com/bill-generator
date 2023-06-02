import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/data_providers/repositories/search_page.repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageRepository searchRepository = SearchPageRepository();
  final LocalRepository _localRepo = LocalRepository();
  SearchPageBloc() : super(SearchPageLoadingState()) {
    on<LoadData>(_onLoadData);
    on<AddRecentSearchTerm>(_onAddRecentSearchTerm);

  }

  void _onLoadData(LoadData event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoadingState());
    final accessToken = await _localRepo.getAccessToken();
    if (accessToken != null) {
      final recentSearches = await _localRepo.getRecentSearchTerms();
      

      // final popularSearches = await _localRepo.getPopularSearchTerms();
      final popularSearches = [
        'iPhone 13 Pro',
        'iPhone 13 Pro Max',
        'Airpods Pro'
      ];
      
      // final popularSearches = await searchRepository.handleGetPopularSearches();
      emit(SearchPageLoadedState(
          recentSearchTerms: recentSearches,
          popularSearchTerms: popularSearches));
    } else {
      // final popularSearches = await searchRepository.handleGetPopularSearches();
      final popularSearches = await _localRepo.getPopularSearchTerms();
      emit(SearchPageLoadedState(popularSearchTerms: popularSearches));
    }
  }

  void _onAddRecentSearchTerm(
      AddRecentSearchTerm event, Emitter<SearchPageState> emit) async {
    
    String accessToken = await _localRepo.getAccessToken();
    
    await _localRepo.addRecentSearchTerm(event.searchTerm);
    
    await searchRepository.handleAddRecentSearchTerm(
        accessToken, event.searchTerm);
  }
}


