// class OrderModel {
//   final String id;
//   final String userId;
//   final List<OrderItem> items;
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
//   final ShipBubbleInfo? shipBubbleInfo;
//   final String paymentMethod;
//   final String paymentReference;
//   final String notes;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String orderNumber;
//
//   OrderModel({
//     required this.id,
//     required this.userId,
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
//     this.shipBubbleInfo,
//     required this.paymentMethod,
//     required this.paymentReference,
//     required this.notes,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.orderNumber,
//   });
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
//     id: json['_id'] ?? '',
//     userId: json['userId'] ?? '',
//     items: List<OrderItem>.from(json['items'].map((x) => OrderItem.fromJson(x))),
//     subtotal: json['subtotal'] ?? 0,
//     tax: json['tax'] ?? 0,
//     deliveryFee: json['deliveryFee'] ?? 0,
//     totalAmount: json['totalAmount'] ?? 0,
//     currency: json['currency'] ?? '',
//     payoutAmount: json['payoutAmount'] ?? 0,
//     commission: json['commission'] ?? 0,
//     payoutStatus: json['payoutStatus'] ?? '',
//     status: json['status'] ?? '',
//     paymentStatus: json['paymentStatus'] ?? '',
//     deliveryStatus: json['deliveryStatus'] ?? '',
//     deliveryAddress: json['deliveryAddress'] ?? '',
//     shipBubbleInfo: json['shipBubbleInfo'] != null ? ShipBubbleInfo.fromJson(json['shipBubbleInfo']) : null,
//     paymentMethod: json['paymentMethod'] ?? '',
//     paymentReference: json['paymentReference'] ?? '',
//     notes: json['notes'] ?? '',
//     createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//     updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
//     orderNumber: json['orderNumber'] ?? '',
//   );
// }
//
// class OrderItem {
//   final ProductSummary product;
//   final int quantity;
//   final int price;
//   final SellerSummary seller;
//   final String status;
//   final DateTime statusUpdatedAt;
//   final String id;
//
//   OrderItem({
//     required this.product,
//     required this.quantity,
//     required this.price,
//     required this.seller,
//     required this.status,
//     required this.statusUpdatedAt,
//     required this.id,
//   });
//
//   factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//     product: ProductSummary.fromJson(json['product']),
//     quantity: json['quantity'] ?? 0,
//     price: json['price'] ?? 0,
//     seller: SellerSummary.fromJson(json['seller']),
//     status: json['status'] ?? '',
//     statusUpdatedAt: DateTime.tryParse(json['statusUpdatedAt'] ?? '') ?? DateTime.now(),
//     id: json['_id'] ?? '',
//   );
// }
//
// class ProductSummary {
//   final String id;
//   final String name;
//   final String description;
//   final int price;
//   final List<String> images;
//
//   ProductSummary({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.images,
//   });
//
//   factory ProductSummary.fromJson(Map<String, dynamic> json) => ProductSummary(
//     id: json['_id'] ?? '',
//     name: json['name'] ?? '',
//     description: json['description'] ?? '',
//     price: json['price'] ?? 0,
//     images: List<String>.from(json['images'] ?? []),
//   );
// }
//
// class SellerSummary {
//   final String id;
//   final String username;
//   final SellerLocation location;
//
//   SellerSummary({
//     required this.id,
//     required this.username,
//     required this.location,
//   });
//
//   factory SellerSummary.fromJson(Map<String, dynamic> json) => SellerSummary(
//     id: json['_id'] ?? json['id'] ?? '',
//     username: json['username'] ?? '',
//     location: SellerLocation.fromJson(json['location']),
//   );
// }
//
// class SellerLocation {
//   final List<double> coordinates;
//
//   SellerLocation({required this.coordinates});
//
//   factory SellerLocation.fromJson(Map<String, dynamic> json) => SellerLocation(
//     coordinates: List<double>.from((json['coordinates'] ?? []).map((x) => (x as num).toDouble())),
//   );
// }
//
// class ShipBubbleInfo {
//   final String courierId;
//   final String courierName;
//   final int deliveryFee;
//   final String status;
//   final String serviceCode;
//   final String id;
//   final List<dynamic> items;
//
//   ShipBubbleInfo({
//     required this.courierId,
//     required this.courierName,
//     required this.deliveryFee,
//     required this.status,
//     required this.serviceCode,
//     required this.id,
//     required this.items,
//   });
//
//   factory ShipBubbleInfo.fromJson(Map<String, dynamic> json) => ShipBubbleInfo(
//     courierId: json['courierId'] ?? '',
//     courierName: json['courierName'] ?? '',
//     deliveryFee: json['deliveryFee'] ?? 0,
//     status: json['status'] ?? '',
//     serviceCode: json['serviceCode'] ?? '',
//     id: json['_id'] ?? '',
//     items: json['items'] ?? [],
//   );
// }
class OrderModel {
  final String id;
  final String userId;
  final String sellerId;
  final List<OrderItem> items;
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
  final String buyerPhone;
  final ShipBubbleInfo? shipBubbleInfo;
  final String paymentMethod;
  final String paymentReference;
  final String notes;
  final String orderNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.sellerId,
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
    required this.buyerPhone,
    this.shipBubbleInfo,
    required this.paymentMethod,
    required this.paymentReference,
    required this.notes,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['_id'] ?? '',
    userId: json['userId'] ?? '',
    sellerId: json['sellerId'] ?? '',
    items: (json['items'] as List<dynamic>? ?? [])
        .map((x) => OrderItem.fromJson(x))
        .toList(),
    subtotal: json['subtotal'] ?? 0,
    tax: json['tax'] ?? 0,
    deliveryFee: json['deliveryFee'] ?? 0,
    totalAmount: json['totalAmount'] ?? 0,
    currency: json['currency'] ?? '',
    payoutAmount: json['payoutAmount'] ?? 0,
    commission: json['commission'] ?? 0,
    payoutStatus: json['payoutStatus'] ?? '',
    status: json['status'] ?? '',
    paymentStatus: json['paymentStatus'] ?? '',
    deliveryStatus: json['deliveryStatus'] ?? '',
    deliveryAddress: json['deliveryAddress'] ?? '',
    buyerPhone: json['buyerPhone'] ?? '',
    shipBubbleInfo: json['shipBubbleInfo'] != null
        ? ShipBubbleInfo.fromJson(json['shipBubbleInfo'])
        : null,
    paymentMethod: json['paymentMethod'] ?? '',
    paymentReference: json['paymentReference'] ?? '',
    notes: json['notes'] ?? '',
    orderNumber: json['orderNumber'] ?? '',
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
  );
}

class OrderItem {
  final ProductSummary? product;
  final int quantity;
  final int price;
  final SellerSummary seller;
  final String status;
  final DateTime statusUpdatedAt;
  final String id;
  final String? statusUpdatedBy;

  OrderItem({
    this.product,
    required this.quantity,
    required this.price,
    required this.seller,
    required this.status,
    required this.statusUpdatedAt,
    required this.id,
    this.statusUpdatedBy,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    product: json['product'] != null
        ? ProductSummary.fromJson(json['product'])
        : null,
    quantity: json['quantity'] ?? 0,
    price: json['price'] ?? 0,
    seller: SellerSummary.fromJson(json['seller'] ?? {}),
    status: json['status'] ?? '',
    statusUpdatedAt:
    DateTime.tryParse(json['statusUpdatedAt'] ?? '') ?? DateTime.now(),
    id: json['_id'] ?? '',
    statusUpdatedBy: json['statusUpdatedBy'],
  );
}

class ProductSummary {
  final String id;
  final String name;
  final String? description;
  final int price;
  final List<String> images;
  final String? approvedBy;

  ProductSummary({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.images,
    this.approvedBy,
  });

  factory ProductSummary.fromJson(Map<String, dynamic> json) => ProductSummary(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'],
    price: json['price'] ?? 0,
    images: List<String>.from(json['images'] ?? []),
    approvedBy: json['approvedBy'],
  );
}

class SellerSummary {
  final String id;
  final String username;
  final SellerLocation? location;

  SellerSummary({
    required this.id,
    required this.username,
    this.location,
  });

  factory SellerSummary.fromJson(Map<String, dynamic> json) => SellerSummary(
    id: json['_id'] ?? '',
    username: json['username'] ?? '',
    location: json['location'] != null
        ? SellerLocation.fromJson(json['location'])
        : null,
  );
}

class SellerLocation {
  final List<double> coordinates;

  SellerLocation({required this.coordinates});

  factory SellerLocation.fromJson(Map<String, dynamic> json) => SellerLocation(
    coordinates: List<double>.from(
        (json['coordinates'] as List<dynamic>? ?? []).map((x) => x * 1.0)),
  );
}

class ShipBubbleInfo {
  final String id;
  final String courierId;
  final String courierName;
  final String? courierEmail;
  final String? courierPhone;
  final ShipFrom? shipFrom;
  final ShipTo? shipTo;
  final List<ShipItem> items;
  final ShipPayment? payment;
  final String buyerDeliveryAddress;
  final int deliveryFee;
  final String status;
  final String requestToken;
  final String serviceCode;
  final String? orderId;
  final String? trackingNumber;
  final String? trackingUrl;
  final String? waybillDocument;
  final DateTime? date;

  ShipBubbleInfo({
    required this.id,
    required this.courierId,
    required this.courierName,
    this.courierEmail,
    this.courierPhone,
    this.shipFrom,
    this.shipTo,
    required this.items,
    this.payment,
    required this.buyerDeliveryAddress,
    required this.deliveryFee,
    required this.status,
    required this.requestToken,
    required this.serviceCode,
    this.orderId,
    this.trackingNumber,
    this.trackingUrl,
    this.waybillDocument,
    this.date,
  });

  factory ShipBubbleInfo.fromJson(Map<String, dynamic> json) => ShipBubbleInfo(
    id: json['_id'] ?? '',
    courierId: json['courierId'] ?? '',
    courierName: json['courierName'] ?? '',
    courierEmail: json['courierEmail'],
    courierPhone: json['courierPhone'],
    shipFrom:
    json['shipFrom'] != null ? ShipFrom.fromJson(json['shipFrom']) : null,
    shipTo: json['shipTo'] != null ? ShipTo.fromJson(json['shipTo']) : null,
    items: (json['items'] as List<dynamic>? ?? [])
        .map((x) => ShipItem.fromJson(x))
        .toList(),
    payment:
    json['payment'] != null ? ShipPayment.fromJson(json['payment']) : null,
    buyerDeliveryAddress: json['buyerDeliveryAddress'] ?? '',
    deliveryFee: json['deliveryFee'] ?? 0,
    status: json['status'] ?? '',
    requestToken: json['requestToken'] ?? '',
    serviceCode: json['serviceCode'] ?? '',
    orderId: json['orderId'],
    trackingNumber: json['trackingNumber'],
    trackingUrl: json['trackingUrl'],
    waybillDocument: json['waybillDocument'],
    date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
  );
}

class ShipFrom {
  final String name;
  final String phone;
  final String email;
  final String address;
  final double latitude;
  final double longitude;

  ShipFrom({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory ShipFrom.fromJson(Map<String, dynamic> json) => ShipFrom(
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    address: json['address'] ?? '',
    latitude: (json['latitude'] ?? 0).toDouble(),
    longitude: (json['longitude'] ?? 0).toDouble(),
  );
}

class ShipTo {
  final String name;
  final String phone;
  final String email;
  final String address;
  final double latitude;
  final double longitude;

  ShipTo({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory ShipTo.fromJson(Map<String, dynamic> json) => ShipTo(
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    address: json['address'] ?? '',
    latitude: (json['latitude'] ?? 0).toDouble(),
    longitude: (json['longitude'] ?? 0).toDouble(),
  );
}

class ShipPayment {
  final int shippingFee;
  final String type;
  final String status;
  final String currency;

  ShipPayment({
    required this.shippingFee,
    required this.type,
    required this.status,
    required this.currency,
  });

  factory ShipPayment.fromJson(Map<String, dynamic> json) => ShipPayment(
    shippingFee: json['shippingFee'] ?? 0,
    type: json['type'] ?? '',
    status: json['status'] ?? '',
    currency: json['currency'] ?? '',
  );
}

class ShipItem {
  final String name;
  final String? description;
  final int weight;
  final String amount;
  final String quantity;
  final int total;
  final String id;

  ShipItem({
    required this.name,
    this.description,
    required this.weight,
    required this.amount,
    required this.quantity,
    required this.total,
    required this.id,
  });

  factory ShipItem.fromJson(Map<String, dynamic> json) => ShipItem(
    name: json['name'] ?? '',
    description: json['description'],
    weight: json['weight'] ?? 0,
    amount: json['amount'] ?? '0',
    quantity: json['quantity'] ?? '0',
    total: json['total'] ?? 0,
    id: json['_id'] ?? '',
  );
}


