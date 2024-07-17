import 'package:flutter/material.dart';

import '../API/API_Model.dart';
import '../API/API_Response.dart';

class Forcasting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forcasting Data'),
      ),
      body: FutureBuilder<ApiResponse>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final data = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Text('1 Hour:'),
                Text('Date: ${data.oneHour.date}'),
                Text('Humidity: ${data.oneHour.humidity}'),
                Text('Particulate Matter: ${data.oneHour.particulateMatter}'),
                Text('Pressure: ${data.oneHour.pressure}'),
                Text('Temperature: ${data.oneHour.temperature}'),
                Text('Time: ${data.oneHour.time}'),
                SizedBox(height: 16.0),
                Text('15 Minutes:'),
                Text('Date: ${data.fifteenMinutes.date}'),
                Text('Humidity: ${data.fifteenMinutes.humidity}'),
                Text('Particulate Matter: ${data.fifteenMinutes.particulateMatter}'),
                Text('Pressure: ${data.fifteenMinutes.pressure}'),
                Text('Temperature: ${data.fifteenMinutes.temperature}'),
                Text('Time: ${data.fifteenMinutes.time}'),
                SizedBox(height: 16.0),
                Text('30 Minutes:'),
                Text('Date: ${data.thirtyMinutes.date}'),
                Text('Humidity: ${data.thirtyMinutes.humidity}'),
                Text('Particulate Matter: ${data.thirtyMinutes.particulateMatter}'),
                Text('Pressure: ${data.thirtyMinutes.pressure}'),
                Text('Temperature: ${data.thirtyMinutes.temperature}'),
                Text('Time: ${data.thirtyMinutes.time}'),
                SizedBox(height: 16.0),
                // Text('Accuracy: ${data.accuracy}'),
              ],
            );
          }
        },
      ),
    );
  }
}
