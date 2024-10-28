import 'package:air_guard/core/resources/media_resources.dart';
import 'package:flutter/material.dart';

class AboutAirGuard extends StatefulWidget {
  const AboutAirGuard({super.key});
  static const routeName = '/about-air_guard';

  @override
  State<AboutAirGuard> createState() => _AboutAirGuardState();
}

class _AboutAirGuardState extends State<AboutAirGuard> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'About Air Guard',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale Air guard chaleAir guard chale ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 24),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
