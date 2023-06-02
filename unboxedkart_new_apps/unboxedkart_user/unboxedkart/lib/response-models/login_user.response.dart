class UserLoggedInResponse {
  final String status;
  final String message;
  final String accessToken;
  final List wishlist;
  final List cart;
  final String userId;
  final List recentSearches;
  final List popularSearches;
  final String content;
  final List purchasedItemIds;

  UserLoggedInResponse(
      {this.status,
      this.message,
      this.accessToken,
      this.wishlist,
      this.cart,
      this.userId,
      this.recentSearches,
      this.popularSearches,
      this.content,
      this.purchasedItemIds});

  factory UserLoggedInResponse.fromDocument(doc) {
     
     
    bool isSuccess;
    if (doc['status'] == "success") {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    return UserLoggedInResponse(
        status: doc['status'],
        message: doc['message'],
        accessToken: !isSuccess ? null : doc['data']['accessToken'],
        wishlist: !isSuccess ? null : doc['data']['wishlist'],
        cart: !isSuccess ? null : doc['data']['cart'],
        userId: !isSuccess ? null : doc['data']['userId'],
        recentSearches: !isSuccess ? null : doc['data']['recentSearches'],
        popularSearches: !isSuccess ? null : doc['data']['popularSearches'],
        content: doc['content'],
        purchasedItemIds: !isSuccess ? null : doc['data']['purchasedItemIds']);
  }
}
