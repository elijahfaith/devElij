// class SignInResponse {
//   SignInResponse({
//     String? id,
//     String? email,
//     String? name,
//     String? phoneNumber,
//     String? role,
//     bool? isVerified,
//     bool? isBusinessVerified,
//     int? rating,
//     int? totalReviews,
//     int? adminLevel,
//     List<String>? permissions,
//     String? createdAt,
//     String? updatedAt,
//     bool? hasStore,
//     String? image,
//     String? username,
//     String? bio,
//     String? address,
//     String? city,
//     String? state,
//     String? firstname,
//     String? lastname,
//     String? status,
//     String? lastLogin,
//     ShopModel? shop,
//   }) {
//     _id = id;
//     _email = email;
//     _name = name;
//     _phoneNumber = phoneNumber;
//     _role = role;
//     _isVerified = isVerified;
//     _isBusinessVerified = isBusinessVerified;
//     _rating = rating;
//     _totalReviews = totalReviews;
//     _adminLevel = adminLevel;
//     _permissions = permissions;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _hasStore = hasStore;
//     _image = image;
//     _username = username;
//     _bio = bio;
//     _address = address;
//     _city = city;
//     _state = state;
//     _firstname = firstname;
//     _lastname = lastname;
//     _status = status;
//     _lastLogin = lastLogin;
//     _shop = shop;
//   }
//
//   SignInResponse.fromJson(dynamic json) {
//     _id = json['_id'] ?? json['id'];
//     _email = json['email'];
//     _name = json['name'];
//     _phoneNumber = json['phoneNumber'];
//     _role = json['role'];
//     _isVerified = json['isVerified'];
//     _isBusinessVerified = json['isBusinessVerified'];
//     _rating = json['rating'];
//     _totalReviews = json['totalReviews'];
//     _adminLevel = json['adminLevel'];
//     _permissions = json['permissions'] != null ? List<String>.from(json['permissions']) : [];
//     _createdAt = json['createdAt'];
//     _updatedAt = json['updatedAt'];
//     _hasStore = json['hasStore'];
//     _image = json['image'];
//     _username = json['username'];
//     _bio = json['bio'];
//     _address = json['address'];
//     _city = json['city'];
//     _state = json['state'];
//     _firstname = json['firstname'];
//     _lastname = json['lastname'];
//     _status = json['status'];
//     _lastLogin = json['lastLogin'];
//     _shop = json['shop'] != null ? ShopModel.fromJson(json['shop']) : null;
//   }
//
//   String? _id;
//   String? _email;
//   String? _name;
//   String? _phoneNumber;
//   String? _role;
//   bool? _isVerified;
//   bool? _isBusinessVerified;
//   int? _rating;
//   int? _totalReviews;
//   int? _adminLevel;
//   List<String>? _permissions;
//   String? _createdAt;
//   String? _updatedAt;
//   bool? _hasStore;
//   String? _image;
//   String? _username;
//   String? _bio;
//   String? _address;
//   String? _city;
//   String? _state;
//   String? _firstname;
//   String? _lastname;
//   String? _status;
//   String? _lastLogin;
//   ShopModel? _shop;
//
//   // Getters
//   String? get id => _id;
//   String? get email => _email;
//   String? get name => _name;
//   String? get phoneNumber => _phoneNumber;
//   String? get role => _role;
//   bool? get isVerified => _isVerified;
//   bool? get isBusinessVerified => _isBusinessVerified;
//   int? get rating => _rating;
//   int? get totalReviews => _totalReviews;
//   int? get adminLevel => _adminLevel;
//   List<String>? get permissions => _permissions;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   bool? get hasStore => _hasStore;
//   String? get image => _image;
//   String? get username => _username;
//   String? get bio => _bio;
//   String? get address => _address;
//   String? get city => _city;
//   String? get state => _state;
//   String? get firstname => _firstname;
//   String? get lastname => _lastname;
//   String? get status => _status;
//   String? get lastLogin => _lastLogin;
//   ShopModel? get shop => _shop;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = _id;
//     map['email'] = _email;
//     map['name'] = _name;
//     map['phoneNumber'] = _phoneNumber;
//     map['role'] = _role;
//     map['isVerified'] = _isVerified;
//     map['isBusinessVerified'] = _isBusinessVerified;
//     map['rating'] = _rating;
//     map['totalReviews'] = _totalReviews;
//     map['adminLevel'] = _adminLevel;
//     map['permissions'] = _permissions;
//     map['createdAt'] = _createdAt;
//     map['updatedAt'] = _updatedAt;
//     map['hasStore'] = _hasStore;
//     map['image'] = _image;
//     map['username'] = _username;
//     map['bio'] = _bio;
//     map['address'] = _address;
//     map['city'] = _city;
//     map['state'] = _state;
//     map['firstname'] = _firstname;
//     map['lastname'] = _lastname;
//     map['status'] = _status;
//     map['lastLogin'] = _lastLogin;
//     map['shop'] = _shop?.toJson();
//     return map;
//   }
// }
//
// // =================== ShopModel with paymentDetails ===================
//
// class ShopModel {
//   ShopModel({
//     required this.id,
//     required this.userId,
//     required this.fullname,
//     required this.username,
//     required this.businessName,
//     required this.businessPhone,
//     required this.bvn,
//     required this.businessAddress,
//     required this.bio,
//     required this.city,
//     required this.state,
//     required this.isBusinessVerified,
//     required this.rating,
//     required this.deliveryOptions,
//     required this.isActive,
//     required this.shopState,
//     required this.coverImage,
//     required this.coordinates,
//     required this.slug,
//     required this.viewCount,
//     this.statistics,
//     this.paymentDetails,
//   });
//
//   final String id;
//   final String userId;
//   final String fullname;
//   final String username;
//   final String businessName;
//   final String businessPhone;
//   final int bvn;
//   final String businessAddress;
//   final String bio;
//   final String city;
//   final String state;
//   final bool isBusinessVerified;
//   final int rating;
//   final List<String> deliveryOptions;
//   final bool isActive;
//   final String shopState;
//   final String coverImage;
//   final List<double> coordinates;
//   final String slug;
//   final int viewCount;
//   final ShopStatistics? statistics;
//   final PaymentDetails? paymentDetails;
//
//   factory ShopModel.fromJson(Map<String, dynamic> json) {
//     return ShopModel(
//       id: json['_id'],
//       userId: json['userId'],
//       fullname: json['fullname'],
//       username: json['username'],
//       businessName: json['businessName'],
//       businessPhone: json['businessPhone'],
//       bvn: json['bvn'],
//       businessAddress: json['businessAddress'],
//       bio: json['bio'],
//       city: json['city'],
//       state: json['state'],
//       isBusinessVerified: json['isBusinessVerified'],
//       rating: json['rating'],
//       deliveryOptions: List<String>.from(json['delivery_options']),
//       isActive: json['isActive'],
//       shopState: json['shopState'],
//       coverImage: json['coverImage'],
//       coordinates: List<double>.from(json['location']['coordinates']),
//       slug: json['slug'],
//       viewCount: json['viewCount'],
//       statistics: json['statistics'] != null
//           ? ShopStatistics.fromJson(json['statistics'])
//           : null,
//       paymentDetails: json['paymentDetails'] != null
//           ? PaymentDetails.fromJson(json['paymentDetails'])
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'userId': userId,
//       'fullname': fullname,
//       'username': username,
//       'businessName': businessName,
//       'businessPhone': businessPhone,
//       'bvn': bvn,
//       'businessAddress': businessAddress,
//       'bio': bio,
//       'city': city,
//       'state': state,
//       'isBusinessVerified': isBusinessVerified,
//       'rating': rating,
//       'delivery_options': deliveryOptions,
//       'isActive': isActive,
//       'shopState': shopState,
//       'coverImage': coverImage,
//       'location': {
//         'type': 'Point',
//         'coordinates': coordinates,
//       },
//       'slug': slug,
//       'viewCount': viewCount,
//       'statistics': statistics?.toJson(),
//       'paymentDetails': paymentDetails?.toJson(),
//     };
//   }
// }
//
// // =================== ShopStatistics ===================
//
// class ShopStatistics {
//   ShopStatistics({
//     required this.productsCount,
//     required this.totalReviews,
//     required this.averageRating,
//     required this.viewCount,
//     required this.numberOfItemsSold,
//   });
//
//   final int productsCount;
//   final int totalReviews;
//   final double averageRating;
//   final int viewCount;
//   final int numberOfItemsSold;
//
//   factory ShopStatistics.fromJson(Map<String, dynamic> json) {
//     return ShopStatistics(
//       productsCount: json['productsCount'],
//       totalReviews: json['totalReviews'],
//       averageRating: (json['averageRating'] as num).toDouble(),
//       viewCount: json['viewCount'],
//       numberOfItemsSold: json['numberOfItemsSold'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'productsCount': productsCount,
//       'totalReviews': totalReviews,
//       'averageRating': averageRating,
//       'viewCount': viewCount,
//       'numberOfItemsSold': numberOfItemsSold,
//     };
//   }
// }
//
// // =================== PaymentDetails ===================
//
// class PaymentDetails {
//   PaymentDetails({
//     required this.id,
//     required this.userId,
//     required this.shopId,
//     required this.bankName,
//     required this.accountNumber,
//     required this.accountName,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final String id;
//   final String userId;
//   final String shopId;
//   final String bankName;
//   final String accountNumber;
//   final String accountName;
//   final String createdAt;
//   final String updatedAt;
//
//   factory PaymentDetails.fromJson(Map<String, dynamic> json) {
//     return PaymentDetails(
//       id: json['_id'] ?? json['id'],
//       userId: json['userId'],
//       shopId: json['shopId'],
//       bankName: json['bankName'],
//       accountNumber: json['accountNumber'],
//       accountName: json['accountName'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'userId': userId,
//       'shopId': shopId,
//       'bankName': bankName,
//       'accountNumber': accountNumber,
//       'accountName': accountName,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }
// }

class SignInResponse {
  final String? id;
  final String? email;
  final String? role;
  final String? bio;
  final String? address;
  final String? city;
  final String? state;
  final bool? isVerified;
  final String? image;
  final bool? hasStore;
  final bool? hasTransactionPin;
  final String? createdAt;
  final String? updatedAt;
  final String? firstname;
  final String? lastname;
  final String? lastLogin;
  final String? phoneNumber;
  final String? username;
  final Map<String, dynamic>? meta;
  final String? deletedReason;
  final VerifiedAddress? verifiedAddress;
  final LocationModel? location;
  final ShopModel? shop;

  SignInResponse({
    this.id,
    this.email,
    this.role,
    this.bio,
    this.address,
    this.city,
    this.state,
    this.isVerified,
    this.image,
    this.hasStore,
    this.createdAt,
    this.updatedAt,
    this.firstname,
    this.lastname,
    this.lastLogin,
    this.phoneNumber,
    this.username,
    this.hasTransactionPin,
    this.meta,
    this.deletedReason,
    this.verifiedAddress,
    this.location,
    this.shop,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
    id: json['_id'],
    email: json['email'],
    role: json['role'],
    bio: json['bio'],
    address: json['address'],
    city: json['city'],
    state: json['state'],
    isVerified: json['isVerified'],
    image: json['image'],
    hasStore: json['hasStore'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    lastLogin: json['lastLogin'],
    phoneNumber: json['phoneNumber'],
    hasTransactionPin: json['hasTransactionPin'],
    username: json['username'],
    meta: json['meta'],
    deletedReason: json['deletedReason'],
    verifiedAddress: json['verifiedAddress'] != null
        ? VerifiedAddress.fromJson(json['verifiedAddress'])
        : null,
    location: json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null,
    shop: json['shop'] != null ? ShopModel.fromJson(json['shop']) : null,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'email': email,
    'role': role,
    'bio': bio,
    'address': address,
    'city': city,
    'state': state,
    'isVerified': isVerified,
    'image': image,
    'hasStore': hasStore,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'firstname': firstname,
    'lastname': lastname,
    'lastLogin': lastLogin,
    'phoneNumber': phoneNumber,
    'username': username,
    'meta': meta,
    'deletedReason': deletedReason,
    'verifiedAddress': verifiedAddress?.toJson(),
    'location': location?.toJson(),
    'shop': shop?.toJson(),
  };
}

class VerifiedAddress {
  final VerifiedAddressDetail? address;
  final String? addressCode;
  final String? verifiedAt;
  final String? id;

  VerifiedAddress({this.address, this.addressCode, this.verifiedAt, this.id});

  factory VerifiedAddress.fromJson(Map<String, dynamic> json) =>
      VerifiedAddress(
        address: json['address'] != null
            ? VerifiedAddressDetail.fromJson(json['address'])
            : null,
        addressCode: json['address_code'],
        verifiedAt: json['verifiedAt'],
        id: json['_id'],
      );

  Map<String, dynamic> toJson() => {
    'address': address?.toJson(),
    'address_code': addressCode,
    'verifiedAt': verifiedAt,
    '_id': id,
  };
}
class VerifiedAddressDetail {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final double? latitude;
  final double? longitude;

  VerifiedAddressDetail({
    this.street,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  factory VerifiedAddressDetail.fromJson(Map<String, dynamic> json) {
    return VerifiedAddressDetail(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      latitude: double.tryParse(json['latitude'].toString()),
      longitude: double.tryParse(json['longitude'].toString()),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
class LocationModel {
  final String? type;
  final List<double>? coordinates;

  LocationModel({this.type, this.coordinates});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final rawCoordinates = json['coordinates'];
    List<double>? parsedCoordinates;

    if (rawCoordinates is List) {
      parsedCoordinates = rawCoordinates.map((x) {
        if (x is num) return x.toDouble();
        return null;
      }).whereType<double>().toList();
    }

    return LocationModel(
      type: json['type'],
      coordinates: parsedCoordinates,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
  };
}


class ShopModel {
  final String? id;
  final String? userId;
  final String? fullname;
  final String? username;
  final String? businessName;
  final String? businessPhone;
  final int? bvn;
  final String? businessAddress;
  final String? bio;
  final String? city;
  final String? state;
  final bool? isBusinessVerified;
  final int? rating;
  final List<String>? deliveryOptions;
  final bool? isActive;
  final String? shopState;
  final String? coverImage;
  final LocationModel? location;
  final List<dynamic>? reviews;
  final List<dynamic>? tags;
  final String? slug;
  final int? viewCount;
  final String? createdAt;
  final String? updatedAt;
  final ShopStatistics? statistics;
  final PaymentDetailsModel? paymentDetails;

  ShopModel({
    this.id,
    this.userId,
    this.fullname,
    this.username,
    this.businessName,
    this.businessPhone,
    this.bvn,
    this.businessAddress,
    this.bio,
    this.city,
    this.state,
    this.isBusinessVerified,
    this.rating,
    this.deliveryOptions,
    this.isActive,
    this.shopState,
    this.coverImage,
    this.location,
    this.reviews,
    this.tags,
    this.slug,
    this.viewCount,
    this.createdAt,
    this.updatedAt,
    this.statistics,
    this.paymentDetails,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
    id: json['_id'],
    userId: json['userId'],
    fullname: json['fullname'],
    username: json['username'],
    businessName: json['businessName'],
    businessPhone: json['businessPhone'],
    bvn: json['bvn'],
    businessAddress: json['businessAddress'],
    bio: json['bio'],
    city: json['city'],
    state: json['state'],
    isBusinessVerified: json['isBusinessVerified'],
    rating: json['rating'],
    deliveryOptions:
    List<String>.from(json['delivery_options'] ?? const []),
    isActive: json['isActive'],
    shopState: json['shopState'],
    coverImage: json['coverImage'],
    location: json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null,
    reviews: json['reviews'] ?? [],
    tags: json['tags'] ?? [],
    slug: json['slug'],
    viewCount: json['viewCount'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    statistics: json['statistics'] != null
        ? ShopStatistics.fromJson(json['statistics'])
        : null,
    paymentDetails: json['paymentDetails'] != null
        ? PaymentDetailsModel.fromJson(json['paymentDetails'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'fullname': fullname,
    'username': username,
    'businessName': businessName,
    'businessPhone': businessPhone,
    'bvn': bvn,
    'businessAddress': businessAddress,
    'bio': bio,
    'city': city,
    'state': state,
    'isBusinessVerified': isBusinessVerified,
    'rating': rating,
    'delivery_options': deliveryOptions,
    'isActive': isActive,
    'shopState': shopState,
    'coverImage': coverImage,
    'location': location?.toJson(),
    'reviews': reviews,
    'tags': tags,
    'slug': slug,
    'viewCount': viewCount,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'statistics': statistics?.toJson(),
    'paymentDetails': paymentDetails?.toJson(),
  };
}

class ShopStatistics {
  final int? productsCount;
  final int? totalReviews;
  final double? averageRating;
  final int? viewCount;
  final int? numberOfItemsSold;

  ShopStatistics({
    this.productsCount,
    this.totalReviews,
    this.averageRating,
    this.viewCount,
    this.numberOfItemsSold,
  });

  factory ShopStatistics.fromJson(Map<String, dynamic> json) =>
      ShopStatistics(
        productsCount: json['productsCount'],
        totalReviews: json['totalReviews'],
        averageRating: json['averageRating']?.toDouble(),
        viewCount: json['viewCount'],
        numberOfItemsSold: json['numberOfItemsSold'],
      );

  Map<String, dynamic> toJson() => {
    'productsCount': productsCount,
    'totalReviews': totalReviews,
    'averageRating': averageRating,
    'viewCount': viewCount,
    'numberOfItemsSold': numberOfItemsSold,
  };
}

class PaymentDetailsModel {
  final String? id;
  final String? userId;
  final String? shopId;
  final String? bankName;
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? createdAt;
  final String? updatedAt;

  PaymentDetailsModel({
    this.id,
    this.userId,
    this.shopId,
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.createdAt,
    this.updatedAt,
    this.bankCode,
  });

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsModel(
        id: json['id'] ?? json['_id'],
        userId: json['userId'],
        shopId: json['shopId'],
        bankName: json['bankName'],
        accountNumber: json['accountNumber'],
        accountName: json['accountName'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        bankCode: json['bankCode']
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'shopId': shopId,
    'bankName': bankName,
    'accountNumber': accountNumber,
    'accountName': accountName,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
