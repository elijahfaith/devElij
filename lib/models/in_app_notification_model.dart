class NotificationData {
  final List<NotificationItem>? notifications;
  final Pagination? pagination;
  final int? unreadCount;

  NotificationData({
    this.notifications,
    this.pagination,
    this.unreadCount,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      unreadCount: json['unreadCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
      'unreadCount': unreadCount,
    };
  }
}

class NotificationItem {
  final String? id;
  final String? userId;
  final String? type;
  final String? title;
  final String? message;
  final NotificationExtraData? data;
  final bool? isRead;
  final String? relatedId;
  final String? relatedModel;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? readAt;

  NotificationItem({
    this.id,
    this.userId,
    this.type,
    this.title,
    this.message,
    this.data,
    this.isRead,
    this.relatedId,
    this.relatedModel,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.readAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'],
      userId: json['userId'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      data: json['data'] != null
          ? NotificationExtraData.fromJson(json['data'])
          : null,
      isRead: json['isRead'],
      relatedId: json['relatedId'],
      relatedModel: json['relatedModel'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      readAt: json['readAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'message': message,
      'data': data?.toJson(),
      'isRead': isRead,
      'relatedId': relatedId,
      'relatedModel': relatedModel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'readAt': readAt,
    };
  }
}

class NotificationExtraData {
  final String? productId;
  final String? buyerName;
  final String? sellerId;
  final String? sellerName;
  final int? totalAmount;
  final int? itemCount;
  final String? actionType;
  final String? orderNumber;

  NotificationExtraData({
    this.productId,
    this.buyerName,
    this.sellerId,
    this.sellerName,
    this.totalAmount,
    this.itemCount,
    this.actionType,
    this.orderNumber,
  });

  factory NotificationExtraData.fromJson(Map<String, dynamic> json) {
    return NotificationExtraData(
      productId: json['productId'],
      buyerName: json['buyerName'],
      sellerId: json['sellerId'],
      sellerName: json['sellerName'],
      totalAmount: json['totalAmount'],
      itemCount: json['itemCount'],
      actionType: json['actionType'],
      orderNumber: json['orderNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'buyerName': buyerName,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'totalAmount': totalAmount,
      'itemCount': itemCount,
      'actionType': actionType,
      'orderNumber': orderNumber,
    };
  }
}

class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? pages;

  Pagination({
    this.page,
    this.limit,
    this.total,
    this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      pages: json['pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'pages': pages,
    };
  }
}
