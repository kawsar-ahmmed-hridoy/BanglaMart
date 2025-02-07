import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingIndexProvider = StateProvider<int>((ref) => 0);

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final currentIndex = ref.watch(onboardingIndexProvider);

    final List<OnboardingPage> pages = [
      OnboardingPage(
        image: 'assets/images/ar_showroom.png',
        title: 'Experience Crafts in AR',
        description: 'Visualize Nakshi Kantha or Jamdani sarees in your space using augmented reality',
        bgColor: const Color(0xFFF5E6D3),
      ),
      OnboardingPage(
        image: 'assets/images/artisan_story.png',
        title: 'Meet the Makers',
        description: 'Discover stories of Pabna weavers and Rajshahi silk artisans through voice narratives',
        bgColor: const Color(0xFFDCEBF4),
      ),
      OnboardingPage(
        image: 'assets/images/fair_trade.png',
        title: 'Ethical Shopping',
        description: 'Directly support artisans with 90% profit going to creators via bKash/Nagad',
        bgColor: const Color(0xFFE4F2E8),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) =>
              ref.read(onboardingIndexProvider.notifier).state = index,
              itemBuilder: (context, index) => Container(
                color: pages[index].bgColor,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 400,
                          maxWidth: 400,
                        ),
                        child: Image.asset(
                          pages[index].image,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 100),
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
                            const SizedBox(height: 16),
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
              ),
            ),

            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (i) =>
                    Container(
                      width: currentIndex == i ? 24 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == i ?
                        const Color(0xFF2A5934) : Colors.grey[400],
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
                  TextButton(
                    onPressed: currentIndex > 0 ?
                        () => pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ) : null,
                    child: const Text('Back',
                        style: TextStyle(color: Color(0xFF2A5934), fontSize: 16)),
                  ),

                  currentIndex == pages.length - 1
                      ? ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A5934),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Start Exploring',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                      : TextButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Text('Next',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16
                        )),
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
  final String image;
  final String title;
  final String description;
  final Color bgColor;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.bgColor,
  });
}