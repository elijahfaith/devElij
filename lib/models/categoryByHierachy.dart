// class CategoryGender {
//   final String id;
//   final String name;
//   final List<Category> categories;
//
//   CategoryGender({
//     required this.id,
//     required this.name,
//     required this.categories,
//   });
//
//   factory CategoryGender.fromJson(Map<String, dynamic> json) {
//     return CategoryGender(
//       id: json["_id"],
//       name: json["name"],
//       categories: (json["categories"] as List)
//           .map((e) => Category.fromJson(e))
//           .toList(),
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is CategoryGender && runtimeType == other.runtimeType && id == other.id;
//
//   @override
//   int get hashCode => id.hashCode;
//
//   @override
//   String toString() => 'CategoryGender(id: $id, name: $name)';
// }
//
// class Category {
//   final String id;
//   final String name;
//   final String description;
//   final String icon;
//   final List<SubCategory> subcategories;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.icon,
//     required this.subcategories,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json["_id"],
//       name: json["name"],
//       description: json["description"] ?? '',
//       icon: json["icon"] ?? '',
//       subcategories: (json["subcategories"] as List)
//           .map((e) => SubCategory.fromJson(e))
//           .toList(),
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is Category && runtimeType == other.runtimeType && id == other.id;
//
//   @override
//   int get hashCode => id.hashCode;
//
//   @override
//   String toString() => 'Category(id: $id, name: $name)';
// }
//
// class SubCategory {
//   final String id;
//   final String name;
//   final String description;
//
//   SubCategory({
//     required this.id,
//     required this.name,
//     required this.description,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json["_id"],
//       name: json["name"],
//       description: json["description"] ?? '',
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is SubCategory && runtimeType == other.runtimeType && id == other.id;
//
//   @override
//   int get hashCode => id.hashCode;
//
//   @override
//   String toString() => 'SubCategory(id: $id, name: $name)';
// }

class CategoryGender {
  final String id;
  final String name;
  final List<Category> categories;

  CategoryGender({
    required this.id,
    required this.name,
    required this.categories,
  });

  factory CategoryGender.fromJson(Map<String, dynamic> json) {
    return CategoryGender(
      id: json["_id"],
      name: json["name"],
      categories: (json["categories"] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryGender &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CategoryGender(id: $id, name: $name)';
}

class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final List<SubCategory> subcategories;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      name: json["name"],
      description: json["description"] ?? '',
      icon: json["icon"] ?? '',
      subcategories: (json["subcategories"] as List)
          .map((e) => SubCategory.fromJson(e))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Category(id: $id, name: $name)';
}

class SubCategory {
  final String id;
  final String name;
  final String description;
  final List<Attribute> attributes;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.attributes,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json["_id"],
      name: json["name"],
      description: json["description"] ?? '',
      attributes: (json["attributes"] as List)
          .map((e) => Attribute.fromJson(e))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubCategory &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'SubCategory(id: $id, name: $name)';
}

class Attribute {
  final String id;
  final String name;
  final List<String> values;

  Attribute({
    required this.id,
    required this.name,
    required this.values,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json["_id"],
      name: json["name"],
      values: List<String>.from(json["values"]),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Attribute &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Attribute(id: $id, name: $name)';
}
