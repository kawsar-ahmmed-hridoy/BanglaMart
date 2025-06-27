import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shilpo_sathi/MainScreen.dart';
import 'package:shilpo_sathi/Signing/sign_in_page.dart';

final onboardingIndexProvider = StateProvider<int>((ref) => 0);

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(onboardingIndexProvider);

    final List<OnboardingPage> pages = [
      OnboardingPage(
        lottieAsset: 'assets/animations/ar.json',
        title: 'বাংলার শিল্প ঐতিহ্যের অভিজ্ঞতা',
        description:
        'নকশীকাঁথা, জামদানি এবং আরও অনেক ঐতিহ্যবাহী পণ্যের চিত্রায়ন করুন, কিনুন এবং বিক্রি করুন।',
        bgColor: const Color(0xFFE4F2E8),
      ),
      OnboardingPage(
        lottieAsset: 'assets/animations/makers.json',
        title: 'শিল্পীদের সাথে পরিচিত হোন',
        description:
        'বাংলার ঐতিহ্যবাহী হস্তশিল্প ও শিল্পীদের গল্প শুনুন এবং তাদের সম্পর্কে জানুন। ',
        bgColor: const Color(0xFFE4F2E8),
      ),
      OnboardingPage(
        lottieAsset: 'assets/animations/payment.json',
        title: 'নিরাপদ পেমেন্ট সুবিধা',
        description:
        'শিল্পীদের সরাসরি সমর্থন করুন, যেখানে ৯০% লাভ শিল্পীদের কাছে পৌঁছাবে বিকাশ/নগদের মাধ্যমে।',
        bgColor: const Color(0xFFE4F2E8),
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFE4F2E8),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) =>
              ref.read(onboardingIndexProvider.notifier).state = index,
              itemBuilder: (context, index) {
                return Container(
                  color: pages[index].bgColor,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 150,
                            maxWidth: 250,
                          ),
                          child: Lottie.asset(
                            pages[index].lottieAsset,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pages[index].title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A5934),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  pages[index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentIndex == index ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? const Color(0xFF2A5934)
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex > 0)
                    TextButton(
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Color(0xFF2A5934), fontSize: 16),
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                  if (currentIndex == pages.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.authStateChanges().listen((User? user) {
                          if (user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainScreen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignInPage()),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A5934).withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Start Exploring',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String lottieAsset;
  final String title;
  final String description;
  final Color bgColor;

  const OnboardingPage({
    required this.lottieAsset,
    required this.title,
    required this.description,
    required this.bgColor,
  });
}