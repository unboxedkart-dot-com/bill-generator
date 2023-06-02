part of 'search_bloc.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends SearchPageEvent {

}

class AddRecentSearchTerm extends SearchPageEvent {
  final String searchTerm;

  const AddRecentSearchTerm(this.searchTerm);

}

