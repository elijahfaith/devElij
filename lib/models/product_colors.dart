class ProductsColor {
  final String id;
  final String colorName;
  final String colorHex;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductsColor({
    required this.id,
    required this.colorName,
    required this.colorHex,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductsColor.fromJson(Map<String, dynamic> json) {
    return ProductsColor(
      id: json['_id'],
      colorName: json['colorName'],
      colorHex: json['colorHex'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'colorName': colorName,
      'colorHex': colorHex,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
