class ProductReview {
  final String? id;
  final User? user;
  final String? shopId;
  final Product? product;
  final double? rating;
  final String? satisfaction;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  ProductReview({
    this.id,
    this.user,
    this.shopId,
    this.product,
    this.rating,
    this.satisfaction,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['_id'],
      user: json['userId'] != null ? User.fromJson(json['userId']) : null,
      shopId: json['shopId'],
      product: json['productId'] != null ? Product.fromJson(json['productId']) : null,
      rating: (json['rating'] as num?)?.toDouble(),
      satisfaction: json['satisfaction'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': user?.toJson(),
      'shopId': shopId,
      'productId': product?.toJson(),
      'rating': rating,
      'satisfaction': satisfaction,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class User {
  final String? id;
  final String? username;
  final String? email;
  final String? image;
  final Location? location;

  User({this.id, this.username, this.email, this.image, this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      image: json['image'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'image': image,
      'location': location?.toJson(),
    };
  }
}

class Location {
  final List<double>? coordinates;

  Location({this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: (json['coordinates'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates,
    };
  }
}

class Product {
  final String? id;
  final String? name;
  final String? approvedBy;
  final List<String>? images;

  Product({this.id, this.name, this.approvedBy, this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      approvedBy: json['approvedBy'],
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'approvedBy': approvedBy,
      'images': images,
    };
  }
}
