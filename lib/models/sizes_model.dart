class SizesModel {
  final List<String> sizes;

  SizesModel({required this.sizes});

  factory SizesModel.fromJson(Map<String, dynamic> json) {
    return SizesModel(
      sizes: List<String>.from(json['data']),
    );
  }
}
