import 'dart:async';

import 'package:air_guard/core/common/views/loading_view.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:fl_chart/fl_chart.dart'; // Add this dependency for the graph
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget circleAvatarWithUserPicture(
          {required String url, required double radius}) =>
      Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 8),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
            backgroundColor: Colors.grey[400],
          ),
        ),
      );
  bool APMConnected = false;

  // Future<void> _connectToAPI() async {
  //   const String apiUrl = 'http://192.168.87.167/data';
  //       // 'https://datausa.io/api/data?drilldowns=Nation&measures=Population';
  //       // 'http://192.168.87.167/your_endpoint'; // Replace 'your_endpoint' with the actual endpoint
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       // Parse the JSON data
  //       final jsonData = json.decode(response.body);
  //       // Do something with the jsonData
  //       print(jsonData); // Example: print the data
  //     } else {
  //       // Handle the error
  //       print('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle any exceptions
  //     print('Error: $e');
  //   }
  // }

  // Define variables to hold the data from the API
  bool isLoading = false;
  Map<String, dynamic>? sensorData;
  Timer? _pollingTimer;

  // // Fetch data from API and update the state
  // Future<void> _connectToAPI() async {
  //   const String apiUrl = 'http://192.168.87.167/data';
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         sensorData = json.decode(response.body) as Map<String, dynamic>?;
  //       });
  //     } else {
  //       print('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<void> _connectToAPI() async {
    setState(() {
      print('loading started');
      isLoading = true; // Show loading indicator
    });

    const String apiUrl = 'http://192.168.87.167/data';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          sensorData = json.decode(response.body) as Map<String, dynamic>?;
          // Check PM2.5 value and show alert if necessary

          if (sensorData != null && sensorData!['PM2.5_standard'] as double > 20) {
            _showAlertDialog();
          }
        });
        print(json.decode(response.body) as Map<String, dynamic>?);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
        print('loading stopped');// Hide loading indicator
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Air Quality Alert'),
          content: Text('PM2.5 level has exceeded the safe limit!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _startPolling() {
    const duration = Duration(seconds:30); // Poll every 5 seconds
    _pollingTimer = Timer.periodic(duration, (timer) {
      _connectToAPI(); // Fetch new data at each interval
    });
  }

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hi, Welcome',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold, height: 1),
                    ),
                    Text(
                      '${context.userProvider.user!.fullName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // circle avatar with user picture
                circleAvatarWithUserPicture(
                    url: '${context.userProvider.user!.profilePic}',
                    radius: 18),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                APMConnected
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            // height: context.height * 0.46,
                            width: double.infinity,
                            color: Colors.blue,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Daily AQI',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Week',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  color: Colors.white,
                                  height: 1,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                      ...List.generate(
                                        6,
                                        (index) {
                                          return DateAQICard(
                                            day: [
                                              'MON',
                                              'TUE',
                                              'WED',
                                              'THU',
                                              'FRI',
                                              'SAT'
                                            ][index],
                                            aqi: [
                                              33,
                                              43,
                                              32,
                                              29,
                                              31,
                                              19
                                            ][index], // AQI values as example
                                            isSelected: index ==
                                                2, // Example: Wednesday selected
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                AirQualityUI(),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            // height: context.height * 0.4,
                            width: double.infinity,
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Emergency Contacts',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        'See all',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        children: [
                                          circleAvatarWithUserPicture(
                                              url:
                                                  'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                                              radius: 30),
                                          Text(
                                            'Judette Adjetey',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(
                                                  20,
                                                  10,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              '       Call       ',
                                              style: TextStyle(height: .06),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        children: [
                                          circleAvatarWithUserPicture(
                                              url:
                                                  'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                                              radius: 30),
                                          Text(
                                            'Judette Adjetey',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(
                                                  20,
                                                  10,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              '       Call       ',
                                              style: TextStyle(height: .06),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 13),
                                      child: Column(
                                        children: [
                                          circleAvatarWithUserPicture(
                                              url:
                                                  'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                                              radius: 30),
                                          Text(
                                            'Judette Adjetey',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(
                                                  20,
                                                  10,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              '       Call       ',
                                              style: TextStyle(height: .06),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        children: [
                                          circleAvatarWithUserPicture(
                                              url:
                                                  'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                                              radius: 30),
                                          Text(
                                            'Judette Adjetey',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(
                                                  20,
                                                  10,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              '       Call       ',
                                              style: TextStyle(height: .06),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        children: [
                                          circleAvatarWithUserPicture(
                                              url:
                                                  'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                                              radius: 30),
                                          Text(
                                            'Judette Adjetey',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(
                                                  20,
                                                  10,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              '       Call       ',
                                              style: TextStyle(height: .06),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 13),
                                      child: Column(
                                        children: [
                                          circleAvatarWithUserPicture(
                                              url:
                                                  'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
                                              radius: 30),
                                          Text(
                                            'Judette Adjetey',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(
                                                  20,
                                                  10,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              '       Call       ',
                                              style: TextStyle(height: .06),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                    : SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ShadTheme(
                          data: ShadThemeData(
                              colorScheme: ShadZincColorScheme.light(),
                              brightness: Brightness.light),
                          child: ShadTheme(
                            data: ShadThemeData(
                              colorScheme: ShadZincColorScheme.light(),
                              brightness: Brightness.light,
                            ),
                            child: ShadButton(
                              onPressed: _connectToAPI, // Call the API when pressed
                              child: Text(
                                'Get device data\n manually',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                softWrap: true,
                              ),
                              backgroundColor: Colors.blue,
                              height: 100,
                              width: 200,
                              pressedBackgroundColor: Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Spacing

                      // Loading Indicator
                      isLoading
                          ? CircularProgressIndicator() // Show loading indicator
                          : SizedBox.shrink(),

                      // Display the sensor data if available
                      sensorData != null
                          ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "PM1.0 (Standard): ${sensorData!['PM1.0_standard']}"),
                            Text(
                                "PM2.5 (Standard): ${sensorData!['PM2.5_standard']}"),
                            Text(
                                "PM10 (Standard): ${sensorData!['PM10_standard']}"),
                            Text(
                                "PM1.0 (Environmental): ${sensorData!['PM1.0_env']}"),
                            Text(
                                "PM2.5 (Environmental): ${sensorData!['PM2.5_env']}"),
                            Text(
                                "PM10 (Environmental): ${sensorData!['PM10_env']}"),
                            Text(
                                "Particles > 0.3µm: ${sensorData!['Particles_0.3um']}"),
                            Text(
                                "Particles > 0.5µm: ${sensorData!['Particles_0.5um']}"),
                            Text(
                                "Particles > 1.0µm: ${sensorData!['Particles_1.0um']}"),
                            Text(
                                "Particles > 2.5µm: ${sensorData!['Particles_2.5um']}"),
                            Text(
                                "Particles > 5.0µm: ${sensorData!['Particles_5.0um']}"),
                            Text(
                                "Particles > 10µm: ${sensorData!['Particles_10um']}"),
                            Text(
                                "Ambient Temp (°C): ${sensorData!['AmbientTemp_C']}"),
                            Text(
                                "Object Temp (°C): ${sensorData!['ObjectTemp_C']}"),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "No data available. Please connect to APM.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  // child: Column(
                        //   children: [
                        //     Center(
                        //       child: ShadTheme(
                        //         data: ShadThemeData(
                        //             colorScheme: ShadZincColorScheme.light(),
                        //             brightness: Brightness.light),
                        //         child: ShadTheme(
                        //           data: ShadThemeData(
                        //             colorScheme: ShadZincColorScheme.light(),
                        //             brightness: Brightness.light,
                        //           ),
                        //           child: ShadButton(
                        //             onPressed:
                        //                 _connectToAPI, // Call the API when pressed
                        //             child: Text(
                        //               '+ Connect APM',
                        //               style: TextStyle(
                        //                 fontSize: 20,
                        //               ),
                        //               softWrap: true,
                        //             ),
                        //             backgroundColor: Colors.blue,
                        //             height: 200,
                        //             width: 200,
                        //             pressedBackgroundColor: Colors.blue[900],
                        //           ),
                        //         ),
                        //       ),
                        //     ), // Display the sensor data if available
                        //     sensorData != null
                        //         ? Column(
                        //             children: [
                        //               Text(
                        //                   "PM1.0 (Standard): ${sensorData!['PM1.0_standard']}"),
                        //               Text(
                        //                   "PM2.5 (Standard): ${sensorData!['PM2.5_standard']}"),
                        //               Text(
                        //                   "PM10 (Standard): ${sensorData!['PM10_standard']}"),
                        //               Text(
                        //                   "PM1.0 (Environmental): ${sensorData!['PM1.0_env']}"),
                        //               Text(
                        //                   "PM2.5 (Environmental): ${sensorData!['PM2.5_env']}"),
                        //               Text(
                        //                   "PM10 (Environmental): ${sensorData!['PM10_env']}"),
                        //               Text(
                        //                   "Particles > 0.3µm: ${sensorData!['Particles_0.3um']}"),
                        //               Text(
                        //                   "Particles > 0.5µm: ${sensorData!['Particles_0.5um']}"),
                        //               Text(
                        //                   "Particles > 1.0µm: ${sensorData!['Particles_1.0um']}"),
                        //               Text(
                        //                   "Particles > 2.5µm: ${sensorData!['Particles_2.5um']}"),
                        //               Text(
                        //                   "Particles > 5.0µm: ${sensorData!['Particles_5.0um']}"),
                        //               Text(
                        //                   "Particles > 10µm: ${sensorData!['Particles_10um']}"),
                        //               Text(
                        //                   "Ambient Temp (°C): ${sensorData!['AmbientTemp_C']}"),
                        //               Text(
                        //                   "Object Temp (°C): ${sensorData!['ObjectTemp_C']}"),
                        //             ],
                        //           )
                        //         : Text(
                        //             "No data available. Please connect to APM."),
                        //   ],
                        // ),
                      ),
              ],
            ),
          ),
        ));
  }
}

class AirQualityUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Adjust background if necessary

          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Air Quality Index',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Last Updated: 12:00 PM',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 150,
              child: LineChart(LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 70),
                      FlSpot(1, 80),
                      FlSpot(2, 90),
                      FlSpot(3, 75),
                      FlSpot(4, 50),
                      FlSpot(5, 85),
                      FlSpot(6, 65),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    belowBarData: BarAreaData(
                        show: true, color: Colors.blue.withOpacity(0.3)),
                  ),
                ],
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1, // Interval between titles
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text('Sun',
                                style: TextStyle(color: Colors.grey));
                          case 1:
                            return Text('Mon',
                                style: TextStyle(color: Colors.grey));
                          case 2:
                            return Text('Tue',
                                style: TextStyle(color: Colors.grey));
                          case 3:
                            return Text('Wed',
                                style: TextStyle(color: Colors.grey));
                          case 4:
                            return Text('Thu',
                                style: TextStyle(color: Colors.grey));
                          case 5:
                            return Text('Fri',
                                style: TextStyle(color: Colors.grey));
                          case 6:
                            return Text('Sat',
                                style: TextStyle(color: Colors.grey));
                          default:
                            return Text('');
                        }
                      },
                      reservedSize: 20,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 25,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey,
                        strokeWidth: 0.5,
                      );
                    }),
                borderData: FlBorderData(show: false),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class DateAQICard extends StatelessWidget {
  final String day;
  final int aqi;
  final bool isSelected;

  DateAQICard({required this.day, required this.aqi, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.white,
          width: 1,
        ),
      ),
      width: 40,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$aqi',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: aqi > 40
                  ? Colors.orange
                  : isSelected
                      ? Colors.blue
                      : Colors.white,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blue : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
