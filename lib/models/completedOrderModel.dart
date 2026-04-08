class CompletedOrderModel {
  final String? id;
  final String? userId;
  final List<CompletedOrderItem> items;
  final int? subtotal;
  final int? tax;
  final int? deliveryFee;
  final int? totalAmount;
  final String? currency;
  final int? payoutAmount;
  final int? commission;
  final String? payoutStatus;
  final String? status;
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
  final int? v;
  final String? actualDeliveryDate;

  CompletedOrderModel({
    this.id,
    this.userId,
    required this.items,
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
    this.actualDeliveryDate,
  });

  factory CompletedOrderModel.fromJson(Map<String, dynamic> json) {
    return CompletedOrderModel(
      id: json["_id"],
      userId: json["userId"],
      items: (json["items"] as List<dynamic>)
          .map((x) => CompletedOrderItem.fromJson(x))
          .toList(),
      subtotal: json["subtotal"],
      tax: json["tax"],
      deliveryFee: json["deliveryFee"],
      totalAmount: json["totalAmount"],
      currency: json["currency"],
      payoutAmount: json["payoutAmount"],
      commission: json["commission"],
      payoutStatus: json["payoutStatus"],
      status: json["status"],
      paymentStatus: json["paymentStatus"],
      deliveryStatus: json["deliveryStatus"],
      deliveryAddress: json["deliveryAddress"],
      shipBubbleInfo: json["shipBubbleInfo"] != null
          ? ShipBubbleInfo.fromJson(json["shipBubbleInfo"])
          : null,
      paymentMethod: json["paymentMethod"],
      paymentReference: json["paymentReference"],
      notes: json["notes"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      orderNumber: json["orderNumber"],
      v: json["__v"],
      actualDeliveryDate: json["actualDeliveryDate"],
    );
  }
}

class CompletedOrderItem {
  final Product? product;
  final int? quantity;
  final int? price;
  final SellerSummary? seller;
  final String? status;
  final String? statusUpdatedAt;
  final String? id;
  final String? statusUpdatedBy;

  CompletedOrderItem({
    this.product,
    this.quantity,
    this.price,
    this.seller,
    this.status,
    this.statusUpdatedAt,
    this.id,
    this.statusUpdatedBy,
  });

  factory CompletedOrderItem.fromJson(Map<String, dynamic> json) {
    return CompletedOrderItem(
      product:
      json["product"] != null ? Product.fromJson(json["product"]) : null,
      quantity: json["quantity"],
      price: json["price"],
      seller:
      json["seller"] != null ? SellerSummary.fromJson(json["seller"]) : null,
      status: json["status"],
      statusUpdatedAt: json["statusUpdatedAt"],
      id: json["_id"],
      statusUpdatedBy: json["statusUpdatedBy"],
    );
  }
}

class Product {
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final List<String> images;
  final String? approvedBy;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    required this.images,
    this.approvedBy,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      images: List<String>.from(json["images"] ?? []),
      approvedBy: json["approvedBy"],
    );
  }
}

class SellerSummary {
  final SellerLocation? location;
  final String? id;
  final String? image;
  final String? username;
  final String? realId;

  SellerSummary({
    this.location,
    this.id,
    this.image,
    this.username,
    this.realId,
  });

  factory SellerSummary.fromJson(Map<String, dynamic> json) {
    return SellerSummary(
      location:
      json["location"] != null ? SellerLocation.fromJson(json["location"]) : null,
      id: json["_id"],
      image: json["image"],
      username: json["username"],
      realId: json["id"],
    );
  }
}

class SellerLocation {
  final List<double> coordinates;

  SellerLocation({required this.coordinates});

  factory SellerLocation.fromJson(Map<String, dynamic> json) {
    return SellerLocation(
      coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );
  }
}

class ShipBubbleInfo {
  final ShipAddress? shipFrom;
  final ShipAddress? shipTo;
  final PaymentInfo? payment;
  final String? courierId;
  final String? courierName;
  final String? buyerDeliveryAddress;
  final int? deliveryFee;
  final String? status;
  final String? requestToken;
  final String? serviceCode;
  final String? id;
  final List<ShipItem> items;
  final String? courierEmail;
  final String? courierPhone;
  final String? date;
  final String? orderId;
  final String? trackingNumber;
  final String? trackingUrl;
  final String? waybillDocument;

  ShipBubbleInfo({
    this.shipFrom,
    this.shipTo,
    this.payment,
    this.courierId,
    this.courierName,
    this.buyerDeliveryAddress,
    this.deliveryFee,
    this.status,
    this.requestToken,
    this.serviceCode,
    this.id,
    required this.items,
    this.courierEmail,
    this.courierPhone,
    this.date,
    this.orderId,
    this.trackingNumber,
    this.trackingUrl,
    this.waybillDocument,
  });

  factory ShipBubbleInfo.fromJson(Map<String, dynamic> json) {
    return ShipBubbleInfo(
      shipFrom:
      json["shipFrom"] != null ? ShipAddress.fromJson(json["shipFrom"]) : null,
      shipTo:
      json["shipTo"] != null ? ShipAddress.fromJson(json["shipTo"]) : null,
      payment:
      json["payment"] != null ? PaymentInfo.fromJson(json["payment"]) : null,
      courierId: json["courierId"],
      courierName: json["courierName"],
      buyerDeliveryAddress: json["buyerDeliveryAddress"],
      deliveryFee: json["deliveryFee"],
      status: json["status"],
      requestToken: json["requestToken"],
      serviceCode: json["serviceCode"],
      id: json["_id"],
      items: (json["items"] as List<dynamic>)
          .map((x) => ShipItem.fromJson(x))
          .toList(),
      courierEmail: json["courierEmail"],
      courierPhone: json["courierPhone"],
      date: json["date"],
      orderId: json["orderId"],
      trackingNumber: json["trackingNumber"],
      trackingUrl: json["trackingUrl"],
      waybillDocument: json["waybillDocument"],
    );
  }
}

class ShipAddress {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final double? latitude;
  final double? longitude;

  ShipAddress({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory ShipAddress.fromJson(Map<String, dynamic> json) {
    return ShipAddress(
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      address: json["address"],
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
    );
  }
}

class PaymentInfo {
  final int? shippingFee;
  final String? type;
  final String? status;
  final String? currency;

  PaymentInfo({
    this.shippingFee,
    this.type,
    this.status,
    this.currency,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      shippingFee: json["shippingFee"],
      type: json["type"],
      status: json["status"],
      currency: json["currency"],
    );
  }
}

class ShipItem {
  final String? name;
  final String? description;
  final int? weight;
  final String? amount;
  final String? quantity;
  final int? total;
  final String? id;

  ShipItem({
    this.name,
    this.description,
    this.weight,
    this.amount,
    this.quantity,
    this.total,
    this.id,
  });

  factory ShipItem.fromJson(Map<String, dynamic> json) {
    return ShipItem(
      name: json["name"],
      description: json["description"],
      weight: json["weight"],
      amount: json["amount"],
      quantity: json["quantity"],
      total: json["total"],
      id: json["_id"],
    );
  }
}
