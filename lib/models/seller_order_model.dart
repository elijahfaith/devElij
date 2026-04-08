// class SellerOrderModel {
//   final String id;
//   final SellerOrderUser user;
//   final List<SellerOrderItem> items;
//   final int subtotal;
//   final int tax;
//   final int deliveryFee;
//   final int totalAmount;
//   final String currency;
//   final int payoutAmount;
//   final int commission;
//   final String payoutStatus;
//   final String status;
//   final String paymentStatus;
//   final String deliveryStatus;
//   final String deliveryAddress;
//   final ShipBubbleInfo shipBubbleInfo;
//   final String paymentMethod;
//   final String paymentReference;
//   final String notes;
//   final String createdAt;
//   final String updatedAt;
//   final String orderNumber;
//
//   SellerOrderModel({
//     required this.id,
//     required this.user,
//     required this.items,
//     required this.subtotal,
//     required this.tax,
//     required this.deliveryFee,
//     required this.totalAmount,
//     required this.currency,
//     required this.payoutAmount,
//     required this.commission,
//     required this.payoutStatus,
//     required this.status,
//     required this.paymentStatus,
//     required this.deliveryStatus,
//     required this.deliveryAddress,
//     required this.shipBubbleInfo,
//     required this.paymentMethod,
//     required this.paymentReference,
//     required this.notes,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.orderNumber,
//   });
//
//   factory SellerOrderModel.fromJson(Map<String, dynamic> json) {
//     return SellerOrderModel(
//       id: json['_id'],
//       user: SellerOrderUser.fromJson(json['userId']),
//       items: List<SellerOrderItem>.from(
//         json['items'].map((x) => SellerOrderItem.fromJson(x)),
//       ),
//       subtotal: json['subtotal'],
//       tax: json['tax'],
//       deliveryFee: json['deliveryFee'],
//       totalAmount: json['totalAmount'],
//       currency: json['currency'],
//       payoutAmount: json['payoutAmount'],
//       commission: json['commission'],
//       payoutStatus: json['payoutStatus'],
//       status: json['status'],
//       paymentStatus: json['paymentStatus'],
//       deliveryStatus: json['deliveryStatus'],
//       deliveryAddress: json['deliveryAddress'],
//       shipBubbleInfo: ShipBubbleInfo.fromJson(json['shipBubbleInfo']),
//       paymentMethod: json['paymentMethod'],
//       paymentReference: json['paymentReference'],
//       notes: json['notes'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       orderNumber: json['orderNumber'],
//     );
//   }
// }
//
// class SellerOrderUser {
//   final String id;
//   final String email;
//   final String firstname;
//   final String username;
//   final String lastname;
//   final String imagePath;
//   final Location location;
//
//   SellerOrderUser({
//     required this.id,
//     required this.email,
//     required this.firstname,
//     required this.username,
//     required this.lastname,
//     required this.location,
//     required this.imagePath
//   });
//
//   factory SellerOrderUser.fromJson(Map<String, dynamic> json) {
//     return SellerOrderUser(
//       id: json['_id'],
//       email: json['email'],
//       imagePath: json['image'],
//       firstname: json['firstname'],
//       username: json['username'],
//       lastname: json['lastname'],
//       location: Location.fromJson(json['location']),
//     );
//   }
// }
//
// class Location {
//   final List<double> coordinates;
//
//   Location({required this.coordinates});
//
//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
//     );
//   }
// }
//
// class SellerOrderItem {
//   final ProductSummary product;
//   final int quantity;
//   final int price;
//   final String seller;
//   final String status;
//   final String statusUpdatedAt;
//   final String id;
//
//   SellerOrderItem({
//     required this.product,
//     required this.quantity,
//     required this.price,
//     required this.seller,
//     required this.status,
//     required this.statusUpdatedAt,
//     required this.id,
//   });
//
//   factory SellerOrderItem.fromJson(Map<String, dynamic> json) {
//     return SellerOrderItem(
//       product: ProductSummary.fromJson(json['product']),
//       quantity: json['quantity'],
//       price: json['price'],
//       seller: json['seller'],
//       status: json['status'],
//       statusUpdatedAt: json['statusUpdatedAt'],
//       id: json['_id'],
//     );
//   }
// }
//
// class ProductSummary {
//   final String id;
//   final String name;
//   final int price;
//   final List<String> images;
//
//   ProductSummary({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.images,
//   });
//
//   factory ProductSummary.fromJson(Map<String, dynamic> json) {
//     return ProductSummary(
//       id: json['_id'],
//       name: json['name'],
//       price: json['price'],
//       images: List<String>.from(json['images']),
//     );
//   }
// }
//
// class ShipBubbleInfo {
//   final String courierId;
//   final String courierName;
//   final int deliveryFee;
//   final String status;
//   final String serviceCode;
//   final String id;
//
//   ShipBubbleInfo({
//     required this.courierId,
//     required this.courierName,
//     required this.deliveryFee,
//     required this.status,
//     required this.serviceCode,
//     required this.id,
//   });
//
//   factory ShipBubbleInfo.fromJson(Map<String, dynamic> json) {
//     return ShipBubbleInfo(
//       courierId: json['courierId'],
//       courierName: json['courierName'],
//       deliveryFee: json['deliveryFee'],
//       status: json['status'],
//       serviceCode: json['serviceCode'],
//       id: json['_id'],
//     );
//   }
// }

// Null-safe, defensive SellerOrderModel (Dart)
// Created to closely match your original model but handle missing/null JSON values

// Helper parsing utilities
int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}

String _toString(dynamic v) => v == null ? '' : v.toString();

List<T> _toList<T>(dynamic v, T Function(dynamic) mapper) {
  if (v == null) return <T>[];
  if (v is List) return v.map(mapper).toList().cast<T>();
  return <T>[];
}

List<String> _toStringList(dynamic v) {
  if (v == null) return <String>[];
  if (v is List) return v.map((e) => e?.toString() ?? '').toList().cast<String>();
  return <String>[];
}

List<double> _toDoubleList(dynamic v) {
  if (v == null) return <double>[];
  if (v is List) {
    return v.map((e) {
      if (e == null) return 0.0;
      if (e is double) return e;
      if (e is int) return e.toDouble();
      return double.tryParse(e.toString()) ?? 0.0;
    }).toList();
  }
  return <double>[];
}

// Main model
class SellerOrderModel {
  final String id;
  final SellerOrderUser user;
  final List<SellerOrderItem> items;
  final int subtotal;
  final int tax;
  final int deliveryFee;
  final int totalAmount;
  final String currency;
  final int payoutAmount;
  final int commission;
  final String payoutStatus;
  final String status;
  final String paymentStatus;
  final String deliveryStatus;
  final String deliveryAddress;
  final ShipBubbleInfo shipBubbleInfo;
  final String paymentMethod;
  final String paymentReference;
  final String notes;
  final String createdAt;
  final String updatedAt;
  final String orderNumber;

  SellerOrderModel({
    required this.id,
    required this.user,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.totalAmount,
    required this.currency,
    required this.payoutAmount,
    required this.commission,
    required this.payoutStatus,
    required this.status,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.deliveryAddress,
    required this.shipBubbleInfo,
    required this.paymentMethod,
    required this.paymentReference,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
  });

  factory SellerOrderModel.fromJson(Map<String, dynamic> json) {
    return SellerOrderModel(
      id: _toString(json['_id']),
      user: json['userId'] != null
          ? SellerOrderUser.fromJson(json['userId'])
          : SellerOrderUser.empty(),
      items: _toList<SellerOrderItem>(json['items'], (x) => SellerOrderItem.fromJson(x)),
      subtotal: _toInt(json['subtotal']),
      tax: _toInt(json['tax']),
      deliveryFee: _toInt(json['deliveryFee']),
      totalAmount: _toInt(json['totalAmount']),
      currency: _toString(json['currency']),
      payoutAmount: _toInt(json['payoutAmount']),
      commission: _toInt(json['commission']),
      payoutStatus: _toString(json['payoutStatus']),
      status: _toString(json['status']),
      paymentStatus: _toString(json['paymentStatus']),
      deliveryStatus: _toString(json['deliveryStatus']),
      deliveryAddress: _toString(json['deliveryAddress']),
      shipBubbleInfo: json['shipBubbleInfo'] != null
          ? ShipBubbleInfo.fromJson(json['shipBubbleInfo'])
          : ShipBubbleInfo.empty(),
      paymentMethod: _toString(json['paymentMethod']),
      paymentReference: _toString(json['paymentReference']),
      notes: _toString(json['notes']),
      createdAt: _toString(json['createdAt']),
      updatedAt: _toString(json['updatedAt']),
      orderNumber: _toString(json['orderNumber']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': user.toJson(),
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'totalAmount': totalAmount,
      'currency': currency,
      'payoutAmount': payoutAmount,
      'commission': commission,
      'payoutStatus': payoutStatus,
      'status': status,
      'paymentStatus': paymentStatus,
      'deliveryStatus': deliveryStatus,
      'deliveryAddress': deliveryAddress,
      'shipBubbleInfo': shipBubbleInfo.toJson(),
      'paymentMethod': paymentMethod,
      'paymentReference': paymentReference,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'orderNumber': orderNumber,
    };
  }
}

// User
class SellerOrderUser {
  final String id;
  final String email;
  final String firstname;
  final String username;
  final String lastname;
  final String imagePath;
  final Location location;

  SellerOrderUser({
    required this.id,
    required this.email,
    required this.firstname,
    required this.username,
    required this.lastname,
    required this.imagePath,
    required this.location,
  });

  factory SellerOrderUser.fromJson(Map<String, dynamic> json) {
    return SellerOrderUser(
      id: _toString(json['_id'] ?? json['id']),
      email: _toString(json['email']),
      firstname: _toString(json['firstname']),
      username: _toString(json['username']),
      lastname: _toString(json['lastname']),
      imagePath: _toString(json['image'] ?? json['imagePath']),
      location: json['location'] != null ? Location.fromJson(json['location']) : Location.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstname': firstname,
      'username': username,
      'lastname': lastname,
      'image': imagePath,
      'location': location.toJson(),
    };
  }

  // convenience empty user to avoid null checks
  factory SellerOrderUser.empty() => SellerOrderUser(
    id: '',
    email: '',
    firstname: '',
    username: '',
    lastname: '',
    imagePath: '',
    location: Location.empty(),
  );
}

class Location {
  final List<double> coordinates; // keep as list<double> (likely [lng, lat])

  Location({required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    // JSON may be: { "coordinates": [lng, lat] }
    final coords = json['coordinates'];
    return Location(
      coordinates: _toDoubleList(coords),
    );
  }

  Map<String, dynamic> toJson() => {'coordinates': coordinates};

  factory Location.empty() => Location(coordinates: <double>[]);
}

// Order item
class SellerOrderItem {
  final ProductSummary product;
  final int quantity;
  final int price;
  final String seller;
  final String status;
  final String statusUpdatedAt;
  final String id;

  SellerOrderItem({
    required this.product,
    required this.quantity,
    required this.price,
    required this.seller,
    required this.status,
    required this.statusUpdatedAt,
    required this.id,
  });

  factory SellerOrderItem.fromJson(Map<String, dynamic> json) {
    return SellerOrderItem(
      product: json['product'] != null
          ? ProductSummary.fromJson(json['product'])
          : ProductSummary.empty(),
      quantity: _toInt(json['quantity']),
      price: _toInt(json['price']),
      seller: _toString(json['seller']),
      status: _toString(json['status']),
      statusUpdatedAt: _toString(json['statusUpdatedAt']),
      id: _toString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
    'price': price,
    'seller': seller,
    'status': status,
    'statusUpdatedAt': statusUpdatedAt,
    '_id': id,
  };
}

class ProductSummary {
  final String id;
  final String name;
  final int price;
  final List<String> images;

  ProductSummary({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
  });

  factory ProductSummary.fromJson(Map<String, dynamic> json) {
    return ProductSummary(
      id: _toString(json['_id']),
      name: _toString(json['name']),
      price: _toInt(json['price']),
      images: _toStringList(json['images']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'price': price,
    'images': images,
  };

  factory ProductSummary.empty() => ProductSummary(id: '', name: '', price: 0, images: <String>[]);
}

class ShipBubbleInfo {
  final String courierId;
  final String courierName;
  final int deliveryFee;
  final String status;
  final String serviceCode;
  final String id;
  final String requestToken;
  final String buyerDeliveryAddress; // sometimes API returns string address
  final List<dynamic> items;

  ShipBubbleInfo({
    required this.courierId,
    required this.courierName,
    required this.deliveryFee,
    required this.status,
    required this.serviceCode,
    required this.id,
    required this.requestToken,
    required this.buyerDeliveryAddress,
    required this.items,
  });

  factory ShipBubbleInfo.fromJson(Map<String, dynamic> json) {
    return ShipBubbleInfo(
      courierId: _toString(json['courierId']),
      courierName: _toString(json['courierName']),
      deliveryFee: _toInt(json['deliveryFee']),
      status: _toString(json['status']),
      serviceCode: _toString(json['serviceCode'] ?? json['service']),
      id: _toString(json['_id']),
      requestToken: _toString(json['requestToken']),
      buyerDeliveryAddress: _toString(json['buyerDeliveryAddress'] ?? json['buyerDeliveryAddress']),
      items: json['items'] is List ? List<dynamic>.from(json['items']) : <dynamic>[],
    );
  }

  Map<String, dynamic> toJson() => {
    'courierId': courierId,
    'courierName': courierName,
    'deliveryFee': deliveryFee,
    'status': status,
    'serviceCode': serviceCode,
    '_id': id,
    'requestToken': requestToken,
    'buyerDeliveryAddress': buyerDeliveryAddress,
    'items': items,
  };

  factory ShipBubbleInfo.empty() => ShipBubbleInfo(
    courierId: '',
    courierName: '',
    deliveryFee: 0,
    status: '',
    serviceCode: '',
    id: '',
    requestToken: '',
    buyerDeliveryAddress: '',
    items: <dynamic>[],
  );
}
