import 'package:air_guard/core/common/widgets/image_gradient_background.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageGradientBackground(
        image: MediaRes.onBoardingBackground,
        child: Center(child: Lottie.asset(MediaRes.pageUnderConstruction)),
      ),
    );
  }
}
