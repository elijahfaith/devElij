class ReviewWithRatings {
  final Reviews? reviews;
  final Stats? stats;

  ReviewWithRatings({this.reviews, this.stats});

  factory ReviewWithRatings.fromJson(Map<String, dynamic> json) {
    return ReviewWithRatings(
      reviews: json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null,
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviews': reviews?.toJson(),
      'stats': stats?.toJson(),
    };
  }
}

class Reviews {
  final List<ReviewData>? data;
  final int? totalCount;
  final int? page;
  final int? limit;
  final int? totalPages;

  Reviews({this.data, this.totalCount, this.page, this.limit, this.totalPages});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      data: (json['data'] as List?)?.map((e) => ReviewData.fromJson(e)).toList(),
      totalCount: json['totalCount'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'totalCount': totalCount,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}

class ReviewData {
  final String? id;
  final User? userId;
  final String? shopId;
  final Product? productId;
  final double? rating;
  final String? satisfaction;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;

  ReviewData({
    this.id,
    this.userId,
    this.shopId,
    this.productId,
    this.rating,
    this.satisfaction,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['_id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      shopId: json['shopId'],
      productId: json['productId'] != null ? Product.fromJson(json['productId']) : null,
      rating: (json['rating'] as num?)?.toDouble(),
      satisfaction: json['satisfaction'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(),
      'shopId': shopId,
      'productId': productId?.toJson(),
      'rating': rating,
      'satisfaction': satisfaction,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class User {
  final String? id;
  final String? email;
  final String? image;
  final String? username;
  final UserLocation? location;

  User({this.id, this.email, this.image, this.username, this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      image: json['image'],
      username: json['username'],
      location: json['location'] != null ? UserLocation.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'image': image,
      'username': username,
      'location': location?.toJson(),
    };
  }
}

class UserLocation {
  final List<double>? coordinates;

  UserLocation({this.coordinates});

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      coordinates: (json['coordinates'] as List?)?.map((e) => (e as num).toDouble()).toList(),
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
  final List<String>? images;
  final String? approvedBy;

  Product({this.id, this.name, this.images, this.approvedBy});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      images: (json['images'] as List?)?.map((e) => e as String).toList(),
      approvedBy: json['approvedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'images': images,
      'approvedBy': approvedBy,
    };
  }
}

class Stats {
  final int? total;
  final double? average;
  final Map<String, int>? breakdown;
  final String? satisfaction;

  Stats({this.total, this.average, this.breakdown, this.satisfaction});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      total: json['total'],
      average: (json['average'] as num?)?.toDouble(),
      breakdown: (json['breakdown'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value as int),
      ),
      satisfaction: json['satisfaction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'average': average,
      'breakdown': breakdown,
      'satisfaction': satisfaction,
    };
  }
}
