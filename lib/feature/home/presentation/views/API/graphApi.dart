class HourlyData {
  final String date;
  final String humidity;
  final String particulateMatter;
  final String pressure;
  final String temperature;
  final String time;

  HourlyData({
    required this.date,
    required this.humidity,
    required this.particulateMatter,
    required this.pressure,
    required this.temperature,
    required this.time,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      date: json['date'],
      humidity: json['humidity'],
      particulateMatter: json['particulate_matter'],
      pressure: json['pressure'],
      temperature: json['temperature'],
      time: json['time'],
    );
  }
}

