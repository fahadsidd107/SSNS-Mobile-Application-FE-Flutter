import 'dart:convert';

import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/app_strings.dart';
import 'package:weather/core/utils/app_styles.dart';
import 'package:weather/feature/home/presentation/views/API/API_Model.dart';
import 'package:weather/feature/home/presentation/views/widgets/home_view_body.dart';
import 'package:weather/feature/home/presentation/views/widgets/location_button.dart';

import '../../../../../core/animations/scale_transition_animation.dart';
import '../../../../../core/animations/slide_transition_animation.dart';
import '../../../../../core/functions/change_gradient_color.dart';
import '../../../../../core/functions/change_gradient_color_with_opacity.dart';
import '../../../../../core/functions/change_weather_icon.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/gradient_container_widget.dart';
import 'home_Details.dart';
import '../../../../home/presentation/views/API/API_Response.dart';
import '../../../../home/presentation/views/API/graphApi.dart';
import '../../../../home/presentation/views/widgets/Forcasting.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState  extends State<HomeView> {
  late Future<List<HourlyData>> futureData;
  List<HourlyData> hourlyData = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = graphData();
    futureData.then((futureData){
      setState(() {
        hourlyData = futureData;
      });
    });
    Get.snackbar("Select", "Please Select prediction");
  }
Future<List<HourlyData>> fetchData() async {
  final response = await http.get(Uri.parse('https://machinelearning-3d1y.onrender.com/predictions'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data.entries.map((entry) => HourlyData.fromJson(entry.value)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
  @override
  Widget build(BuildContext context) {
    List datatime = ["1 Hour", "15 Minutes", "30 Mints", "45 Mints"];

    List images = [
      "assets/images/4.png",
      "assets/images/8.png",
      "assets/images/16.png",
      "assets/images/16.png"
    ];


    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            AppStrings.weather,
            style: AppStyles.textStyle25
                .copyWith(color: AppColors.black, fontSize: 20),
          ),
          // actions: [
          //   InkWell(
          //       onTap: () {
          //         Get.to(() => Forcasting());
          //       },
          //       child: Text("forecast")),
          //   LocationButton(),
          // ],
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.transparent,
          ),
        ),
        body: ListView(children: [
         InkWell(onTap: (){
           Get.to(() => Home_details(
               "15 Minutes",
               "2024-07-15",
               '1.41',
               '2385.76 hPa',
               '29.96',
               '45'));
         },
             child: Container(height: 60,width: double.infinity,child: Center(child: Text("Predictions",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.blue),margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),)),
          SfCartesianChart(
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: 'Time'),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Temperature (°C)'),
          ),
          title: ChartTitle(text: 'Temperature over time'),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries>[
            LineSeries<HourlyData, String>(
              dataSource: hourlyData,
              xValueMapper: (HourlyData data, _) => data.time.split(":")[0] + ":00",
              yValueMapper: (HourlyData data, _) => double.parse(data.temperature.split(" ")[0]),
              name: 'Temperature',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),

          ],
        ),




          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: 'Time'),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'humidity'),
            ),
            title: ChartTitle(text: 'humidity over time'),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[

              LineSeries<HourlyData, String>(
                dataSource: hourlyData,
                xValueMapper: (HourlyData data, _) => data.time.split(":")[0] + ":00",
                yValueMapper: (HourlyData data, _) => double.parse(data.humidity.split(" ")[0]),
                name: 'Humidity (%)',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),

            ],
          ),






          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: 'Time'),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'particulate Matter'),
            ),
            title: ChartTitle(text: 'Matter Particulate over time'),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[

              LineSeries<HourlyData, String>(
                dataSource: hourlyData,
                xValueMapper: (HourlyData data, _) => data.time.split(":")[0] + ":00",
                yValueMapper: (HourlyData data, _) => double.parse(data.particulateMatter.split(" ")[0]),
                name: 'Particulate Matter (µg/m³)',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),

            ],
          ),





          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: 'Time'),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'pressure'),
            ),
            title: ChartTitle(text: 'Pressure over time'),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[

              LineSeries<HourlyData, String>(
                dataSource: hourlyData,
                xValueMapper: (HourlyData data, _) => data.time.split(":")[0] + ":00",
                yValueMapper: (HourlyData data, _) => double.parse(data.pressure.split(" ")[0]),
                name: 'Pressure (hPa)',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ],)




        // FutureBuilder<ApiResponse>(
        //   future: fetchData(),
        //   builder: (context,snapshot){
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else if (!snapshot.hasData) {
        //       return Center(child: Text('No data found'));
        //     }else{
        //        data = snapshot.data!;
        //
        //
        //       return Expanded(
        //         child: ListView.builder(
        //             itemCount: 4,
        //             itemBuilder: (context,i){
        //               return ScaleTransitionAnimation(
        //
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: InkWell(
        //                       onTap: (){
        //                         if(i==0){
        //
        //                          Get.to(()=>Home_details("1"," ${data.oneHour.date}",'${data.oneHour.humidity}',' ${data.oneHour.particulateMatter}','${data.oneHour.pressure}','${data.oneHour.temperature}'));
        //
        //                         }if(i==1){
        //                           Get.to(Home_details("15"," ${data.fifteenMinutes.date}",'${data.fifteenMinutes.humidity}',' ${data.fifteenMinutes.particulateMatter}','${data.fifteenMinutes.pressure}','${data.fifteenMinutes.temperature}'));
        //                         }if(i==2){
        //                           Get.to(Home_details("30"," ${data.thirtyMinutes.date}",'${data.thirtyMinutes.humidity}',' ${data.thirtyMinutes.particulateMatter}','${data.thirtyMinutes.pressure}','${data.thirtyMinutes.temperature}'));
        //                         }if(i==3){
        //                           Get.to(Home_details("45"," ${data.fourtyFive.date}",'${data.fourtyFive.humidity}',' ${data.fourtyFive.particulateMatter}','${data.fourtyFive.pressure}','${data.fourtyFive.temperature}'));
        //                         }
        //                       },
        //                       child: Container(
        //
        //                         padding: EdgeInsets.symmetric(horizontal: 20),
        //
        //                         child: Row(
        //                           children: [
        //                             Column(
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //
        //                               children: [
        //                                 Row(
        //                                   children: [
        //                                     Text(datatime[i].toString(),style: TextStyle(fontSize: 18),),
        //
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                             Spacer(),
        //                              Image.asset(images[i].toString()),
        //                           ],
        //                         ),
        //                         height: 100,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.amberAccent),
        //
        //                       ),
        //                     ),
        //                   ), duration: const Duration(microseconds: 1500));
        //
        //
        //             }),
        //       );
        //     }
        //
        //   },
        //
        // ),

///////////////////////////////


        // const HomeViewBody(),
        );
  }
}
