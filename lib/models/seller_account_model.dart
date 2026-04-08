class SellerModel {
  final String id;
  final String userId;
  final String fullname;
  final String username;
  final String businessName;
  final String businessPhone;
  final String bvn;
  final String businessAddress;
  final String bio;
  final String city;
  final String state;
  final bool isBusinessVerified;
  final int rating;
  final List<String> deliveryOptions;
  final bool isActive;
  final String shopState;
  final String coverImage;
  final List<String> images;
  final double latitude;
  final double longitude;
  final String bankName;
  final String accountNumber;
  final String accountName;

  SellerModel({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.username,
    required this.businessName,
    required this.businessPhone,
    required this.bvn,
    required this.businessAddress,
    required this.bio,
    required this.city,
    required this.state,
    required this.isBusinessVerified,
    required this.rating,
    required this.deliveryOptions,
    required this.isActive,
    required this.shopState,
    required this.coverImage,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    final payment = json['paymentDetails'];

    return SellerModel(
      id: json['_id'],
      userId: json['userId'],
      fullname: json['fullname'],
      username: json['username'],
      businessName: json['businessName'],
      businessPhone: json['businessPhone'],
      bvn: json['bvn'].toString(),
      businessAddress: json['businessAddress'],
      bio: json['bio'],
      city: json['city'],
      state: json['state'],
      isBusinessVerified: json['isBusinessVerified'],
      rating: json['rating'],
      deliveryOptions: List<String>.from(json['delivery_options']),
      isActive: json['isActive'],
      shopState: json['shopState'],
      coverImage: json['coverImage'],
      images: List<String>.from(json['images']),
      latitude: location['coordinates'][1],
      longitude: location['coordinates'][0],
      bankName: payment['bankName'],
      accountNumber: payment['accountNumber'],
      accountName: payment['accountName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId,
      "fullname": fullname,
      "username": username,
      "businessName": businessName,
      "businessPhone": businessPhone,
      "bvn": bvn,
      "businessAddress": businessAddress,
      "bio": bio,
      "city": city,
      "state": state,
      "isBusinessVerified": isBusinessVerified,
      "rating": rating,
      "delivery_options": deliveryOptions,
      "isActive": isActive,
      "shopState": shopState,
      "coverImage": coverImage,
      "images": images,
      "location": {
        "type": "Point",
        "coordinates": [longitude, latitude],
      },
      "paymentDetails": {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName,
      },
    };
  }
}
