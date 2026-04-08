class CheckoutData {
  final List<ShippingOption> shippingOptions;
  final CartSummary cartSummary;

  CheckoutData({
    required this.shippingOptions,
    required this.cartSummary,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(
      shippingOptions: (json['shippingOptions'] as List)
          .map((e) => ShippingOption.fromJson(e))
          .toList(),
      cartSummary: CartSummary.fromJson(json['cartSummary']),
    );
  }
}

class ShippingOption {
  final Seller seller;
  final List<Product> products;
  final String requestToken;
  final List<Courier> couriers;

  ShippingOption({
    required this.seller,
    required this.products,
    required this.requestToken,
    required this.couriers,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) {
    return ShippingOption(
      seller: Seller.fromJson(json['seller']),
      products: (json['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
      requestToken: json['requestToken'],
      couriers: (json['couriers'] as List)
          .map((e) => Courier.fromJson(e))
          .toList(),
    );
  }
}

class Seller {
  final String id;
  final String username;

  Seller({
    required this.id,
    required this.username,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      username: json['username'],
    );
  }
}

class Product {
  final String productId;
  final String name;
  final int price;
  final int quantity;
  final int subtotal;

  Product({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
    );
  }
}

class Courier {
  final String serviceCode;
  final String courierId;
  final String courierName;
  final String pickupEta;
  final String pickupEtaTime;
  final String? dropoffStation;
  final String? pickupStation;
  final String deliveryEta;
  final String deliveryEtaTime;
  final int deliveryFee;
  final int total;
  final int vat;

  Courier({
    required this.serviceCode,
    required this.courierId,
    required this.courierName,
    required this.pickupEta,
    required this.pickupEtaTime,
    this.dropoffStation,
    this.pickupStation,
    required this.deliveryEta,
    required this.deliveryEtaTime,
    required this.deliveryFee,
    required this.total,
    required this.vat,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      serviceCode: json['service_code'],
      courierId: json['courier_id'],
      courierName: json['courier_name'],
      pickupEta: json['pickup_eta'],
      pickupEtaTime: json['pickup_eta_time'],
      dropoffStation: json['dropoff_station'],
      pickupStation: json['pickup_station'],
      deliveryEta: json['delivery_eta'],
      deliveryEtaTime: json['delivery_eta_time'],
      deliveryFee: json['delivery_fee'],
      total: json['total'],
      vat: json['vat'],
    );
  }
}

class CartSummary {
  final int subtotal;
  final int tax;
  final int totalDeliveryFee;
  final int grandTotal;
  final int itemCount;
  final String cumulativeDeliveryDate;
  final List<Product> items;

  CartSummary({
    required this.subtotal,
    required this.tax,
    required this.totalDeliveryFee,
    required this.grandTotal,
    required this.itemCount,
    required this.cumulativeDeliveryDate,
    required this.items,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      subtotal: json['subtotal'],
      tax: json['tax'],
      totalDeliveryFee: json['totalDeliveryFee'],
      grandTotal: json['grandTotal'],
      itemCount: json['itemCount'],
      cumulativeDeliveryDate: json['cumulativeDeliveryDate'],
      items: (json['items'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
    );
  }
}
