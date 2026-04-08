class Rates {
  final double vatPercentage;
  final double commissionPercentage;

  Rates({
    required this.vatPercentage,
    required this.commissionPercentage,
  });

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      vatPercentage: (json['vatPercentage'] as num).toDouble(),
      commissionPercentage: (json['commissionPercentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vatPercentage': vatPercentage,
      'commissionPercentage': commissionPercentage,
    };
  }
}
