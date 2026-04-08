import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_go/models/CartModel.dart';
import 'package:link_go/models/CategoriesModel.dart';
import 'package:link_go/models/MarketListModel.dart';
import 'package:link_go/models/Products.dart';
import 'package:link_go/models/WishListModel.dart';
import 'package:link_go/models/brandListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_go/models/product_condition_model.dart';
import 'package:link_go/models/sizes_model.dart';
import 'package:link_go/models/util_model.dart';
import 'package:link_go/providers/provider.dart';
import 'package:link_go/repository/product_repository.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/services/navigation/route_names.dart';
import 'package:link_go/utils/assets_manager.dart';
import 'package:link_go/utils/base_model.dart';
import 'package:link_go/utils/enums.dart';
import 'package:link_go/utils/helpers.dart';
import '../app/bottom_nav/nav_service.dart';
import '../app/widgets/global.dart';
import '../models/BestSellerModel.dart';
import 'package:link_go/models/categoryByHierachy.dart' as hierarchy;
import '../models/categories_with_subcategories.dart';
import '../models/completedOrderModel.dart';
import '../models/gender_category_model.dart';
import '../models/in_app_notification_model.dart';
import '../models/negotiation_model.dart';
import '../models/order_model.dart';
import '../models/product_colors.dart';
import '../models/product_details_model.dart';
import 'package:path_provider/path_provider.dart'; // For getTemporaryDirectory()
import 'package:path/path.dart'; // For basename()
import 'dart:io'; // For File
import 'package:dio/dio.dart';

import '../models/product_review.dart';
import '../models/rates_model.dart';
import '../models/reviewWithRatings.dart';
import '../models/seller_order_history_model.dart';
import '../models/seller_order_model.dart';
import '../models/storage/bank_model.dart'; // Since you're using Dio to download images

class ProductProvider extends BaseModel {
  final Ref reader;
  ProductProvider.init({
    required this.reader,
  });

  final _productRepository = ProductRepository();
  Future<List<MarketListModel>>? market;
  Future<List<BrandListModel>>? brand;
  Future<List<CategoriesModel>>? categories;
  Future<List<Products>>? products;
  Future<List<OrderModel>>? userOrder;
  Future<List<OrderModel>>? completedOrder;
  Future<List<SellerOrderModel>>? sellerOrder;
  Future<List<SellerOrderData>>? sellerOrderHistory;
  Future<List<SellerOrderData>>? sellerOngoingOrder;
  Future<List<CategoryModel>>? categoWithSub;
  Future<List<Products>>? userListings;
  Future<List<Products>>? newProducts;
  List<NegotiatedProduct> negotiableProduct = [];
  List<NegotiatedProduct> negotiableSellerProduct = [];
  List<Products>? discountedProduct = [];
  List<Products>? wishListProduct = [];
  List<String> filterSizes = [];
  List<Products>? similarProduct = [];
  //List<Products>? sellerListings = [];
  bool isFetchingSellerListings = true;
  bool isFetchingSimilarProducts = true;
  List<Products>? sellerListings;
  List<ProductReview>? review;
  ReviewWithRatings? reviewWithRatings;

  Future<void> fetchSellerListings(userID, shopId) async {
    isFetchingSellerListings = true;
    //  notifyListeners();
    sellerListings = await getSellerListing(userID);
    // review = await reviewGet(shopId);
    reviewWithRatings = await getReviewWithRatings(shopId);
    isFetchingSellerListings = false;
    notifyListeners();
  }

  Future<void> fetchSimilarProducts(productId) async {
    isFetchingSimilarProducts = true;
    // notifyListeners();
    similarProduct = await getSimilarProduct(productId);
    isFetchingSimilarProducts = false;
    notifyListeners();
  }



  Future<List<Products>>? fashionProduct;
  List<ProductsColor> productColor = [];
  List<ProductsCondition> productCondition = [];
  Products? productDetails;
  Future<List<Products>>? electronicProducts;
  Future<List<Products>>? searchProduct;
  List<Products> filteredProduct = [];
  List<Products> searchedFilteredProducts = [];
  Future<List<Products>>? selectedProduct;
  Future<List<Products>>? marketProduct;
  Future<List<Products>>? productBySeller;
  Future<List<BestSellerModel>>? bestSeller;

  bool isFilterApplied = false;
  bool isFilterLoading = false;

  void setFilterLoading(bool value) {
    isFilterLoading = value;
    notifyListeners();
  }

  void applyFilter(List<Products> results) {
    filteredProduct = results;
    isFilterApplied = true;
    notifyListeners();
  }

  void markFilterAsApplied() {
    isFilterApplied = true;
    notifyListeners();
  }

  void clearFilteredProduct() {
    filteredProduct = [];
    isFilterApplied = false;
    notifyListeners();
  }

  //Search filter
  bool isSearchFilterApplied = false;
  void applySearchFilter(List<Products> results) {
    filteredProduct = results;
    isSearchFilterApplied = true;
    notifyListeners();
  }

  void markSearchFilterAsApplied() {
    isSearchFilterApplied = true;
    notifyListeners();
  }

  void clearSearchedFilteredProduct() {
    searchedFilteredProducts = [];
    isSearchFilterApplied = false;
    notifyListeners();
  }

  //Pagination
 late Rates? _ratings;
  Rates? get ratings => _ratings;

  LoadingState _loadingState = LoadingState.idle;

  LoadingState get loadingState => _loadingState;

  LoadingState _fetchState = LoadingState.idle;

  LoadingState get fetchState => _fetchState;

  int _nextPage = 1;

  int get nextPage => _nextPage;
  int? _orderCount = 1;

  int? get orderCount => _orderCount;

  List<Products>? get allProduct => _allProduct;
  List<Products>? _allProduct;

  CartModel? _cartModel;

  CartModel? get cartModel => _cartModel;

  NotificationData? _notificationModel;

  NotificationData? get notificationModel => _notificationModel;

  NavigatorService _navigation = NavigatorService();

  LoadingState _loadingWishState = LoadingState.idle;

  LoadingState get loadingWishState => _loadingWishState;

  setLoadingWishState(LoadingState value) {
    _loadingWishState = value;
    notifyListeners();
  }

  setLoadingState(LoadingState value) {
    _loadingState = value;
    notifyListeners();
  }

  setFetchState(LoadingState value) {
    _fetchState = value;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  // Changes made start's here for the provider
  convertUsable() async {
    categoryList = await categories ?? [];
  }

  List<CategoriesModel> categoryList = [];
  int selectedIndex = 0;
  List<CategoriesModel> filteredItems = [];
  List<Children> selectedChildren = [];

  Future<void> loadFirstCategory() async {
    // categories = productCategory();
    final categoryListData = await categories!;
    categoryList = categoryListData;
    if (categoryList.isNotEmpty) {
      selectedChildren = categoryList.first.children!;
    }
    notifyListeners();
  }

  String? idFetch;

  // void clearFilteredProduct() {
  //   filteredProduct = [];
  //   notifyListeners();
  // }

  pushToAllScreen(String header, List<Products> products, {String? id}) {
    idFetch = id;
    _nextPage = 1;
    _allProduct = products;
    _nextPage = _nextPage + 1;
    notifyListeners();
    setLoadingState(LoadingState.done);
    notifyListeners();
    _navigation.navigateTo(viewAllProducts, arguments: header);
  }

  productSellerLoad(List<Products> products, {String? id}) {
    idFetch = id;
    _nextPage = 1;
    _allProduct = products;
    _nextPage = _nextPage + 1;
    notifyListeners();
    setLoadingState(LoadingState.done);
    notifyListeners();
  }
  //
  // paginateAllScreen(
  //   dynamic type,
  //   ScrollController? controller,
  // ) async {
  //   if (controller!.position.extentAfter < 100 &&
  //       fetchState != LoadingState.loading) {
  //     setFetchState(LoadingState.loading);
  //     late HTTPResponseModel res;
  //     if (type == 'Products') {
  //       res = await _productRepository.getProduct(page: _nextPage);
  //     } else {
  //       res = await _productRepository.getSubCategoriesProduct(type,
  //           page: _nextPage);
  //     }
  //
  //     if (HTTPResponseModel.isApiCallSuccess(res)) {
  //       List<Products>? packageList = List<Products>.from(
  //           res.data.map((item) => Products.fromJson(item)));
  //       _allProduct?.addAll(packageList);
  //       _nextPage = _nextPage + 1;
  //       notifyListeners();
  //       setFetchState(LoadingState.done);
  //       return res.data;
  //     } else {
  //       setFetchState(LoadingState.error);
  //       notifyListeners();
  //       throw Exception('Failed to load internet');
  //       //return ErrorModel(result.error);
  //     }
  //   }
  // }

  int? _totalPages;
  Future<void> paginateAllScreen(dynamic type, ScrollController? controller) async {
    if (controller == null) return;

    // Only fetch when near the bottom and not already loading
    if (controller.position.extentAfter < 100 && fetchState != LoadingState.loading) {
      // Stop if all pages fetched
      if (_totalPages != null && _nextPage > _totalPages!) return;

      setFetchState(LoadingState.loading);

      late HTTPResponseModel res;
      try {
        // Fetch API
        if (type == 'Products') {
          res = await _productRepository.getProduct(page: _nextPage);
        } else {
          res = await _productRepository.getSubCategoriesProduct(type, page: _nextPage);
        }

        if (!HTTPResponseModel.isApiCallSuccess(res)) {
          setFetchState(LoadingState.error);
          notifyListeners();
          return;
        }

        List<dynamic> items = [];
        int currentPage = _nextPage;
        int totalPages = _totalPages ?? 1;

        if (res.data is Map<String, dynamic>) {
          final responseData = res.data;
          items = responseData['data'] ?? [];
          currentPage = int.tryParse(responseData['page'].toString()) ?? _nextPage;
          totalPages = int.tryParse(responseData['totalPages'].toString()) ?? totalPages;
        } else if (res.data is List) {
          items = res.data;
          totalPages = 1;
        }

        // Map to Products
        List<Products> newProducts = items.map((item) => Products.fromJson(item)).toList();

        // Prevent duplicates
        _allProduct ??= [];
        final existingIds = _allProduct!.map((e) => e.id).toSet();
        newProducts = newProducts.where((p) => !existingIds.contains(p.id)).toList();

        // Add new items
        _allProduct!.addAll(newProducts);

        // Update pagination info
        _nextPage = currentPage + 1;
        _totalPages = totalPages;

        setFetchState(LoadingState.done);
        notifyListeners();
      } catch (e) {
        setFetchState(LoadingState.error);
        notifyListeners();
        rethrow;
      }
    }
  }





  negotiateProduct(BuildContext context, String productId, String message,
      String offeredPrice) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _productRepository.negotiateProduct({
        "productId": productId,
        "message": message,
        "offeredPrice": offeredPrice
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        Navigator.of(context).pop();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  acceptOffer(
    BuildContext context,
    String negId,
    String message,
    String offeredPrice,
  ) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _productRepository.offerResponse({
        "message": message,
        "offeredPrice": offeredPrice,
        "action":
            "accept", // accept | reject | counter . counter is for buyer giving second offer
      }, negId);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        negotiableProduct = await getNegotiableProduct();
        negotiableSellerProduct = await getSellerNegotiableProduct();
        //Navigator.of(context).pop();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  counterOffer(
    BuildContext context,
    String negId,
    String productID,
    String message,
    String offeredPrice,
  ) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _productRepository.offerResponse({
        "productId": productID,
        "message": message,
        "offeredPrice": offeredPrice,
        "action":
            "counter", // accept | reject | counter . counter is for buyer giving second offer
      }, negId);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        negotiableProduct = await getNegotiableProduct();
        negotiableSellerProduct = await getSellerNegotiableProduct();
        //Navigator.of(context).pop();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  cancelOffer(String negId) async {
    setBusy(true);
    try {
      HTTPResponseModel result =
          await _productRepository.cancelOffer({}, negId);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        negotiableProduct = await getNegotiableProduct();
        negotiableSellerProduct = await getSellerNegotiableProduct();
        //Navigator.of(context).pop();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  String? orderNumber;
  String? vat;
  String? commission;
  String? payout;
  String? acceptedItemsTotal;
  String? rejectedItemsTotal;
  String? totalCostofAcceptedItems;
  sellerOrderActionPreview(
    BuildContext context, {
    required String type,
    required String orderId,
    required List<String> acceptedItemIds,
    required String? rejectionReason,
  }) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _productRepository.sellerAcceptOrder(
        {
          "type": type,
          "orderId": orderId,
          "acceptedItemIds": acceptedItemIds,
          "rejectionReason":
              rejectionReason // only applicable for rejected items.
        },
      );
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        orderNumber = result.all['data']['orderNumber'].toString();
        vat = result.all['data']['vat'].toString();
        commission = result.all['data']['commission'].toString();
        payout = result.all['data']['payout'].toString();
        acceptedItemsTotal =
            result.all['data']['acceptedItemsTotal'].toString();
        rejectedItemsTotal =
            result.all['data']['rejectedItemsTotal'].toString();
        totalCostofAcceptedItems =
            result.all['data']['totalCostOfAcceptedProducts'].toString();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  sellerOrderAction(
    BuildContext context, {
    required String type,
    required String orderId,
    required List<String> acceptedItemIds,
    required String? rejectionReason,
  }) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _productRepository.sellerAcceptOrder(
        {
          "type": type,
          "orderId": orderId,
          "acceptedItemIds": acceptedItemIds,
          "rejectionReason":
              rejectionReason // only applicable for rejected items.
        },
      );
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        userOrder = getUserOrder();
        sellerOrder = getSellerOrder();
        sellerOrderHistory = getSellerOrderHistory();
        sellerOngoingOrder = getSellerOngoingOrder();
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  CategoryByGender? GenderbyCategory;
  List<CategoryByGender> _categoryByGender = [];
  List<CategoryByGender> get categoryGender => _categoryByGender;
  setGenderByCategories(List<CategoryByGender> gender) {
    _categoryByGender = gender;
    notifyListeners();
  }

  getGenderCategories() async {
    HTTPResponseModel res = await _productRepository.getGenderCategories();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      print(res);
      List<CategoryByGender> categoryGender = List<CategoryByGender>.from(
          res.data.map((item) => CategoryByGender.fromJson(item)));
      notifyListeners();
      setGenderByCategories(categoryGender);
      return categoryGender;
    } else {
      setFetchState(LoadingState.error);
      notifyListeners();
      throw Exception('Failed to load internet');
      //return ErrorModel(result.error);
    }
    //}
    // }
  }

  // Future<List<CategoryModel>> getCategoriesSub() async {
  //   var res = await _productRepository.getCategoriesSubcategories();
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     List<CategoryModel> categorySubcat = (res.data as List)
  //         .map((item) => CategoryModel.fromJson(item))
  //         .toList();
  //     notifyListeners();
  //     return categorySubcat;
  //   } else {
  //     setFetchState(LoadingState.error);
  //     notifyListeners();
  //     throw Exception('Failed to load categories');
  //   }
  // }

  Future<List<CategoryModel>> getCategoriesSub() async {
    var res = await _productRepository.getCategoriesSubcategories();

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      // Step 1: Parse all categories from API
      List<CategoryModel> allCategories = (res.data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();

      // Step 2: Build nested category structure
      List<CategoryModel> buildTree(String parentId) {
        return allCategories
            .where((cat) => cat.parentIds.contains(parentId))
            .map((cat) {
          cat.subcategories = buildTree(cat.id); // recursive
          return cat;
        }).toList();
      }

      // Step 3: Filter top-level categories and populate their subcategories
      List<CategoryModel> topLevelCategories = allCategories
          .where((cat) => cat.parentIds.isEmpty) // categories with no parent
          .map((cat) {
        cat.subcategories = buildTree(cat.id);
        return cat;
      }).toList();

      notifyListeners();
      return topLevelCategories;
    } else {
      setFetchState(LoadingState.error);
      notifyListeners();
      throw Exception('Failed to load categories');
    }
  }

  ProductsColor? selectedColor;
  List<ProductsColor> filteredColors = [];
  List<CategoryModel>? selectedFilterCategory;
  ProductsCondition? selectedCondition;
  // ProductsCondition? filteredCondition;
  List<ProductsCondition> filteredConditions = [];
  hierarchy.Attribute? selectedSize;
  String? selectedSizeValue;
  hierarchy.CategoryGender? selectedGender;
  hierarchy.Category? selectedCategory;
  hierarchy.SubCategory? selectedSubCategory;

  List<hierarchy.CategoryGender> _genderData = [];

  List<hierarchy.CategoryGender> get genderData => _genderData;

  void setGenderData(List<hierarchy.CategoryGender> data) {
    _genderData = data;
    notifyListeners();
  }

  void selectGender(hierarchy.CategoryGender gender) {
    selectedGender = gender;
    selectedCategory = null;
    selectedSubCategory = null;
    notifyListeners();
  }

  void selectCategory(hierarchy.Category category) {
    selectedCategory = category;
    selectedSubCategory = null;
    notifyListeners();
  }

  void selectSubCategory(hierarchy.SubCategory sub) {
    selectedSubCategory = sub;
    notifyListeners();
  }

  List<hierarchy.Category> get category => selectedGender?.categories ?? [];
  List<hierarchy.SubCategory> get subcategories =>
      selectedCategory?.subcategories ?? [];

  List<String> get sizes {
    final attributes = selectedSubCategory?.attributes ?? [];
    final sizeAttribute = attributes.firstWhere(
      (attr) => attr.name.toLowerCase() == 'size',
      orElse: () => hierarchy.Attribute(id: '', name: '', values: []),
    );
    return sizeAttribute.values;
  }

  Future<List<hierarchy.CategoryGender>> getCategoriesByHierarchy() async {
    try {
      final HTTPResponseModel res =
          await _productRepository.categoryByHirachy();
      if (HTTPResponseModel.isApiCallSuccess(res)) {
        final List<hierarchy.CategoryGender> genderCategoryList =
            List<hierarchy.CategoryGender>.from(
          res.data.map((item) => hierarchy.CategoryGender.fromJson(item)),
        );
        setGenderData(genderCategoryList);
        return genderCategoryList;
      } else {
        return [];
        //throw Exception('Failed to load category hierarchy');
      }
    } catch (e) {
      setFetchState(LoadingState.error); // Optional
      rethrow;
    }
  }

  Future<List<MultipartFile>> prepareMultipleFiles(List<File> images) async {
    List<MultipartFile> multiPartFiles = [];

    for (var file in images) {
      String fileName = file.path.split('/').last;
      multiPartFiles.add(
        await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    return multiPartFiles;
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productAmountInStockController =
      TextEditingController();

  createProductListings(List<File> images) async {
    setBusy(true);
    try {
      List<MultipartFile> multiPartFiles = await prepareMultipleFiles(images);
      HTTPResponseModel result =
          await _productRepository.createProductListings({
        "images": multiPartFiles,
        // await MultipartFile.fromFile(
        //   dp!,
        //   filename: dpName,
        //   contentType: mimeType,
        // ),
        "name": productNameController.text,
        "gender": selectedGender?.id,
        "description": productDescriptionController.text,
        "color": selectedColor?.id,
        "price": double.tryParse(productPriceController.text
                .replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0,
        "category": selectedCategory?.id,
        "subCategory": selectedSubCategory?.id,
        "size": selectedSizeValue,
        "condition": selectedCondition?.id,
        "stock": productAmountInStockController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        print(result.all);
        clearForm();
        userListings = getUserListings();
        products = getProducts();
        reader.read(RiverpodProvider.accountProvider).getUserProfile();
        reader
            .read(RiverpodProvider.navStateProvider)
            .setCurrentTabTo(newTabIndex: 4);
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  deleteProductListings(String productId) async {
    setBusy(true);
    try {
      final result = await _productRepository
          .deleteListedProduct(productId); // You must pass the productId here
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        userListings = getUserListings();
        products = getProducts();
        reader.read(RiverpodProvider.accountProvider).getUserProfile();
        NavigatorService().pop(NavigatorService().navigationKey.currentState);
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  hideProductListings(String productId) async {
    setBusy(true);
    try {
      final result = await _productRepository
          .hidelistedProduct(productId); // You must pass the productId here
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        // showToast(message: result.all['message']);
        showToast(message: 'Product Listings updated');
        userListings = getUserListings();
        products = getProducts();
        //NavigatorService().pop(NavigatorService().navigationKey.currentState);
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  markAsRead(String? notificationID) async {
    setBusy(true);
    try {
      final result = await _productRepository
          .markasRead(notificationID); // You must pass the productId here
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        notification();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  markAllAsRead() async {
    setBusy(true);
    try {
      final result = await _productRepository
          .markAllAsRead();
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
       _notificationModel = await notification();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  deleteNotificaation(String? notificationId) async {
    setBusy(true);
    try {
      final result = await _productRepository
          .deleteNotification(notificationId);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.message);
        _notificationModel = await notification();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }


  List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  Future<void> takePictures() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (selectedImages.length + pickedFiles.length > 6) {
        final context = NavigatorService().navigationKey!.currentContext;
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            showErrorToast(message: 'You can only select up to 6 images.')
                as SnackBar,
          );
        }

        return;
      }
      selectedImages.addAll(pickedFiles.map((xfile) => File(xfile.path)));
      notifyListeners();
    }
  }
  //
  // Future<void> takePicture() async {
  //   final XFile? pickedFile =
  //       await _picker.pickMultiImage(source: ImageSource.gallery);
  //   if (pickedFile != null && selectedImages.length < 6) {
  //     selectedImages.add(File(pickedFile.path));
  //     notifyListeners();
  //   } else if (selectedImages.length >= 6) {
  //     ScaffoldMessenger.of(
  //             NavigatorService().navigationKey!.currentState as BuildContext)
  //         .showSnackBar(
  //       showErrorToast(message: 'You can only select up to 6 images.')
  //           as SnackBar,
  //     );
  //   }
  // }

  bool isEditMode = false;

  updateProductListing(
      {required String productId,
      required List<File> images,
      selectedSizeIndex}) async {
    try {
      setBusy(true);
      List<MultipartFile> multiPartFiles = await prepareMultipleFiles(images);
      final response = await _productRepository.updateProduct({
        "name": productNameController.text,
        "description": productDescriptionController.text,
        "gender": selectedGender?.id,
        "color": selectedColor?.id,
        "price": double.tryParse(productPriceController.text
                .replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0,
        "category": selectedCategory?.id,
        "subCategory": selectedSubCategory?.id,
        "condition": selectedCondition?.id,
        "size":
            selectedSizeValue, // selectedSize?.name, //selectedSubCategory?.id,
        "stock": productAmountInStockController.text,
        "images": multiPartFiles,
        // "approvedBy": approvedBy,
      }, productId);

      if (HTTPResponseModel.isApiCallSuccess(response)) {
        showToast(message: "Product updated successfully");
        userListings = getUserListings();
        products = getProducts();
        reader.read(RiverpodProvider.accountProvider).getUserProfile();
        NavigatorService().pop(NavigatorService().navigationKey.currentState);
        clearForm();
      } else {
        showErrorToast(message: response.all['message']);
      }
    } catch (e) {
      showErrorToast(message: e.toString());
    } finally {
      setBusy(false);
    }
  }

  void clearForm() {
    productNameController.clear();
    productDescriptionController.clear();
    productPriceController.clear();
    productAmountInStockController.clear();
    selectedGender = null;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedColor = null;
    selectedImages.clear();
    isEditMode = false;
    notifyListeners();
  }

  Future<List<File>> downloadProductImages(List<String> imageUrls) async {
    final tempDir = await getTemporaryDirectory();
    List<File> downloadedFiles = [];
    for (String url in imageUrls) {
      try {
        setBusy(true);
        String fileName = basename(url);
        File file = File('${tempDir.path}/$fileName');
        await Dio().download(url, file.path);
        downloadedFiles.add(file);
        setBusy(false);
      } catch (e) {
        print("Failed to download image: $e");
      }
    }

    return downloadedFiles;
  }

  Future<List<Products>> getProducts(
      { double? long, double? lat}) async {
    HTTPResponseModel res = await _productRepository.getProduct(
         long: long, lat: lat);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> getProductList =
          List<Products>.from(res.data.map((item) => Products.fromJson(item)));
      notifyListeners();
      return getProductList;
    } else {
      return [];
    }
  }

  //
  // List<Products> homeProducts = [];
  // LoadingState homeState = LoadingState.idle;
  // int _homePage = 1;
  // int? _homeTotalPages;
  //
  // Future<void> getHomeProducts({double? long, double? lat, bool reset = false}) async {
  //   if (reset) {
  //     homeProducts = [];
  //     _homePage = 1;
  //     _homeTotalPages = null;
  //   }
  //
  //   if (_homeTotalPages != null && _homePage > _homeTotalPages!) return;
  //
  //   homeState = LoadingState.loading;
  //   notifyListeners();
  //
  //   try {
  //     final res = await _productRepository.getProduct(
  //       page: _homePage,
  //       lat: lat,
  //       long: long,
  //     );
  //
  //     if (!HTTPResponseModel.isApiCallSuccess(res)) {
  //       homeState = LoadingState.error;
  //       notifyListeners();
  //       return;
  //     }
  //
  //     List<dynamic> items = [];
  //     int totalPages = _homeTotalPages ?? 1;
  //
  //     if (res.data is Map<String, dynamic>) {
  //       items = res.data['data'] ?? [];
  //       totalPages = int.tryParse(res.data['totalPages'].toString()) ?? totalPages;
  //     } else if (res.data is List) {
  //       items = res.data;
  //       totalPages = 1;
  //     }
  //
  //     List<Products> newProducts = items.map((e) => Products.fromJson(e)).toList();
  //
  //     final existingIds = homeProducts.map((e) => e.id).toSet();
  //     newProducts = newProducts.where((p) => !existingIds.contains(p.id)).toList();
  //
  //     homeProducts.addAll(newProducts);
  //
  //     _homePage++;
  //     _homeTotalPages = totalPages;
  //
  //     homeState = LoadingState.done;
  //     notifyListeners();
  //   } catch (e) {
  //     homeState = LoadingState.error;
  //     notifyListeners();
  //   }
  // }


  // Future<List<Products>> getProducts({String? state, String? city, double? long, double? lat}) async {
  //   HTTPResponseModel res = await _productRepository.getProduct(
  //     state: state,
  //     city: city,
  //     long: long,
  //     lat: lat,
  //   );
  //
  //   debugPrint("🔍 API raw res.data: ${res.data}");
  //
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     final list = (res.data as List?) ?? []; // safe cast
  //     debugPrint("✅ Parsed list length: ${list.length}");
  //
  //     List<Products> getProductList =
  //     list.map((item) => Products.fromJson(item)).toList();
  //
  //     notifyListeners();
  //     return getProductList;
  //   } else {
  //     return [];
  //   }
  // }

  reportAndComplains(BuildContext context, List<String> images, String Reason,
      String category, String reportType, String? targetId) async {
    setBusy(true);
    try {
      //List<MultipartFile> multiPartFiles = await prepareMultipleFiles(images);
      HTTPResponseModel result = await _productRepository.reportItem({
        "reason": Reason,
        "category": category,
        "targetId": targetId,
        "reportType": reportType,
        "images": images
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        Navigator.of(context).pop();

        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  submitReview(BuildContext context, String comment, String rating,
      String? targetId) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _productRepository.reviewProduct(
          {"comment": comment, "rating": rating, "productId": targetId});
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        Navigator.of(context).pop();
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Products>> getUserListings() async {
    HTTPResponseModel res = await _productRepository.getUserProductListing();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> _userListings =
          List<Products>.from(res.data.map((item) => Products.fromJson(item)));
      notifyListeners();
      return _userListings;
    } else {
      return [];
    }
  }

  Future<void> getColor() async {
    HTTPResponseModel res = await _productRepository.fetchColor();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      productColor = List<ProductsColor>.from(
        res.data["colors"].map((item) => ProductsColor.fromJson(item)),
      );
      _ratings = Rates.fromJson(res.data["rates"]);

      if (productColor.isNotEmpty && selectedColor == null) {
        selectedColor = productColor[0];
      }
      notifyListeners();
    }
  }

  Future<void> fetchCondition() async {
    HTTPResponseModel res = await _productRepository.fetchCondition();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      productCondition = List<ProductsCondition>.from(
        res.data.map((item) => ProductsCondition.fromJson(item)),
      );
      print(res.all);
      notifyListeners();
    }
  }

  getDetailedProducts(productId) async {
    HTTPResponseModel res =
        await _productRepository.getDetailedProduct(productId);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      Products product = Products.fromJson(res.data); // parse directly
      notifyListeners();
      return product;
    } else {
      return null;
    }
  }

  reviewGet(productId) async {
    HTTPResponseModel res = await _productRepository.getReview(productId);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<ProductReview> reviewList = List<ProductReview>.from(
          res.all['data'].map((item) => ProductReview.fromJson(item)));
      notifyListeners();
      return reviewList;
    } else {
      return null;
    }
  }

  getReviewWithRatings(productId) async {
    HTTPResponseModel res =
        await _productRepository.getReviewWithRatings(productId);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      ReviewWithRatings reviewWithRatings =
          ReviewWithRatings.fromJson(res.all['data']);
      notifyListeners();
      return reviewWithRatings;
    } else {
      return null;
    }
  }

  Future<NotificationData?> notification() async {
    HTTPResponseModel res = await _productRepository.notification();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      _notificationModel = NotificationData.fromJson(res.data);
      notifyListeners();
      return _notificationModel;
    } else {
      return null;
    }
  }

  Future<List<OrderModel>> getUserOrder() async {
    HTTPResponseModel res = await _productRepository.userOrder();
    // print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<OrderModel> orderProductList = List<OrderModel>.from(
          res.data.map((item) => OrderModel.fromJson(item)));
      notifyListeners();
      return orderProductList;
    } else {
      return [];
    }
  }

  //--Todo: to work on it when user is complete to get the model
  Future<List<OrderModel>> getUserCompleteOrder() async {
    HTTPResponseModel res = await _productRepository.userCompleteOrder();
    // print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<OrderModel> completedProduct = List<OrderModel>.from(
          res.data.map((item) => OrderModel.fromJson(item)));
      notifyListeners();
      return completedProduct;
    } else {
      return [];
    }
  }
  // Future<List<CompletedOrderModel>> getUserCompleteOrder() async {
  //   HTTPResponseModel res = await _productRepository.userCompleteOrder();
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     // Ensure res.data is a map and then pick the "data" list
  //     final List<dynamic> dataList = res.data["data"] ?? [];
  //     List<CompletedOrderModel> completedOrders = dataList
  //         .map((item) => CompletedOrderModel.fromJson(item))
  //         .toList();
  //
  //     notifyListeners();
  //     return completedOrders;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List<SellerOrderModel>> getSellerOrder() async {
    HTTPResponseModel res = await _productRepository.sellerOrder();
    // print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<SellerOrderModel> sellerOrderList = List<SellerOrderModel>.from(
          res.data.map((item) => SellerOrderModel.fromJson(item)));
      notifyListeners();
      return sellerOrderList;
    } else {
      return [];
    }
  }

  Future<List<SellerOrderData>> getSellerOrderHistory() async {
    HTTPResponseModel res = await _productRepository.sellerOrderHistory();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<SellerOrderData> sellerOrderHistoryList = List<SellerOrderData>.from(
          res.data.map((item) => SellerOrderData.fromJson(item)));
      notifyListeners();
      return sellerOrderHistoryList;
    } else {
      return [];
    }
  }

  // Future<List<SellerOrderData>> getSellerOngoingOrder() async {
  //   HTTPResponseModel res = await _productRepository.sellerOngoingOrder();
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     List<SellerOrderData> sellerOngoingOrderList = List<SellerOrderData>.from(
  //         res.data.map((item) => SellerOrderData.fromJson(item)));
  //     notifyListeners();
  //     return sellerOngoingOrderList;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List<SellerOrderData>> getSellerOngoingOrder() async {
    HTTPResponseModel res = await _productRepository.sellerOngoingOrder();
    print('Ongoing API response: ${res.data}');

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<SellerOrderData> sellerOngoingOrderList = List<SellerOrderData>.from(
          res.data.map((item) => SellerOrderData.fromJson(item)));
      print('Mapped ongoing orders: ${sellerOngoingOrderList.length}');
      return sellerOngoingOrderList;
    } else {
      print('Ongoing API failed');
      return [];
    }
  }


  Future<List<NegotiatedProduct>> getNegotiableProduct() async {
    HTTPResponseModel res = await _productRepository.getNegotiableP();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<NegotiatedProduct> negotiableProductList =
          List<NegotiatedProduct>.from(
              res.data.map((item) => NegotiatedProduct.fromJson(item)));
      notifyListeners();
      return negotiableProductList;
    } else {
      return [];
    }
  }

  Future<List<NegotiatedProduct>> getSellerNegotiableProduct() async {
    HTTPResponseModel res = await _productRepository.getSellerNegotiableP();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<NegotiatedProduct> negotiableSellerProductList =
          List<NegotiatedProduct>.from(
              res.data.map((item) => NegotiatedProduct.fromJson(item)));
      notifyListeners();
      return negotiableSellerProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getWishList() async {
    HTTPResponseModel res = await _productRepository.getWishList();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> wishList = List<Products>.from(
        res.all['data'].map((item) => Products.fromJson(item)),
      );
      _wishlistProductIds = wishList.map((product) => product.id!).toSet();
      wishListProduct = wishList;
      wishListProduct = wishList;
      notifyListeners();
      return wishList;
    } else {
      return [];
    }
  }

  Future<List<String>> getAllSizes() async {
    HTTPResponseModel res = await _productRepository.getAllSizes();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      // Here res.all['data'] is List<dynamic> of strings, so cast directly
      filterSizes = List<String>.from(res.all['data']);
      notifyListeners();
      return filterSizes;
    } else {
      return [];
    }
  }

  getSellerListing(userID) async {
    HTTPResponseModel res = await _productRepository.getSellerListing(userID);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> sellerListings = List<Products>.from(
          res.all['data'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return sellerListings;
    } else {
      return [];
    }
  }

  getSimilarProduct(productId) async {
    HTTPResponseModel res =
        await _productRepository.getSimilarProducts(productId);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> similarListings = List<Products>.from(
          res.all['data'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return similarListings;
    } else {
      return [];
    }
  }

  //
  // Future<List<Products>> searchP(String query) async {
  //   HTTPResponseModel res = await _productRepository.searchProduct(query);
  //   print("Response Body: ${res.all}");
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     List<Products> searchProductList = List<Products>.from(
  //       res.data.map((item) => Products.fromJson(item)),
  //     );
  //     notifyListeners(); // Notify listeners if you're using ChangeNotifier
  //     return searchProductList;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List<Products>> searchP({
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
    HTTPResponseModel res = await _productRepository.searchProduct(
      name: name,
      color: color,
      category: category,
      condition: condition,
      size: size,
      priceMin: priceMin,
      priceMax: priceMax,
      page: page,
      limit: limit,
    );
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> searchProductList = List<Products>.from(
        res.data.map((item) => Products.fromJson(item)),
      );
      notifyListeners();
      return searchProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getProductLoading(String productType) async {
    setBusy(true);
    HTTPResponseModel res =
        await _productRepository.getSubCategoriesProduct(productType);
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> subProductList =
          List<Products>.from(res.data.map((item) => Products.fromJson(item)));
      _allProduct?.addAll(subProductList);
      notifyListeners();
      return subProductList;
    } else {
      return [];
    }
  }

  Future<void> setMyProductColor() async {
    if (productColor.isEmpty) {
      await getColor();
    }
  }

  Future<void> setMyProductCondition() async {
    if (productCondition.isEmpty) {
      await fetchCondition();
    }
  }

  setMyProduct({double? long, double? lat}) async {
    if (products == null) {
      products = getProducts (long: long, lat: lat);
      notifyListeners();
    }
  }

  setMyCateWithSub() async {
    if (categoWithSub == null) {
      categoWithSub = getCategoriesSub();
      notifyListeners();
    }
  }

  setMyListingsProduct() async {
    if (userListings == null) {
      userListings = getUserListings();
      notifyListeners();
    }
  }

  bool isFetchingNegotiableProducts = false;
  setMyNegotiableProduct() async {
    isFetchingNegotiableProducts = true;
    try {
      userOrder = getUserOrder();
      completedOrder = getUserCompleteOrder();
      sellerOrder = getSellerOrder();
      sellerOrderHistory = getSellerOrderHistory();
      sellerOngoingOrder = getSellerOngoingOrder();
      negotiableProduct = await getNegotiableProduct();
      negotiableSellerProduct = await getSellerNegotiableProduct();
      isFetchingNegotiableProducts = false;
      notifyListeners();
    } catch (e) {
      isFetchingNegotiableProducts = false;
      print(e);
      notifyListeners();
    }
  }

  // setMySearchProduct(String query) async {
  //   try {
  //     searchProduct =  searchP(query);
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     notifyListeners();
  //   }
  // }

  setMySearchProduct({
    String? name,
    String? color,
    String? category,
    String? condition,
    String? size,
    int? priceMin,
    int? priceMax,
  }) async {
    try {
      searchProduct = searchP(
        name: name,
        color: color,
        category: category,
        condition: condition,
        size: size,
        priceMin: priceMin,
        priceMax: priceMax,
      );
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  // setMyFilteredProduct({
  //   String? name,
  //   String? color,
  //   String? category,
  //   String? condition,
  //   String? size,
  //   int? priceMin,
  //   int? priceMax,
  // }) async {
  //   try {
  //     filteredProduct = await searchP(
  //       name: name,
  //       color: color,
  //       category: category,
  //       condition: condition,
  //       size: size,
  //       priceMin: priceMin,
  //       priceMax: priceMax,
  //     );
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     notifyListeners();
  //   }
  // }
  Future<void> setMyFilteredProduct({
    String? name,
    List<String>? color,
    List<String>? categories,
    List<String>? condition,
    List<String>? sizes,
    int? priceMin,
    int? priceMax,
  }) async {
    try {
      setFilterLoading(true);
      // Join lists into comma-separated strings
      final categoryStr = categories?.join(',');
      final sizeStr = sizes?.join(',');
      final colorStr = color?.join(',');
      final condStr = condition?.join(',');

      filteredProduct = await searchP(
        name: name,
        color: colorStr,
        category: categoryStr,
        condition: condStr,
        size: sizeStr,
        priceMin: priceMin,
        priceMax: priceMax,
      );
      setFilterLoading(false);
      notifyListeners();
    } catch (e) {
      print('Filter Error: $e');
      notifyListeners();
    }
  }

  // Future<void> setMySearchedFilteredProduct({
  //   String? name,
  //   String? color,
  //   List<String>? categories,
  //   List<String>? condition,
  //   List<String>? sizes,
  //   int? priceMin,
  //   int? priceMax,
  // }) async {
  //   try {
  //     // Join lists into comma-separated strings
  //     final categoryStr = categories?.join(',');
  //     final sizeStr = sizes?.join(',');
  //     final conditionStr = condition?.join(',');
  //
  //
  //     searchedFilteredProducts = await searchP(
  //       name: name,
  //       color: color,
  //       category: categoryStr,
  //       condition: conditionStr,
  //       size: sizeStr,
  //       priceMin: priceMin,
  //       priceMax: priceMax,
  //     );
  //
  //     notifyListeners();
  //   } catch (e) {
  //     print('Filter Error: $e');
  //     notifyListeners();
  //   }
  // }
// Store filter state
  String? _name;
  String? _color;
  List<String>? _categories;
  List<String>? _conditions;
  List<String>? _sizes;
  int? _priceMin;
  int? _priceMax;

  Future<void> setMySearchedFilteredProduct({
    String? name,
    String? color,
    List<String>? categories,
    List<String>? condition,
    List<String>? sizes,
    int? priceMin,
    int? priceMax,
  }) async {
    try {
      setFilterLoading(true);
      // Update internal state only when a new value is provided
      if (name != null) _name = name;
      if (color != null) _color = color;
      if (categories != null) _categories = categories;
      if (condition != null) _conditions = condition;
      if (sizes != null) _sizes = sizes;
      if (priceMin != null) _priceMin = priceMin;
      if (priceMax != null) _priceMax = priceMax;

      final categoryStr =
          (categories?.isNotEmpty ?? false) ? categories!.join(',') : null;
      final sizeStr = (sizes?.isNotEmpty ?? false) ? sizes!.join(',') : null;
      final conditionStr =
          (condition?.isNotEmpty ?? false) ? condition!.join(',') : null;

      // Call search API
      searchedFilteredProducts = await searchP(
        name: _name,
        color: _color,
        category: categoryStr,
        condition: conditionStr,
        size: sizeStr,
        priceMin: _priceMin,
        priceMax: _priceMax,
      );
      setFilterLoading(false);
      notifyListeners();
    } catch (e) {
      print('Filter Error: $e');
      notifyListeners();
    }
  }

  Future<void> setMyDetailedProduct(
      String productId, BuildContext context) async {
    try {
      productDetails = await getDetailedProducts(productId);
      if (productDetails != null) {
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error fetching product details: $e");
    }
  }

  setMyWishList() async {
    setLoadingWishState(LoadingState.loading);
    try {
      wishListProduct = await getWishList();
      setLoadingWishState(LoadingState.done);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMySizes() async {
    setLoadingWishState(LoadingState.loading);
    try {
      filterSizes = await getAllSizes();
      setLoadingWishState(LoadingState.done);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyOrder() async {
    setLoadingWishState(LoadingState.loading);
    try {
      filterSizes = await getAllSizes();
      setLoadingWishState(LoadingState.done);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  // setSellerList(userID) async {
  //   try {
  //     sellerListings = await getSellerListing(userID);
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     notifyListeners();
  //   }
  // }

  setSimilarProduct(productId) async {
    try {
      similarProduct = await getSimilarProduct(productId);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  Set<String> _wishlistProductIds = {};

  bool isInWishlist(String productId) =>
      _wishlistProductIds.contains(productId);

  Future<void> addWishlist(String productId) async {
    HTTPResponseModel res =
        await _productRepository.addWishlist(productId: productId);

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      final bool isNowWishlisted = res.data['iswishlisted'] == true;
      // update local state immediately
      if (isNowWishlisted) {
        _wishlistProductIds.add(productId);
      } else {
        _wishlistProductIds.remove(productId);
      }
      await getWishList();
      notifyListeners();
      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }
  //
  // addWishlist(
  //   var productId,
  // ) async {
  //   HTTPResponseModel res =
  //       await _productRepository.addWishlist(productId: productId);
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     getWishList();
  //     notifyListeners();
  //     return res.data;
  //   } else {
  //     showErrorToast(message: res.message);
  //   }
  // }

  // deleteWishList(
  //   var productId,
  // ) async {
  //   HTTPResponseModel res =
  //       await _productRepository.deleteWishlist(productId: productId);
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     wishListProduct = getWishList();
  //     showToast(message: res.message);
  //     notifyListeners();
  //     return res.data;
  //
  //   } else {
  //     showErrorToast(message: res.message);
  //   }
  // }
  Future<void> deleteWishList(var productId) async {
    HTTPResponseModel res =
        await _productRepository.deleteWishlist(productId: productId);

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      _wishlistProductIds.remove(productId);
      final updatedList = await getWishList();
      wishListProduct = updatedList;
      notifyListeners();
      showToast(message: res.message);
    } else {
      showErrorToast(message: res.message);
    }
  }

  // Future<void> deleteWishList(var productId) async {
  //   HTTPResponseModel res = await _productRepository.deleteWishlist(productId: productId);
  //   if (HTTPResponseModel.isApiCallSuccess(res)) {
  //     final updatedList = await getWishList();
  //     wishListProduct = updatedList;
  //     notifyListeners();
  //     showToast(message: res.message);
  //   } else {
  //     showErrorToast(message: res.message);
  //   }
  // }

  loopCartToAuth() async {
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id == null) {
      fetchCart();
    } else {
      // print(offlineCart);
      // if (_offlineCart!.isNotEmpty) {
      //   for (final item in _offlineCart!) {
      //     await addToCart(item.sku ?? '', item.quantity ?? 0);
      //   }
      //   //offlineCart.clear();
      //   // fetchCart();
      // } else {
      //   fetchCart();
      // }
    }
  }

  addToCart(
    String sku,
    num quantity,
  ) async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.addToCart(sku: sku, quantity: quantity);
    } else {
      // res = await _productRepository.addToCartGuest(
      //     sku: sku,
      //     quantity: quantity,
      //     guestId: reader.read(RiverpodProvider.accountProvider).guestId);
    }

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(
          message: "Cart Successfully Updated",
          title: "Add to cart",
          icon: SvgPicture.asset(Assets.shopping_cart));
      NavigatorService().navigateTo(cartPageScreen);
      // globalScaffoldKey.currentState?.openEndDrawer();
      fetchCart();
      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }

  removeFromCart({
    var productId = 0,
    // num cartId = 0,
    // num cartItemId = 0,
  }) async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.removeFromCart(
        id: productId,
      );
    } else {
      // res = await _productRepository.removeFromCartGuest(
      //     id: productId,
      //     guestId: reader.read(RiverpodProvider.accountProvider).guestId);
    }
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(
          message: "Item removed successfully",
          title: "Remove from cart",
          icon: SvgPicture.asset(Assets.shopping_cart));
      fetchCart();
      notifyListeners();
      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }

  updateCart({
    var productId = 0,
    // num cartId = 0,
    num quantity = 0,
  }) async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.updateCart(
          id: productId, quantity: quantity);
    } else {
      // res = await _productRepository.updateCartGuest(
      //     id: productId,
      //     // cartId: cartId,
      //     quantity: quantity,
      //     guestId: reader.read(RiverpodProvider.accountProvider).guestId);
    }
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      fetchCart();
      notifyListeners();
      return res.data;
    } else {
      showErrorToast(
          message: res.message, icon: SvgPicture.asset(Assets.shopping_cart));
    }
  }

  bool isFetchingCart = false;

  fetchCart() async {
    isFetchingCart = true;
    notifyListeners();
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.fetchCart();
    } else {
      res = await _productRepository.fetchCartGuest();
    }
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      isFetchingCart = false;
      notifyListeners();
      if (reader.read(RiverpodProvider.accountProvider).currentUser.id !=
          null) {
        _cartModel = CartModel.fromJson(res.data);
      } else {
        isFetchingCart = false;
        notifyListeners();
        // List<Items> items = List<Items>.from(
        //     res.data['cart_items'].map((item) => Items.fromJson(item)));
        // _cartModel = CartModel(data: [Data(items: items)]);
        //
        // _offlineCart = items;
      }
      notifyListeners();

      return res.data;
    } else {
      isFetchingCart = false;
      showErrorToast(message: res.message);
    }
  }
}
