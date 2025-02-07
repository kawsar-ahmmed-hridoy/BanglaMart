import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A5934),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( // Add this
                  flex: 2,
                  child: Lottie.asset(
                    'assets/animations/splash_animation.json',
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'শিল্পসাথী',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.amber[700],
                    fontFamily: 'Kalpurush',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Text(
                    'Crafting Heritage, Empowering Artisans',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}