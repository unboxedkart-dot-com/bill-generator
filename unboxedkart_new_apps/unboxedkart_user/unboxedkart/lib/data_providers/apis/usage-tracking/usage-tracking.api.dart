import 'package:unboxedkart/data_providers/apis/api_calls.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';

class UsageTrackingApi {
  ApiCalls apiCalls = ApiCalls();
  LocalRepository _localRepo = LocalRepository();

  Future handleAppIsDownloaded() async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url = "https://server.unboxedkart.com/usage-tracking/app-downloaded";
    final searchTerms = await apiCalls.post(url: url, accessToken: accessToken);
    return searchTerms;
  }

  Future handleKnowMoreAboutUnboxedkart() async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url =
        "https://server.unboxedkart.com/usage-tracking/know-more-about-unboxedkart";
    final searchTerms =
        await apiCalls.post(url: url, accessToken: accessToken, postBody: {});
    return searchTerms;
  }

  Future handleKnowMoreAboutStorePickup() async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url =
        "https://server.unboxedkart.com/usage-tracking/know-more-about-store-pickup";
    final searchTerms =
        await apiCalls.post(url: url, accessToken: accessToken, postBody: {});
    return searchTerms;
  }

  Future handleFindStores() async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url = "https://server.unboxedkart.com/usage-tracking/find-stores";
    final searchTerms =
        await apiCalls.post(url: url, accessToken: accessToken, postBody: {});
    return searchTerms;
  }

  Future handleClickedToCall() async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url =
        "https://server.unboxedkart.com/usage-tracking/clicked-to-call";
    final searchTerms =
        await apiCalls.post(url: url, accessToken: accessToken, postBody: {});
    return searchTerms;
  }

  Future handleNeedMoreDiscount(String productId) async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url =
        "https://server.unboxedkart.com/usage-tracking/clicked-on-need-more-discount";
    final searchTerms = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: {"productId": productId});
    return searchTerms;
  }

  Future handleClickedOnBuyNow(String productId) async {
    print("trying to do something");
    final String accessToken = await _localRepo.getAccessToken();
    const String url =
        "https://server.unboxedkart.com/usage-tracking/clicked-on-buy-now";
    final searchTerms = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: {"productId": productId});
    return searchTerms;
  }

  Future handleAddViewedProduct(String productId) async {
    final String accessToken = await _localRepo.getAccessToken();
    print("getting accesstoken");
    print(accessToken);
    const String url = "https://server.unboxedkart.com/usage-tracking/viewed-product";
    final searchTerms = await apiCalls.post(
        url: url, accessToken: accessToken, postBody: {"productId": productId});
    return searchTerms;
  }

  Future handleAddSearchTerm(String searchTerm) async {
    final String accessToken = await _localRepo.getAccessToken();
    const String url = "https://server.unboxedkart.com/search/add/search-term";
    final postBody = {"searchTerm": searchTerm};
    await apiCalls.post(url: url, accessToken: accessToken, postBody: postBody);
  }

  Future handleViewedCarouselItem(String carouselId) async {
    print("adding carousel item");
    final String accessToken = await _localRepo.getAccessToken();
    const String url = "https://server.unboxedkart.com/usage-tracking/view-carousel";
    final postBody = {"carouselId": carouselId};
    print(postBody);
    await apiCalls.post(url: url, accessToken: accessToken, postBody: postBody);
  }
}
