class StateModel {
  final String id;
  final String name;
  final String statecode;
  final String? code;
  final String countryId;

  StateModel({
    required this.id,
    required this.name,
    required this.statecode,
    this.code,
    required this.countryId,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'].toString(),
      name: json['name'],
      statecode: json['statecode'],
      code: json['code'],
      countryId: json['country_id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'statecode': statecode,
      'code': code,
      'country_id': countryId,
    };
  }

  // 👇 Important to compare states properly
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StateModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
