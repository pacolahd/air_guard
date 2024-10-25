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
    final Color primaryColor =
        const Color.fromRGBO(153, 27, 28, 1); // Primary color

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'About KCF',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      MediaRes.onboarding1, // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50, // Height of the gradient
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.9, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Revealing the reality of the Kingdom of God to the youth of our generation across the world.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'KCF (Kingdom Christian Fellowship) is dedicated to fostering a vibrant and inclusive community where individuals can grow spiritually, connect with others, and make a positive impact in the world.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Meet the Executives',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 16),

              // Circular images for executives
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(MediaRes.onboarding1),
                    backgroundColor: Colors.transparent,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(MediaRes.onboarding1),
                    backgroundColor: Colors.transparent,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(MediaRes.onboarding1),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
