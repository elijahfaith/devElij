// SellerOrderData model (maps one element of the "data" array)
class SellerOrderData {
  final String? id; // maps _id
  final UserId? userId;
  final List<OrderItem>? items;
  final double? subtotal;
  final double? tax;
  final double? deliveryFee;
  final double? totalAmount;
  final String? currency;
  final double? payoutAmount;
  final double? commission;
  final String? payoutStatus;
  final String? status; // order status
  final String? paymentStatus;
  final String? deliveryStatus;
  final String? deliveryAddress;
  final ShipBubbleInfo? shipBubbleInfo;
  final String? paymentMethod;
  final String? paymentReference;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v; // __v
  // optional refund fields
  final double? refundAmount;
  final String? refundReason;
  final String? refundedAt;
  final String? refundedBy;

  SellerOrderData({
    this.id,
    this.userId,
    this.items,
    this.subtotal,
    this.tax,
    this.deliveryFee,
    this.totalAmount,
    this.currency,
    this.payoutAmount,
    this.commission,
    this.payoutStatus,
    this.status,
    this.paymentStatus,
    this.deliveryStatus,
    this.deliveryAddress,
    this.shipBubbleInfo,
    this.paymentMethod,
    this.paymentReference,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.refundAmount,
    this.refundReason,
    this.refundedAt,
    this.refundedBy,
  });

  factory SellerOrderData.fromJson(Map<String, dynamic> json) {
    return SellerOrderData(
      id: json['_id'] as String?,
      userId:
      json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      payoutAmount: (json['payoutAmount'] as num?)?.toDouble(),
      commission: (json['commission'] as num?)?.toDouble(),
      payoutStatus: json['payoutStatus'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      deliveryStatus: json['deliveryStatus'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      shipBubbleInfo: json['shipBubbleInfo'] != null
          ? ShipBubbleInfo.fromJson(json['shipBubbleInfo'])
          : null,
      paymentMethod: json['paymentMethod'] as String?,
      paymentReference: json['paymentReference'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      orderNumber: json['orderNumber'] as String?,
      v: json['__v'] is int ? json['__v'] as int : (json['__v'] as num?)?.toInt(),
      refundAmount: (json['refundAmount'] as num?)?.toDouble(),
      refundReason: json['refundReason'] as String?,
      refundedAt: json['refundedAt'] as String?,
      refundedBy: json['refundedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(),
      'items': items?.map((e) => e.toJson()).toList(),
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
      'shipBubbleInfo': shipBubbleInfo?.toJson(),
      'paymentMethod': paymentMethod,
      'paymentReference': paymentReference,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'orderNumber': orderNumber,
      '__v': v,
      'refundAmount': refundAmount,
      'refundReason': refundReason,
      'refundedAt': refundedAt,
      'refundedBy': refundedBy,
    };
  }
}

class UserId {
  final Location? location;
  final String? id; // maps _id
  final String? email;
  final String? image;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? duplicateId; // maps 'id' (some responses include both _id and id)

  UserId({
    this.location,
    this.id,
    this.email,
    this.image,
    this.firstname,
    this.lastname,
    this.username,
    this.duplicateId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      location:
      json['location'] != null ? Location.fromJson(json['location']) : null,
      id: json['_id'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      username: json['username'] as String?,
      duplicateId: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      '_id': id,
      'email': email,
      'image': image,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'id': duplicateId,
    };
  }
}

class Location {
  final List<double>? coordinates; // [lng, lat] as in your JSON

  Location({this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    final coords = (json['coordinates'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList();
    return Location(coordinates: coords);
  }

  Map<String, dynamic> toJson() {
    return {'coordinates': coordinates};
  }
}

class OrderItem {
  final String? id; // maps _id of the item
  final Product? product;
  final int? quantity;
  final double? price;
  final String? seller; // seller id
  final String? status; // accepted/rejected etc
  final String? statusUpdatedAt;
  final String? statusUpdatedBy;
  final String? rejectionReason;

  OrderItem({
    this.id,
    this.product,
    this.quantity,
    this.price,
    this.seller,
    this.status,
    this.statusUpdatedAt,
    this.statusUpdatedBy,
    this.rejectionReason,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['_id'] as String?,
      product:
      json['product'] != null ? Product.fromJson(json['product']) : null,
      quantity: json['quantity'] is int
          ? json['quantity'] as int
          : (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      seller: json['seller'] as String?,
      status: json['status'] as String?,
      statusUpdatedAt: json['statusUpdatedAt'] as String?,
      statusUpdatedBy: json['statusUpdatedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product': product?.toJson(),
      'quantity': quantity,
      'price': price,
      'seller': seller,
      'status': status,
      'statusUpdatedAt': statusUpdatedAt,
      'statusUpdatedBy': statusUpdatedBy,
      'rejectionReason': rejectionReason,
    };
  }
}

class Product {
  final String? id; // maps _id
  final String? name;
  final double? price;
  final List<String>? images;

  Product({
    this.id,
    this.name,
    this.price,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'images': images,
    };
  }
}

class ShipBubbleInfo {
  final String? id; // maps _id
  final String? courierId;
  final String? courierName;
  final double? deliveryFee;
  final String? status;
  final String? serviceCode;
  final List<dynamic>? items; // responses show [] — keep dynamic for flexibility

  ShipBubbleInfo({
    this.id,
    this.courierId,
    this.courierName,
    this.deliveryFee,
    this.status,
    this.serviceCode,
    this.items,
  });

  factory ShipBubbleInfo.fromJson(Map<String, dynamic> json) {
    return ShipBubbleInfo(
      id: json['_id'] as String?,
      courierId: json['courierId'] as String?,
      courierName: json['courierName'] as String?,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble(),
      status: json['status'] as String?,
      serviceCode: json['serviceCode'] as String?,
      items: json['items'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'courierId': courierId,
      'courierName': courierName,
      'deliveryFee': deliveryFee,
      'status': status,
      'serviceCode': serviceCode,
      'items': items,
    };
  }
}
