import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  final _storage = const FlutterSecureStorage();

  bool authStatus = false;

  setFirstLoadCompleted() async {
    await _storage.write(key: "firstLoadCompleted", value: "true");
  }

  setFirstLoadNotCompleted() async {
    await _storage.write(key: "firstLoadCompleted", value: null);
  }

  getIfFirstLoadCompleted() async {
    return await _storage.read(key: "firstLoadCompleted");
  }

  _setExternalUserId(String externalUserId) {
    OneSignal.shared
        .setExternalUserId(externalUserId)
        .then((results) {})
        .catchError((error) {});
  }

  _removeExternalUserId() {
    OneSignal.shared.removeExternalUserId();
  }

  setUserId(String userId) {
    _setExternalUserId(userId);
  }

  setCouponCode(String coupon) async {
    await _storage.write(key: "couponCode", value: coupon);
  }

  getCouponCode() async {
    String coupon = await _storage.read(key: "couponCode");
  }

  getDeviceId() async {
    String deviceId = await _storage.read(key: "deviceId");
    return deviceId;
  }

  setDeviceId(String deviceId) async {
    _setExternalUserId(deviceId);
  }

  getAuthStatus() async {
    final status = await _storage.read(key: "isAuth");

    if (status == "true") {
      return true;
    } else {
      return false;
    }
  }

  setIsAuthenticated(String accessToken, String userId) async {
    await _storage.write(key: "isAuth", value: "true");
    await _storage.write(key: "accessToken", value: accessToken);
    _setExternalUserId(userId);
  }

  setIsNotAuthenticated() async {
    _removeExternalUserId();
    await _storage.deleteAll();
    await _storage.write(key: "isAuth", value: "false");
  }

  setAccessToken(String token) async {
    await _storage.write(key: "accessToken", value: token);
  }

  getAccessToken() async {
    final accessToken = await _storage.read(key: "accessToken");
    return accessToken;
  }

  checkForItemInWishlist(String productId) async {
    if (await _storage.read(key: "w$productId") != null) {
      return true;
    } else {
      return false;
    }
  }

  checkForItemInCart(String productId) async {
    if (await _storage.read(key: "c$productId") != null) {
      return true;
    } else {
      return false;
    }
  }

  addWishlistItem(String productId) async {
    await _storage.write(key: "w$productId", value: "true");
  }

  addCartItem(String productId) async {
    await _storage.write(key: "c$productId", value: "true");
  }

  removeCartItem(String productId) async {
    await _storage.delete(key: "c$productId");
  }

  removeWishlistItem(String productId) async {
    await _storage.delete(key: "w$productId");
  }

  getRecentSearchTerms() async {
    List<String> recentSearches = [];
    if (await _storage.read(key: "rs1") != null) {
      recentSearches.add(await _storage.read(key: "rs1"));
    }
    if (await _storage.read(key: "rs2") != null) {
      recentSearches.add(await _storage.read(key: "rs2"));
    }
    if (await _storage.read(key: "rs3") != null) {
      recentSearches.add(await _storage.read(key: "rs3"));
    }

    return recentSearches;
  }

  addRecentSearchTerm(String searchTerm) async {
    await _storage.write(key: "rs3", value: await _storage.read(key: "rs2"));

    await _storage.write(key: "rs2", value: await _storage.read(key: "rs1"));

    await _storage.write(key: "rs1", value: searchTerm);
  }

  addPopularSearchTerms(List searchTerms) async {
    if (searchTerms != null) {
      await _storage.write(key: "ps1", value: searchTerms[0].toString());
      await _storage.write(key: "ps2", value: searchTerms[1].toString());
      await _storage.write(key: "ps3", value: searchTerms[2].toString());
    }
  }

  getPopularSearchTerms() async {
    List<String> popularSearches = [];
    popularSearches.add(await _storage.read(key: "ps1"));
    popularSearches.add(await _storage.read(key: "ps2"));
    popularSearches.add(await _storage.read(key: "ps3"));
    return popularSearches;
  }

  addPurchasedItems(List purchasedItems) async {
    if (purchasedItems != null) {
      final SharedPreferences _sharedPrefs =
          await SharedPreferences.getInstance();
      _sharedPrefs.setStringList(
          "purchasedItems", List<String>.from(purchasedItems));
    }
  }

  addAnsweredQuestionIds(List questionIds) async {
    if (questionIds != null) {
      final SharedPreferences _sharedPrefs =
          await SharedPreferences.getInstance();
      _sharedPrefs.setStringList(
          "answeredQuestionIds", List<String>.from(questionIds));
    }
  }

  addAnsweredQuestionId(String questionId) async {
    final SharedPreferences _sharedPrefs =
        await SharedPreferences.getInstance();
    List previousQuestionIds =
        _sharedPrefs.getStringList("answeredQuestionIds");
    previousQuestionIds.add(questionId);
    _sharedPrefs.setStringList("answeredQuestionIds", previousQuestionIds);
  }

  checkForQuestionAnswered(String questionId) async {
    final SharedPreferences _sharedPrefs =
        await SharedPreferences.getInstance();
    List questionIds = _sharedPrefs.getStringList("answeredQuestionIds");
    if (questionIds != null && questionIds.contains(questionId)) {
      return true;
    } else {
      return false;
    }
  }

  checkForPurchasedItem(String productId) async {
    final SharedPreferences _sharedPrefs =
        await SharedPreferences.getInstance();
    final List purchasedItems = _sharedPrefs.getStringList("purchasedItems");
    if (purchasedItems != null && purchasedItems.contains(productId)) {
      return true;
    } else {
      return false;
    }
  }

  setRefreshToken(String token) async {
    await _storage.write(key: "refreshToken", value: token);
  }

  getRefreshToken() async {
    await _storage.read(key: "refreshToken");
  }
}
