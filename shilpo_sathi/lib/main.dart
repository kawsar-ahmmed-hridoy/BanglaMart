import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shilpo_sathi/Account/MyProfilePage.dart';
import 'package:shilpo_sathi/Cart/CheckoutPage.dart';
import 'package:shilpo_sathi/Homepage/NotificationsPage.dart';
import 'package:shilpo_sathi/MainScreen.dart';
import 'Account/ManageAccountPage.dart';
import 'Cart/CartPage.dart';
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
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'ShilpoSathi',
      theme: _buildAppTheme(),
      darkTheme: _buildDarkAppTheme(),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
      routes: {
        '/sign_in': (context) => SignInPage(),
        '/sign_up': (context) => SignUpPage(),
        '/home': (context) => MainScreen(),
        '/notification': (context) => NotificationsPage(),
        '/my_profile': (context) => MyProfilePage(),
        '/manage_account': (context) => ManageAccountPage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
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

  ThemeData _buildDarkAppTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF2A5934),
        secondary: const Color(0xFFF5A623),
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF1E1E1E),
      ),
    );
  }
}