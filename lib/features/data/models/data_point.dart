class DataPoint {
  double value;
  DateTime dateTime;

  DataPoint({
    required this.value,
    required this.dateTime,
  });

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      dateTime: DateTime.parse(json['dateTime']),
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'value': value,
    };
  }
}
