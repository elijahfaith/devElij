class CategoryModel {
  final String id;
  final String name;
  final List<String> genderIds;
  final List<String> parentIds; // just the parent IDs as strings
  List<CategoryModel> subcategories; // this will be populated after parsing

  CategoryModel({
    required this.id,
    required this.name,
    required this.genderIds,
    required this.parentIds,
    this.subcategories = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      genderIds: List<String>.from(json['genderIds']),
      parentIds: (json['parentIds'] as List<dynamic>)
          .map((e) => e['id'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'genderIds': genderIds,
    'parentIds': parentIds,
    'subcategories': subcategories.map((e) => e.toJson()).toList(),
  };
}
