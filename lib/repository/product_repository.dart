import 'package:link_go/models/util_model.dart';
import 'package:link_go/repository/network_helper.dart';
import 'package:link_go/utils/enums.dart';

class ProductRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> getGenderCategories() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "category/gender-categories",
    );
  }

  Future<HTTPResponseModel> getCategoriesSubcategories() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "admin/category",
    );
  }

  Future<HTTPResponseModel> getSellerListing(userID) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "user/listings/$userID?page1&limit=10",
    );
  }

  Future<HTTPResponseModel> getSimilarProducts(productId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "product/$productId/similar",
    );
  }

  Future<HTTPResponseModel> categoryByHirachy() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "admin/category/hierarchy",
    );
  }

  Future<HTTPResponseModel> getUserProductListing() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "user/listings?page=1&limit=5",
    );
  }

  Future<HTTPResponseModel> createProductListings(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.formData,
      url: "product",
      body: body,
    );
  }

  Future<HTTPResponseModel> markAllAsRead() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.patch,
      url: "in-app-notifications/mark-all-read",
      //body: body,
    );
  }

  Future<HTTPResponseModel> updateProduct(
      Map<String, dynamic> body, String productId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.formDataPatch,
      url: "product/$productId",
      body: body,
    );
  }

  Future<HTTPResponseModel> deleteListedProduct(String productId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.delete,
      url: "product/$productId",
    );
  }

  Future<HTTPResponseModel> deleteNotification(String? notificationId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.delete,
      url: "in-app-notifications/$notificationId",
    );
  }

  Future<HTTPResponseModel> hidelistedProduct(String productId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.put,
      url: "user/listings/$productId",
    );
  }

  Future<HTTPResponseModel> markasRead(String? notificationId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.patch,
      url: "in-app-notifications/$notificationId/read",
    );
  }

  Future<HTTPResponseModel> fetchColor() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "misc/colors",
    );
  }

  Future<HTTPResponseModel> fetchCondition() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "admin/category/conditions",
    );
  }

  Future<HTTPResponseModel> getProduct(
      {
      double? long,
      double? lat,
      int? page = 1,
      int? limit}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get,
        url: "product?page=$page&limit=$limit&radius=400&sortByLocation=true&latitude=$lat&longitude=$long"
           // "product?userState=$state&userCity=$city&longitude=$long&latitude=$lat&per_page=5&page=$page"

        //"product?userState=state&userCity=city&location=long,per_page=5&page=$page",
        //"product/featured-products?pageSize=5&pageNumber=1&searchValue=&channel=default&locale=en",
        );
  }

  Future<HTTPResponseModel> getProductByID(
      {String? productID,
        int? page = 1}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get,
        url: "product"
    );
  }

  Future<HTTPResponseModel> getDetailedProduct(productId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "product/$productId",
      //"product/featured-products?pageSize=5&pageNumber=1&searchValue=&channel=default&locale=en",
    );
  }

  Future<HTTPResponseModel> getReview(shopId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "review/get_review?shopId=$shopId&page=1&limit=3",
    );
  }

  Future<HTTPResponseModel> getReviewWithRatings(shopId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "review/get_review_with_ratting?shopId=$shopId&page=1&limit=3",
    );
  }

  Future<HTTPResponseModel> reportItem(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.formData,
      url: "report/create-report",
      body: body,
    );
  }

  Future<HTTPResponseModel> reviewProduct(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "review/reviewProduct",
      body: body,
    );
  }

  Future<HTTPResponseModel> searchProduct({
    String? name,
    String? color,
    String? category,
    String? condition,
    String? size,
    int? priceMin,
    int? priceMax,
    int page = 1,
    int limit = 10,
  }) async {
    Map<String, String> queryParams = {};

    if (name?.isNotEmpty == true) queryParams['name'] = name!;
    if (color?.isNotEmpty == true) queryParams['color'] = color!;
    if (category?.isNotEmpty == true) queryParams['category'] = category!;
    if (condition?.isNotEmpty == true) queryParams['condition'] = condition!;
    if (size?.isNotEmpty == true) queryParams['size'] = size!;
    if (priceMin != null) queryParams['priceMin'] = priceMin.toString();
    if (priceMax != null) queryParams['priceMax'] = priceMax.toString();

    queryParams['page'] = page.toString();
    queryParams['limit'] = limit.toString();

    final queryString = Uri(queryParameters: queryParams).query;

    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "product?$queryString",
    );
  }

  Future<HTTPResponseModel> notification({int? page = 1}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get, url: "in-app-notifications");
  }

  Future<HTTPResponseModel> userOrder({int? page = 1}) async {
    return await _networkHelper.runApi(type: ApiRequestType.get, url: "order");
  }

  Future<HTTPResponseModel> userCompleteOrder({int? page = 1}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get, url: "order/completed");
  }

  Future<HTTPResponseModel> sellerOrder({int? page = 1}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get, url: "order/seller");
  }

  Future<HTTPResponseModel> sellerOrderHistory({int? page = 1}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get,
        url: "order/seller/history?page=$page&limit=10");
  }
  Future<HTTPResponseModel> sellerOngoingOrder({int? page = 1}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.get,
        url: "order/seller/ongoing");
  }

  Future<HTTPResponseModel> getSubCategoriesProduct(String productType,
      {int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "product/subcategories/$productType?page=1&limit=$page",
    );
  }

  Future<HTTPResponseModel> getWishList() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "user/wishlist",
    );
  }

  Future<HTTPResponseModel> getAllSizes() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "misc/sizes",
    );
  }

  Future<HTTPResponseModel> addWishlist({
    var productId = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'user/wishlist/toggle',
        body: {"productId": productId});
  }

  Future<HTTPResponseModel> deleteWishlist({
    var productId = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'user/wishlist/toggle',
        body: {"productId": productId});
  }

  Future<HTTPResponseModel> addToCart({
    String sku = "",
    num quantity = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'cart/add',
        body: {"productId": sku, "quantity": quantity});
  }

  Future<HTTPResponseModel> addToCartGuest(
      {String sku = "", num quantity = 0, String guestId = ''}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'main-svc-v2/guest/cart/add',
        body: {
          "products": [
            {"sku": sku, "quantity": quantity}
          ],
          "guest_token": guestId
        });
  }

  Future<HTTPResponseModel> removeFromCart({
    String? id,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.delete, url: 'cart/$id', body: {"productId": id});
  }

  Future<HTTPResponseModel> removeFromCartGuest(
      {var id = 0, String guestId = ''}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'main-svc-v2/guest/cart/delete',
        body: {"sku": id, "guest_token": guestId});
  }

  Future<HTTPResponseModel> updateCart({
    var id = 0,
    // num cartId = 0,
    num quantity = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.patch,
        url: 'cart/$id/quantity',
        body: {"productId": id, "quantity": quantity});
  }

  Future<HTTPResponseModel> updateCartGuest(
      {var id = 0,
      //num cartId = 0,
      num quantity = 0,
      String guestId = ''}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.put,
        url: 'main-svc-v2/guest/cart/update',
        body: {"quantity": quantity, "sku": id, "guest_token": guestId});
  }

  Future<HTTPResponseModel> fetchCart({String id = ""}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'cart',
    );
  }

  Future<HTTPResponseModel> fetchCartGuest() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'cart',
    );
  }

  Future<HTTPResponseModel> negotiateProduct(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "negotiations",
      body: body,
    );
  }

  Future<HTTPResponseModel> offerResponse(
      Map<String, dynamic> body, String negID) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "negotiations/$negID/respond",
      body: body,
    );
  }

  Future<HTTPResponseModel> cancelOffer(
      Map<String, dynamic> body, String negID) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "negotiations/$negID/cancel",
      body: body,
    );
  }

  Future<HTTPResponseModel> sellerAcceptOrder(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "order/seller-actions",
      body: body,
    );
  }

  //---------//
  Future<HTTPResponseModel> getNegotiableP() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "negotiations?role=buyer&page=1&limit=10",
    );
  }

  Future<HTTPResponseModel> getSellerNegotiableP() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "negotiations?role=seller&page=1&limit=10",
    );
  }
}
