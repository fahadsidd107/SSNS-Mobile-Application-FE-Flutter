class DataPoint {
  final String date;
  final String humidity;
  final String particulateMatter;
  final String pressure;
  final String temperature;
  final String time;

  DataPoint({
    required this.date,
    required this.humidity,
    required this.particulateMatter,
    required this.pressure,
    required this.temperature,
    required this.time,
  });

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      date: json['date'],
      humidity: json['humidity'],
      particulateMatter: json['particulate_matter'],
      pressure: json['pressure'],
      temperature: json['temperature'],
      time: json['time'],
    );
  }
}

class ApiResponse {
  final DataPoint oneHour;
  final DataPoint fifteenMinutes;
  final DataPoint thirtyMinutes;
  final DataPoint fourtyFive;
  // final String accuracy;

  ApiResponse({
    required this.oneHour,
    required this.fifteenMinutes,
    required this.thirtyMinutes,
    required this.fourtyFive,
    // required this.accuracy,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      oneHour: DataPoint.fromJson(json['1 hour']),
      fifteenMinutes: DataPoint.fromJson(json['15 min']),
      thirtyMinutes: DataPoint.fromJson(json['30 min']),
      fourtyFive: DataPoint.fromJson(json['45 min'])
      // accuracy: json['accuracy'],
    );
  }
}
