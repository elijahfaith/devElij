class WishListModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final Gender? gender;
  final SubCategory? subCategory;
  final String size;
  final Seller seller;
  final Condition? condition;
  final String? color;
  final CreatedBy createdBy;
  final List<String> images;
  final int stock;
  final bool isActive;
  final bool isApproved;
  final bool isHidden;
  final ApprovedBy? approvedBy;
  final int rating;
  final int totalReviews;
  final Map<String, dynamic> specifications;
  final List<dynamic> tags;
  final LastUpdatedBy? lastUpdatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  WishListModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.gender,
    this.subCategory,
    required this.size,
    required this.seller,
    this.condition,
    this.color,
    required this.createdBy,
    required this.images,
    required this.stock,
    required this.isActive,
    required this.isApproved,
    required this.isHidden,
    this.approvedBy,
    required this.rating,
    required this.totalReviews,
    required this.specifications,
    required this.tags,
    this.lastUpdatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      gender: json['gender'] != null ? Gender.fromJson(json['gender']) : null,
      subCategory: json['subCategory'] != null
          ? SubCategory.fromJson(json['subCategory'])
          : null,
      size: json['size'],
      seller: Seller.fromJson(json['seller']),
      condition:
      json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      color: json['color'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      images: List<String>.from(json['images']),
      stock: json['stock'],
      isActive: json['isActive'],
      isApproved: json['isApproved'],
      isHidden: json['isHidden'],
      approvedBy: json['approvedBy'] != null
          ? ApprovedBy.fromJson(json['approvedBy'])
          : null,
      rating: json['rating'],
      totalReviews: json['totalReviews'],
      specifications: json['specifications'] ?? {},
      tags: json['tags'] ?? [],
      lastUpdatedBy: json['lastUpdatedBy'] != null
          ? LastUpdatedBy.fromJson(json['lastUpdatedBy'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Gender {
  final String name;
  final String? id;

  Gender({required this.name, this.id});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      name: json['name'],
      id: json['id'],
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String description;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class Seller {
  final String id;
  final String email;
  final String role;
  final String bio;
  final String? address;
  final String? city;
  final String? state;
  final bool isVerified;
  final String image;
  final bool hasStore;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String username;

  Seller({
    required this.id,
    required this.email,
    required this.role,
    required this.bio,
    this.address,
    this.city,
    this.state,
    required this.isVerified,
    required this.image,
    required this.hasStore,
    required this.createdAt,
    required this.updatedAt,
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
    required this.username,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
    );
  }
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

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class CreatedBy {
  final String id;
  final String firstname;
  final String lastname;

  CreatedBy({
    required this.id,
    required this.firstname,
    required this.lastname,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}

class ApprovedBy {
  final String id;

  ApprovedBy({required this.id});

  factory ApprovedBy.fromJson(Map<String, dynamic> json) {
    return ApprovedBy(
      id: json['_id'],
    );
  }
}

class LastUpdatedBy {
  final String? id;
  final String firstname;
  final String lastname;

  LastUpdatedBy({
    this.id,
    required this.firstname,
    required this.lastname,
  });

  factory LastUpdatedBy.fromJson(Map<String, dynamic> json) {
    return LastUpdatedBy(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}
