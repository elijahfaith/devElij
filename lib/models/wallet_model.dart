class WalletTransactionData {
  final List<WalletTransaction>? transactions;

  WalletTransactionData({this.transactions});

  factory WalletTransactionData.fromJson(Map<String, dynamic> json) {
    return WalletTransactionData(
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => WalletTransaction.fromJson(e))
          .toList(),
    );
  }
}

class WalletTransaction {
  final String? id; // changed from int? to String?
  final String? type;
  final double? amount;
  final String? status;
  final String? reference;
  final DateTime? createdAt;
  final User? user;
  final Gateway? gateway;

  WalletTransaction({
    this.id,
    this.type,
    this.amount,
    this.status,
    this.reference,
    this.createdAt,
    this.user,
    this.gateway,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      reference: json['reference'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      user: json['user'] is Map<String, dynamic>
          ? User.fromJson(json['user'])
          : null,
      gateway: json['gateway'] is Map<String, dynamic>
          ? Gateway.fromJson(json['gateway'])
          : null,
    );
  }
}

class User {
  final String? id; // changed from int? to String?
  final String? firstname;
  final String? lastname;
  final String? email;

  User({this.id, this.firstname, this.lastname, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
    );
  }
}

class Gateway {
  final String? id; // changed from int? to String?
  final String? gateway;
  final String? logo;
  final int? status;

  Gateway({this.id, this.gateway, this.logo, this.status});

  factory Gateway.fromJson(Map<String, dynamic> json) {
    return Gateway(
      id: json['_id'] as String?,
      gateway: json['gateway'] as String?,
      logo: json['logo'] as String?,
      status: json['status'] as int?,
    );
  }
}
