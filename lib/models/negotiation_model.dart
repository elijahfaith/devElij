import 'Products.dart';

class NegotiatedProduct {
  final String id;
  final Products product;
  final User buyer;
  final User seller;
  final String status;
  final List<NegotiationMessage> messages;
  final int buyerOfferCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? expiresAt;
  final DateTime? rejectedAt;

  NegotiatedProduct({
    required this.id,
    required this.product,
    required this.buyer,
    required this.seller,
    required this.status,
    required this.messages,
    required this.buyerOfferCount,
    required this.createdAt,
    required this.updatedAt,
    this.expiresAt,
    this.rejectedAt,
  });

  factory NegotiatedProduct.fromJson(Map<String, dynamic> json) {
    return NegotiatedProduct(
      id: json['_id'] ?? '',
      product: Products.fromJson(json['productId'] ?? {}),
      buyer: User.fromJson(json['buyerId'] ?? {}),
      seller: User.fromJson(json['sellerId'] ?? {}),
      status: json['status'] ?? '',
      messages: List<NegotiationMessage>.from(
        (json['messages'] ?? []).map((x) => NegotiationMessage.fromJson(x)),
      ),
      buyerOfferCount: json['buyerOfferCount'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'])
          : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.tryParse(json['rejectedAt'])
          : null,
    );
  }
}

class User {
  final String id;
  final String firstname;
  final String lastname;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? address;
  final String? city;
  final String? state;
  final bool? isVerified;
  final bool? hasStore;
  final String? image;
  final String? status;
  final Location location;
  final VerifiedAddress? verifiedAddress;
  final ShopModel? shop;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.username,
    this.email,
    this.phoneNumber,
    this.role,
    this.address,
    this.city,
    this.state,
    this.isVerified,
    this.hasStore,
    this.image,
    this.status,
    required this.location,
    this.verifiedAddress,
    this.shop,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      isVerified: json['isVerified'],
      hasStore: json['hasStore'],
      image: json['image'],
      status: json['status'],
      location: Location.fromJson(json['location'] ?? {}),
      verifiedAddress: json['verifiedAddress'] != null
          ? VerifiedAddress.fromJson(json['verifiedAddress'])
          : null,
      shop: json['shop'] != null ? ShopModel.fromJson(json['shop']) : null,
    );
  }
}

class Location {
  final List<double> coordinates;

  Location({required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }
}

class VerifiedAddress {
  final String? addressCode;
  final DateTime? verifiedAt;
  final VerifiedAddressDetail? address;

  VerifiedAddress({
    this.addressCode,
    this.verifiedAt,
    this.address,
  });

  factory VerifiedAddress.fromJson(Map<String, dynamic> json) {
    return VerifiedAddress(
      addressCode: json['address_code'],
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'])
          : null,
      address: json['address'] != null
          ? VerifiedAddressDetail.fromJson(json['address'])
          : null,
    );
  }
}

class VerifiedAddressDetail {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final bool? isDefault;
  final double? latitude;
  final double? longitude;

  VerifiedAddressDetail({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.city,
    this.state,
    this.country,
    this.isDefault,
    this.latitude,
    this.longitude,
  });

  factory VerifiedAddressDetail.fromJson(Map<String, dynamic> json) {
    return VerifiedAddressDetail(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      isDefault: json['isDefault'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}

class ShopModel {
  final String? id;
  final String? userId;
  final String? fullname;
  final String? businessPhone;
  final String? businessAddress;
  final String? bio;
  final String? city;
  final String? state;
  final bool? isBusinessVerified;
  final List<String>? tags;
  final String? slug;
  final Location location;
  final VerifiedAddress? verifiedBusinessAddress;

  ShopModel({
    this.id,
    this.userId,
    this.fullname,
    this.businessPhone,
    this.businessAddress,
    this.bio,
    this.city,
    this.state,
    this.isBusinessVerified,
    this.tags,
    this.slug,
    required this.location,
    this.verifiedBusinessAddress,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['_id'],
      userId: json['userId'],
      fullname: json['fullname'],
      businessPhone: json['businessPhone'],
      businessAddress: json['businessAddress'],
      bio: json['bio'],
      city: json['city'],
      state: json['state'],
      isBusinessVerified: json['isBusinessVerified'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      slug: json['slug'],
      location: Location.fromJson(json['location'] ?? {}),
      verifiedBusinessAddress: json['verifiedBusinessAddress'] != null
          ? VerifiedAddress.fromJson(json['verifiedBusinessAddress'])
          : null,
    );
  }
}

class NegotiationMessage {
  final String sender;
  final String senderType;
  final String messageType;
  final int offeredPrice;
  final String comment;
  final DateTime createdAt;

  NegotiationMessage({
    required this.sender,
    required this.senderType,
    required this.messageType,
    required this.offeredPrice,
    required this.comment,
    required this.createdAt,
  });

  factory NegotiationMessage.fromJson(Map<String, dynamic> json) {
    return NegotiationMessage(
      sender: json['sender'] ?? '',
      senderType: json['senderType'] ?? '',
      messageType: json['messageType'] ?? '',
      offeredPrice: json['offeredPrice'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt:
      DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
