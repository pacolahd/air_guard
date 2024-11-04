import 'dart:async';
import 'package:air_guard/core/common/views/loading_view.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/theme/app_theme.dart';
import 'package:air_guard/src/emergency_contacts/presentation/view/emergency_contacts_screen.dart';
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
  // Future<void> _connectToAPI() async {
  //   setState(() {
  //     print('loading started');
  //     isLoading = true; // Show loading indicator
  //   });
  //
  //   const String apiUrl = 'http://192.168.87.167/data';
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         sensorData = json.decode(response.body) as Map<String, dynamic>?;
  //         // Check PM2.5 value and show alert if necessary
  //
  //         if (sensorData != null && sensorData!['PM2.5_standard'] as double > 20) {
  //           _showAlertDialog();
  //         }
  //       });
  //       print(json.decode(response.body) as Map<String, dynamic>?);
  //     } else {
  //       print('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //       print('loading stopped');// Hide loading indicator
  //     });
  //   }
  // }
  Timer? _pollingTimer;
  bool isLoading = false;
  Map<String, dynamic>? sensorData;
  bool showUnsafeAirAlert = false;
  static const double pm25Limit = 20.0;

  @override
  void initState() {
    super.initState();
    _startPolling(); // Start periodic polling on init
  }

  @override
  void dispose() {
    _pollingTimer?.cancel(); // Cancel the polling timer when widget is disposed
    super.dispose();
  }

  void _startPolling() {
    const duration = Duration(seconds: 30); // Poll every 30 seconds
    _pollingTimer = Timer.periodic(duration, (timer) {
      _fetchSensorData(); // Fetch new data at each interval
    });
  }

  Future<void> _fetchSensorData() async {
    setState(() {
      isLoading = true;
    });

    const String apiUrl = 'http://192.168.203.167/data';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          sensorData = json.decode(response.body) as Map<String, dynamic>?;
          // Check PM2.5 value and show alert if necessary
          // if (sensorData != null &&
          //     sensorData!['PM2.5_standard'] as double > pm25Limit) {
          //   if (showUnsafeAirAlert == false) {
          //   showUnsafeAirAlert = true;
          //   _showPersistentUnsafeAirDialog();
          //   }
          // } else {
          //   showUnsafeAirAlert = false;
          //   Navigator.of(context).pop(); // Close the dialog when air is safe
          // }
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPersistentUnsafeAirDialog() {
    if (showUnsafeAirAlert) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissal
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Unsafe Air Quality"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("PM2.5 levels are high. Please move to a safer location."),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text("Indicate Asthma Attack"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showEmergencyContactDialog();
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  showUnsafeAirAlert = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showEmergencyContactDialog() {
    if (EmergencyContactsScreen.emergencyContacts.isEmpty) {
      // Show dialog if no emergency contacts are available
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No Emergency Contacts"),
            content: Text("You have no emergency contacts added. Please add them in the settings to use this feature."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();

                },
              ),
            ],
          );
        },
      );
    } else {
      // Proceed with notifying emergency contacts
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Notify Emergency Contacts"),
            content: Text("Would you like to notify your emergency contacts?"),
            actions: [
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  showUnsafeAirAlert = false;
                  Navigator.of(context).pop();
                  EmergencyContactsScreen.sendEmergencySMSWithLocation(
                      EmergencyContactsScreen.emergencyContacts[0].phoneNumbers?.first ?? ''
                  );
                  // TODO: Implement additional emergency contact notifications if needed
                },
              ),
              TextButton(
                child: Text("No"),
                onPressed: () {
                  showUnsafeAirAlert = false;
                  Navigator.of(context).pop();
                  _showPersistentUnsafeAirDialog(); // Show the alert again if air is still unsafe
                },
              ),
            ],
          );
        },
      );
    }
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
                  url: '${context.userProvider.user!.profilePic}', radius: 18),
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: _fetchSensorData,
                  child: Text(
                    'Get device data\n manually',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
              sensorData != null
                  ? _buildSensorData()
                  : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "No data available. Please connect to APM.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ),
            ),),
    );
  }

  // Widget _buildSensorData() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: sensorData!.entries.map((entry) {
  //         return Text("${entry.key}: ${entry.value}");
  //       }).toList(),
  //     ),
  //   );
  // }

Widget _buildSensorData(){
  return(
  Padding(
    padding: const EdgeInsets.all(16.0),
    child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(height: 100),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey[300]!),
          ),
          width: 180,
          height: 150,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${sensorData !=null? sensorData!['PM2.5_standard']: 'null'}",
                  style: TextStyle(fontSize: 40),
                ),Text(
                  " µg/m³",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Text('Safe', style: context.theme.textTheme.titleLarge),
        SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {_showEmergencyContactDialog();},
          child: Text('Emergency'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(150, 50),
          ),
        ),
      ],
    ),
  )
  );
}
}
