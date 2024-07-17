import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'API_Model.dart';
import 'graphApi.dart';

Future<ApiResponse> fetchData() async {
  final response = await http.get(Uri.parse('https://machinelearning-3d1y.onrender.com/predmin'));

  if (response.statusCode == 200) {
    print("The api has been successfully hit");
    print(response.body);
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}


Future<List<HourlyData>> graphData() async {
  final response = await http.get(Uri.parse('https://machinelearning-3d1y.onrender.com/predictions'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data.entries.map((entry) => HourlyData.fromJson(entry.value)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}