// class Products {
//   final String id;
//   final String name;
//   final String description;
//   final int price;
//   final Gender? gender;
//   final Category? category;
//   final SubCategory? subCategory;
//   final String size;
//   final Seller seller;
//   final Condition? condition;
//   final ColorModel? color;
//   final CreatedBy createdBy;
//   final List<String> images;
//   final int stock;
//   final bool isActive;
//   final bool isApproved;
//   final bool isHidden;
//   final ApprovedBy? approvedBy;
//   final double rating;
//   final int totalReviews;
//   final Map<String, dynamic> specifications;
//   final List<dynamic> tags;
//   final LastUpdatedBy? lastUpdatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Products({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     this.gender,
//     this.category,
//     this.subCategory,
//     required this.size,
//     required this.seller,
//     this.condition,
//     this.color,
//     required this.createdBy,
//     required this.images,
//     required this.stock,
//     required this.isActive,
//     required this.isApproved,
//     required this.isHidden,
//     this.approvedBy,
//     required this.rating,
//     required this.totalReviews,
//     required this.specifications,
//     required this.tags,
//     this.lastUpdatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Products.fromJson(Map<String, dynamic> json) {
//     return Products(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       price: json['price'] ?? 0,
//       gender: json['gender'] != null ? Gender.fromJson(json['gender']) : null,
//       category: json['category'] != null ? Category.fromJson(json['category']) : null,
//       subCategory: json['subCategory'] != null ? SubCategory.fromJson(json['subCategory']) : null,
//       size: json['size'] ?? '',
//       seller: Seller.fromJson(json['seller'] ?? {}),
//       condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
//       color: json['color'] != null ? ColorModel.fromJson(json['color']) : null,
//       createdBy: CreatedBy.fromJson(json['createdBy'] ?? {}),
//       images: List<String>.from(json['images'] ?? []),
//       stock: json['stock'] ?? 0,
//       isActive: json['isActive'] ?? false,
//       isApproved: json['isApproved'] ?? false,
//       isHidden: json['isHidden'] ?? false,
//       approvedBy: json['approvedBy'] != null ? ApprovedBy.fromJson(json['approvedBy']) : null,
//       rating: (json['rating'] ?? 0).toDouble(),
//       totalReviews: json['totalReviews'] ?? 0,
//       specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
//       tags: json['tags'] ?? [],
//       lastUpdatedBy: json['lastUpdatedBy'] != null ? LastUpdatedBy.fromJson(json['lastUpdatedBy']) : null,
//       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
//     );
//   }
// }
//
// class Gender {
//   final String id;
//   final String name;
//
//   Gender({required this.id, required this.name});
//
//   factory Gender.fromJson(Map<String, dynamic> json) => Gender(
//     id: json['_id'] ?? '',
//     name: json['name'] ?? '',
//   );
// }
//
// class Category {
//   final String id;
//   final String name;
//   final String? description;
//
//   Category({
//     required this.id,
//     required this.name,
//     this.description,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json['_id'] ?? '',
//     name: json['name'] ?? '',
//     description: json['description'],
//   );
// }
//
// class SubCategory extends Category {
//   SubCategory({
//     required super.id,
//     required super.name,
//     super.description,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//     id: json['_id'] ?? '',
//     name: json['name'] ?? '',
//     description: json['description'],
//   );
// }
//
// class Seller {
//   final String id;
//   final String firstname;
//   final String lastname;
//   final String email;
//   final String username;
//   final String phoneNumber;
//   final String role;
//   final String bio;
//   final String image;
//   final String state;
//   final String city;
//   final String address;
//   final bool isVerified;
//   final bool hasStore;
//   final Shop? shop;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Seller({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.username,
//     required this.phoneNumber,
//     required this.role,
//     required this.bio,
//     required this.image,
//     required this.state,
//     required this.city,
//     required this.address,
//     required this.isVerified,
//     required this.hasStore,
//     this.shop,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Seller.fromJson(Map<String, dynamic> json) => Seller(
//     id: json['_id'] ?? '',
//     firstname: json['firstname'] ?? '',
//     lastname: json['lastname'] ?? '',
//     email: json['email'] ?? '',
//     username: json['username'] ?? '',
//     phoneNumber: json['phoneNumber'] ?? '',
//     role: json['role'] ?? '',
//     bio: json['bio'] ?? '',
//     image: json['image'] ?? '',
//     state: json['state'] ?? '',
//     city: json['city'] ?? '',
//     address: json['address'] ?? '',
//     isVerified: json['isVerified'] ?? false,
//     hasStore: json['hasStore'] ?? false,
//     shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
//     createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//     updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
//   );
// }
//
// class Shop {
//   final String id;
//   final String userId;
//   final String city;
//   final String state;
//   final bool isBusinessVerified;
//   final List<dynamic> tags;
//   final String slug;
//
//   Shop({
//     required this.id,
//     required this.userId,
//     required this.city,
//     required this.state,
//     required this.isBusinessVerified,
//     required this.tags,
//     required this.slug,
//   });
//
//   factory Shop.fromJson(Map<String, dynamic> json) => Shop(
//     id: json['_id'] ?? '',
//     userId: json['userId'] ?? '',
//     city: json['city'] ?? '',
//     state: json['state'] ?? '',
//     isBusinessVerified: json['isBusinessVerified'] ?? false,
//     tags: json['tags'] ?? [],
//     slug: json['slug'] ?? '',
//   );
// }
//
// class Condition {
//   final String id;
//   final String name;
//   final String description;
//
//   Condition({
//     required this.id,
//     required this.name,
//     required this.description,
//   });
//
//   factory Condition.fromJson(Map<String, dynamic> json) => Condition(
//     id: json['_id'] ?? '',
//     name: json['name'] ?? '',
//     description: json['description'] ?? '',
//   );
// }
//
// class ColorModel {
//   final String id;
//   final String colorName;
//   final String colorHex;
//
//   ColorModel({
//     required this.id,
//     required this.colorName,
//     required this.colorHex,
//   });
//
//   factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
//     id: json['_id'] ?? '',
//     colorName: json['colorName'] ?? '',
//     colorHex: json['colorHex'] ?? '',
//   );
// }
//
// class CreatedBy {
//   final String id;
//   final String firstname;
//   final String lastname;
//
//   CreatedBy({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//   });
//
//   factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
//     id: json['_id'] ?? '',
//     firstname: json['firstname'] ?? '',
//     lastname: json['lastname'] ?? '',
//   );
// }
//
// class LastUpdatedBy {
//   final String? id;
//   final String firstname;
//   final String lastname;
//
//   LastUpdatedBy({
//     this.id,
//     required this.firstname,
//     required this.lastname,
//   });
//
//   factory LastUpdatedBy.fromJson(Map<String, dynamic> json) => LastUpdatedBy(
//     id: json['id'],
//     firstname: json['firstname'] ?? '',
//     lastname: json['lastname'] ?? '',
//   );
// }
//
// class ApprovedBy {
//   final String id;
//   final String? firstname;
//   final String? lastname;
//
//   ApprovedBy({
//     required this.id,
//     this.firstname,
//     this.lastname,
//   });
//
//   factory ApprovedBy.fromJson(Map<String, dynamic> json) => ApprovedBy(
//     id: json['_id'] ?? json['id'] ?? '',
//     firstname: json['firstname'],
//     lastname: json['lastname'],
//   );
// }
class Products {
  final String id;
  final String name;
  final String description;
  final int price;
  final Gender? gender;
  final Category? category;
  final SubCategory? subCategory;
  final String size;
  final Seller seller;
  final Condition? condition;
  final ColorModel? color;
  final CreatedBy? createdBy;
  final List<String> images;
  final int stock;
  final bool isActive;
  final bool isApproved;
  final bool isHidden;
  final double rating;
  final int totalReviews;
  final Map<String, dynamic> specifications;
  final List<dynamic> tags;
  final LastUpdatedBy? lastUpdatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.gender,
    this.category,
    this.subCategory,
    required this.size,
    required this.seller,
    this.condition,
    this.color,
    this.createdBy,
    required this.images,
    required this.stock,
    required this.isActive,
    required this.isApproved,
    required this.isHidden,
    required this.rating,
    required this.totalReviews,
    required this.specifications,
    required this.tags,
    this.lastUpdatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    price: json['price'] ?? 0,
    gender: json['gender'] != null ? Gender.fromJson(json['gender']) : null,
    category: json['category'] != null ? Category.fromJson(json['category']) : null,
    subCategory: json['subCategory'] != null ? SubCategory.fromJson(json['subCategory']) : null,
    size: json['size'] ?? '',
    seller: Seller.fromJson(json['seller'] ?? {}),
    condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
    color: json['color'] != null ? ColorModel.fromJson(json['color']) : null,
    createdBy: json['createdBy'] is Map<String, dynamic>
        ? CreatedBy.fromJson(json['createdBy'])
        : null,
    images: List<String>.from(json['images'] ?? []),
    stock: json['stock'] ?? 0,
    isActive: json['isActive'] ?? false,
    isApproved: json['isApproved'] ?? false,
    isHidden: json['isHidden'] ?? false,
    rating: (json['rating'] ?? 0).toDouble(),
    totalReviews: json['totalReviews'] ?? 0,
    specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
    tags: json['tags'] ?? [],
    lastUpdatedBy: json['lastUpdatedBy'] is Map<String, dynamic>
        ? LastUpdatedBy.fromJson(json['lastUpdatedBy'])
        : null,
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
  );
}

class Gender {
  final String name;

  Gender({required this.name});

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    name: json['name'] ?? '',
  );
}

class Category {
  final String id;
  final String name;
  final String? description;

  Category({
    required this.id,
    required this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'],
  );
}

class SubCategory extends Category {
  SubCategory({
    required super.id,
    required super.name,
    super.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'],
  );
}

class Seller {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String phoneNumber;
  final String role;
  final String bio;
  final String image;
  final String state;
  final String city;
  final String address;
  final bool isVerified;
  final bool hasStore;
  final String? deletedBy;
  final String? deletedReason;
  final int totalItemsSold;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLogin;
  final VerifiedAddress? verifiedAddress;
  final Location? location;
  final Shop? shop;

  Seller({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.role,
    required this.bio,
    required this.image,
    required this.state,
    required this.city,
    required this.address,
    required this.isVerified,
    required this.hasStore,
    this.deletedBy,
    this.deletedReason,
    required this.totalItemsSold,
    required this.createdAt,
    required this.updatedAt,
    this.lastLogin,
    this.verifiedAddress,
    this.location,
    this.shop,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json['_id'] ?? '',
    firstname: json['firstname'] ?? '',
    lastname: json['lastname'] ?? '',
    email: json['email'] ?? '',
    username: json['username'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    role: json['role'] ?? '',
    bio: json['bio'] ?? '',
    image: json['image'] ?? '',
    state: json['state'] ?? '',
    city: json['city'] ?? '',
    address: json['address'] ?? '',
    isVerified: json['isVerified'] ?? false,
    hasStore: json['hasStore'] ?? false,
    deletedBy: json['deletedBy'],
    deletedReason: json['deletedReason'],
    totalItemsSold: json['totalItemsSold'] ?? 0,
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    lastLogin: DateTime.tryParse(json['lastLogin'] ?? ''),
    verifiedAddress: json['verifiedAddress'] != null
        ? VerifiedAddress.fromJson(json['verifiedAddress'])
        : null,
    location: json['location'] != null ? Location.fromJson(json['location']) : null,
    shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
  );
}

class VerifiedAddress {
  final String id;
  final String address;
  final String city;
  final String state;
  final String country;
  final String name;
  final String email;
  final String phone;
  final bool isDefault;
  final double latitude;
  final double longitude;
  final String addressCode;
  final DateTime verifiedAt;

  VerifiedAddress({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.name,
    required this.email,
    required this.phone,
    required this.isDefault,
    required this.latitude,
    required this.longitude,
    required this.addressCode,
    required this.verifiedAt,
  });

  factory VerifiedAddress.fromJson(Map<String, dynamic> json) => VerifiedAddress(
    id: json['_id'] ?? json['id'] ?? '',
    address: json['address']['address'] ?? '',
    city: json['address']['city'] ?? '',
    state: json['address']['state'] ?? '',
    country: json['address']['country'] ?? '',
    name: json['address']['name'] ?? '',
    email: json['address']['email'] ?? '',
    phone: json['address']['phone'] ?? '',
    isDefault: json['address']['isDefault'] ?? false,
    latitude: double.tryParse(json['address']['latitude'].toString()) ?? 0.0,
    longitude: double.tryParse(json['address']['longitude'].toString()) ?? 0.0,
    addressCode: json['address_code'] ?? '',
    verifiedAt: DateTime.tryParse(json['verifiedAt'] ?? '') ?? DateTime.now(),
  );
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json['type'] ?? 'Point',
    coordinates: (json['coordinates'] as List)
        .map((x) => double.tryParse(x.toString()) ?? 0.0)
        .toList(),
  );
}

class Shop {
  final String id;
  final String userId;
  final String city;
  final String state;
  final bool isBusinessVerified;
  final List<dynamic> tags;
  final String slug;

  Shop({
    required this.id,
    required this.userId,
    required this.city,
    required this.state,
    required this.isBusinessVerified,
    required this.tags,
    required this.slug,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json['_id'] ?? '',
    userId: json['userId'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
    isBusinessVerified: json['isBusinessVerified'] ?? false,
    tags: json['tags'] ?? [],
    slug: json['slug'] ?? '',
  );
}

class Condition {
  final String id;
  final String name;
  final String description;

  Condition({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
  );
}

class ColorModel {
  final String id;
  final String colorName;
  final String colorHex;

  ColorModel({
    required this.id,
    required this.colorName,
    required this.colorHex,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
    id: json['_id'] ?? '',
    colorName: json['colorName'] ?? '',
    colorHex: json['colorHex'] ?? '',
  );
}

class CreatedBy {
  final String id;
  final String firstname;
  final String lastname;
  final Location? location;

  CreatedBy({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.location,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json['_id'] ?? '',
    firstname: json['firstname'] ?? '',
    lastname: json['lastname'] ?? '',
    location: json['location'] != null ? Location.fromJson(json['location']) : null,
  );
}

class LastUpdatedBy {
  final String? id;
  final String firstname;
  final String lastname;
  final Location? location;

  LastUpdatedBy({
    this.id,
    required this.firstname,
    required this.lastname,
    this.location,
  });

  factory LastUpdatedBy.fromJson(Map<String, dynamic> json) => LastUpdatedBy(
    id: json['id'],
    firstname: json['firstname'] ?? '',
    lastname: json['lastname'] ?? '',
    location: json['location'] != null ? Location.fromJson(json['location']) : null,
  );
}

