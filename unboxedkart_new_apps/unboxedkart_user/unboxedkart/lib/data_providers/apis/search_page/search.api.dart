import 'package:unboxedkart/data_providers/apis/api_calls.dart';

class SearchApi {
  ApiCalls apiCalls = ApiCalls();

  Future addRecentSearch(String accessToken, String searchTerm) async {
    const String url = "https://server.unboxedkart.com/search/add/search-term";
    // const String postUrl = "https://server.unboxedkart.com/usage-tracking/searched-term";
    final postBody = {"searchTerm": searchTerm};
    await apiCalls.post(url: url, accessToken: accessToken, postBody: postBody);
    // await apiCalls.post(url: postUrl, accessToken: accessToken, postBody: postBody);/
  }

  Future getPopularSearches() async {
    const String url = "https://server.unboxedkart.com/search/popular-searches";
    final searchTerms = await apiCalls.get(url: url);
    return searchTerms;
  }

  Future getRecentSearches(String accessToken) async {
    const String url = "https://server.unboxedkart.com/search/recent-searches";
    final searchTerms = await apiCalls.get(url: url, accessToken: accessToken);
    return searchTerms;
  }
}
