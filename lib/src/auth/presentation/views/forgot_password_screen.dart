import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:air_guard/core/common/widgets/custom_form_builder_titled_text_field.dart';
import 'package:air_guard/core/common/widgets/image_gradient_background.dart';
import 'package:air_guard/core/e'
    'xtensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:air_guard/core/resources/theme/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageGradientBackground(
        image: MediaRes.authGradientBackground,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.height * 0.18),
                    Center(
                      child: Image.asset(
                        MediaRes.schoolQuiz,
                        height: context.height * 0.1,
                      ),
                    ),
                    SizedBox(height: context.height * 0.04),
                    Text(
                      'Forgot Password',
                      style: context.theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    Text(
                      'Enter your email address and we\'ll send you a link to reset your password.',
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: context.height * 0.04),
                    FormBuilder(
                      key: _forgotPasswordFormKey,
                      child: Column(
                        children: [
                          CustomFormBuilderTitledTextField(
                            title: 'Email',
                            name: 'email',
                            suffixIcon:
                                const Icon(HugeIcons.strokeRoundedMail01),
                            validators: [
                              FormBuilderValidators.email(
                                  errorText: 'Please enter a valid email'),
                            ],
                          ),
                          SizedBox(height: context.height * 0.04),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.ui.darkBlue,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Send Reset Link'),
                            onPressed: () {
                              if (_forgotPasswordFormKey.currentState
                                      ?.saveAndValidate() ??
                                  false) {
                                // TODO: Implement password reset functionality
                                // You can access the email using:
                                // _forgotPasswordFormKey.currentState?.fields['email']?.value
                              }
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
      ),
    );
  }
}
