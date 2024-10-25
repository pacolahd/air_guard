import 'package:air_guard/core/common/app/providers/theme_provider.dart';
import 'package:air_guard/core/common/app/providers/user_provider.dart';
import 'package:air_guard/core/resources/theme/app_theme.dart';
import 'package:air_guard/core/services/injection_container.dart';
import 'package:air_guard/core/services/router.dart';
import 'package:air_guard/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // ensure that the widgets binding is initialized before we call the init function
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Failed to initialize Firebase: $e');
  }
  fui.FirebaseUIAuth.configureProviders([(fui.EmailAuthProvider())]);

  // initialize the dependency injection container
  await init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),

        // Add more providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Guard',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      // home: const OnBoardingScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}
