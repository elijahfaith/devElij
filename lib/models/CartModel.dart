class CartModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final int totalAmount;
  final int itemCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.itemCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["_id"] ?? '',
      userId: json["userId"] ?? '',
      items: (json["items"] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      totalAmount: json["totalAmount"] ?? 0,
      itemCount: json["itemCount"] ?? 0,
      isActive: json["isActive"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
    );
  }
}

class CartItem {
  final String id;
  final Product? product;
  final int quantity;
  final int price;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["_id"] ?? '',
      product: json["product"] != null
          ? Product.fromJson(json["product"])
          : null,
      quantity: json["quantity"] ?? 0,
      price: json["price"] ?? 0,
    );
  }
}

class Product {
  final String id;
  final String name;
  final int price;
  final Seller? seller;
  final List<String> images;
  final int stock;
  final bool isActive;
  final bool isApproved;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.seller,
    required this.images,
    required this.stock,
    required this.isActive,
    required this.isApproved,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      price: json["price"] ?? 0,
      seller: json["seller"] != null
          ? Seller.fromJson(json["seller"])
          : null,
      images: List<String>.from(json["images"] ?? []),
      stock: json["stock"] ?? 0,
      isActive: json["isActive"] ?? false,
      isApproved: json["isApproved"] ?? false,
    );
  }

  factory Product.empty() {
    return Product(
      id: '',
      name: '',
      price: 0,
      seller: null,
      images: [],
      stock: 0,
      isActive: false,
      isApproved: false,
    );
  }
}

class Seller {
  final String id;
  final String? firstname;
  final String? lastname;
  final String? username;

  Seller({
    required this.id,
    this.firstname,
    this.lastname,
    this.username,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json["_id"] ?? json["id"] ?? '',
      firstname: json["firstname"],
      lastname: json["lastname"],
      username: json["username"],
    );
  }

  factory Seller.empty() {
    return Seller(
      id: '',
      firstname: null,
      lastname: null,
      username: null,
    );
  }
}
