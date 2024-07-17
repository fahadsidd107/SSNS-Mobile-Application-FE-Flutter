import 'dart:convert';
import 'dart:core';



import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../home/presentation/views/API/API_Response.dart';
import '../../../../home/presentation/views/API/graphApi.dart';


import 'home_view.dart';

class Home_details extends StatefulWidget {
  String time;
  String date;String humidity;String particulate; String pressure;String Temperature;
  Home_details( this.time, this.date, this.humidity, this.particulate, this.pressure,this.Temperature);


  @override
  State<Home_details> createState() => _Home_detailsState();
}

class _Home_detailsState extends State<Home_details> with SingleTickerProviderStateMixin{
  Animation<double>? _animation;
var data;
  AnimationController? _animationController;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController!,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,


        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.lightBlue,Colors.lightBlueAccent])),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 50,),
            Text("Prediction",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
            Text(widget.date,style: TextStyle(fontSize: 15,color: Colors.white ),),
            Text("${widget.time}",style: TextStyle(fontSize: 15,color: Colors.white),),
            SizedBox(height: 50,),

            Image.asset("assets/images/4.png",height: 230,),
            SizedBox(height: 100,),
            Text("${widget.Temperature}",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Humidity",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      Text(widget.humidity,style: TextStyle(fontSize: 15),),
                    ],
                  ),
                   // VerticalDivider(thickness: 3,color: Colors.white,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Matter particulate",style: TextStyle(overflow: TextOverflow.clip,color: Colors.white,fontWeight: FontWeight.bold),),

                      Text("${widget.particulate}",style: TextStyle(fontSize: 15,)),

                    ],
                  ),
                   // VerticalDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pressure",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      Text(widget.pressure,style: TextStyle(fontSize: 15)),
                    ],
                  )
                ],
              ),
            ),



          ],
        ),
      ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        //Init Floating Action Bubble
        floatingActionButton: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
               data = snapshot.data!;
              return FloatingActionBubble(
                // animation controller
                animation: _animation!,
                // On pressed change animation state
                onPressed: () => _animationController!.isCompleted
                    ? _animationController!.reverse()
                    : _animationController!.forward(),
                // Floating Action button Icon color
                iconColor: Colors.blue,

                iconData: Icons.data_saver_on_rounded,
                backgroundColor: Colors.white,
                // Menu items
                items: <Widget>[
                  // Floating action menu item
                  BubbleMenu(
                    title: '1 Hour',
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.timer,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    onPressed: () {
                      _animationController!.reverse();
                      Get.to(() => Home_details(
                          "1 Hour",
                          " ${data.oneHour.date}",
                          '${data.oneHour.humidity}',
                          ' ${data.oneHour.particulateMatter}',
                          '${data.oneHour.pressure}',
                          '${data.oneHour.temperature}'));
                    },
                  ),
                  // Floating action menu item
                  BubbleMenu(
                    title: '15 Minutes',
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.timer,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    onPressed: () {
                      _animationController!.reverse();
                      Get.to(Home_details(
                          "15 Minutes",
                          " ${data.fifteenMinutes.date}",
                          '${data.fifteenMinutes.humidity}',
                          ' ${data.fifteenMinutes.particulateMatter}',
                          '${data.fifteenMinutes.pressure}',
                          '${data.fifteenMinutes.temperature}'));
                    },
                  ),
                  //Floating action menu item
                  BubbleMenu(
                    title: '30 Minutes',
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.timer,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => HomeView()));
                      _animationController!.reverse();
                      Get.to(Home_details(
                          "30 Minutes",
                          " ${data.thirtyMinutes.date}",
                          '${data.thirtyMinutes.humidity}',
                          ' ${data.thirtyMinutes.particulateMatter}',
                          '${data.thirtyMinutes.pressure}',
                          '${data.thirtyMinutes.temperature}'));
                    },
                  ),
                  BubbleMenu(
                    title: '45 Minutes',
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.timer,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => HomeView()));
                      _animationController!.reverse();
                      Get.to(Home_details(
                          "45 Minutes",
                          " ${data.fourtyFive.date}",
                          '${data.fourtyFive.humidity}',
                          ' ${data.fourtyFive.particulateMatter}',
                          '${data.fourtyFive.pressure}',
                          '${data.fourtyFive.temperature}'));
                    },
                  ),
                ],
              );
            }
          },
        )
    );
  }
}
