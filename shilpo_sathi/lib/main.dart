import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shilpo_sathi/Homepage/NotificationsPage.dart';
import 'package:shilpo_sathi/MainScreen.dart';
import 'Signing/sign_in_page.dart';
import 'Signing/sign_up_page.dart';
import 'firebase_options.dart';
import 'onboarding/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShilpoSathi',
      theme: _buildAppTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
      routes: {
        '/sign_in': (context) => SignInPage(),
        '/sign_up': (context) => SignUpPage(),
        '/home': (context) => MainScreen(),
        '/notification': (context) => NotificationsPage(),
      },
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2A5934),
        secondary: const Color(0xFFF5A623),
      ),
      fontFamily: 'Kalpurush',
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: Color(0xFF2A5934),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}