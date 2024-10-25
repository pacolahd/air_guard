import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:air_guard/core/common/app/providers/user_provider.dart';
import 'package:air_guard/core/common/widgets/custom_form_builder_titled_text_field.dart';
import 'package:air_guard/core/common/widgets/image_gradient_background.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/core/resources/media_resources.dart';
import 'package:air_guard/core/resources/theme/app_colors.dart';
import 'package:air_guard/core/utils/core_utils.dart';
import 'package:air_guard/src/auth/data/models/user_model.dart';
import 'package:air_guard/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:air_guard/src/auth/presentation/views/forgot_password_screen.dart';
import 'package:air_guard/src/dashboard/presentation/views/dashboard.dart';

class EmailLogInScreen extends StatefulWidget {
  const EmailLogInScreen({super.key});

  static const routeName = '/email-login';

  @override
  _EmailLogInScreenState createState() => _EmailLogInScreenState();
}

class _EmailLogInScreenState extends State<EmailLogInScreen> {
  bool _obscurePassword = true;
  final _loginFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            CoreUtils.showLoadingDialog(context);
          } else {
            // Dismiss the loading dialog if it's showing
            Navigator.of(context).popUntil((route) => route is! DialogRoute);

            if (state is AuthError) {
              CoreUtils.showMessageDialog(
                context,
                title: 'Error',
                message: state.message,
                type: MessageType.error,
              );
            } else if (state is SignedIn) {
              context.read<UserProvider>().initUser(state.user as UserModel);
              Navigator.pushReplacementNamed(context, Dashboard.routeName);
            }
          }
        },
        builder: (context, state) {
          return ImageGradientBackground(
            image: MediaRes.onBoardingBackground,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: context.height * 0.15),
                        Center(
                          child: Image.asset(
                            MediaRes.logo, // Replace with your app logo
                            height: context.height * 0.1,
                          ),
                        ),
                        SizedBox(height: context.height * 0.04),
                        Text(
                          'Log in with email',
                          style:
                              context.theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.height * 0.03),
                        SizedBox(height: context.height * 0.01),
                        FormBuilder(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              CustomFormBuilderTitledTextField(
                                title: 'Email',
                                name: 'email',
                                validators: [
                                  FormBuilderValidators.email(),
                                ],
                                // contentPadding: EdgeInsets.symmetric(
                                //   horizontal: 20,
                                //   vertical: 20,
                                // ),
                                suffixIcon: const Icon(
                                  HugeIcons.strokeRoundedMail01,
                                ),
                              ),
                              SizedBox(height: context.height * 0.02),
                              SizedBox(height: context.height * 0.01),
                              CustomFormBuilderTitledTextField(
                                obscureText: _obscurePassword,
                                title: 'Password',
                                name: 'password',
                                // contentPadding: const EdgeInsets.symmetric(
                                //   horizontal: 20,
                                //   vertical: 20,
                                // ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: context.height * 0.02),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Forgot password? ',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context,
                                              ForgotPasswordScreen.routeName);
                                        },
                                    ),
                                  )),
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
                                child: const Text('Log in'),
                                onPressed: () {
                                  if (_loginFormKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    final data =
                                        _loginFormKey.currentState?.value;
                                    if (data != null) {
                                      context.read<AuthBloc>().add(
                                            SignInEvent(
                                              email: data['email'] as String,
                                              password:
                                                  data['password'] as String,
                                            ),
                                          );
                                    }
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
          );
        },
      ),
    );
  }
}
