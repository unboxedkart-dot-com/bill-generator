import 'package:unboxedkart/data_providers/apis/search_page/search.api.dart';
import 'package:unboxedkart/models/search/search_term.dart';

class SearchPageRepository {
  SearchApi searchApi = SearchApi();

  Future handleGetRecentSearches(String accessToken) async {
    final response = await searchApi.getRecentSearches(accessToken);
    final List<SearchTermModel> searchTerms = response
        .map<SearchTermModel>(
            (searchTerm) => SearchTermModel.fromDocument(searchTerm))
        .toList();
    return searchTerms;
  }

  Future handleGetPopularSearches() async {
    final response = await searchApi.getPopularSearches();
    final List<SearchTermModel> searchTerms = response
        .map<SearchTermModel>(
            (searchTerm) => SearchTermModel.fromDocument(searchTerm))
        .toList();
    return searchTerms;
  }

  Future handleAddRecentSearchTerm(
      String accessToken, String searchTerm) async {
    
    await searchApi.addRecentSearch(accessToken, searchTerm);
  }
}
