import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:air_guard/core/common/widgets/image_gradient_background.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:air_guard/core/resources/theme/app_colors.dart';
import 'package:air_guard/src/auth/presentation/views/email_login_screen.dart';
import 'package:air_guard/src/auth/presentation/views/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ImageGradientBackground(
      image: MediaRes.onBoardingBackground,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: context.height * 0.105),
                  Image.asset(
                    MediaRes
                        .casualMeditationScience, // Replace with your actual image asset
                    height: context.height * 0.31,
                  ),
                  SizedBox(height: context.height * 0.02),
                  Text(
                    'Log in',
                    style: context.theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * 0.0215),
                  ElevatedButton.icon(
                    icon: const Icon(HugeIcons.strokeRoundedMail01,
                        color: Colors.white),
                    label: const Text('Log in with email'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.ui.darkBlue, // Dark blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, EmailLogInScreen.routeName);
                    },
                  ),
                  SizedBox(height: context.height * 0.02),
                  Text(
                    'OR',
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * 0.02),
                  OutlinedButton.icon(
                    icon: Image.asset(MediaRes.googleIcon),
                    label: const Text('Continue with Google'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.ui.darkBlue, // Dark blue
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement Google sign in
                    },
                  ),
                  SizedBox(height: context.height * 0.05),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    ));
  }
}
