import 'package:flutter/material.dart';
import 'package:softvance_task/common_widgets/rounded_button.dart';
import 'package:softvance_task/constants/images.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppImages.onboarding1,
      "title": "Discover the world, one journey at a time",
      "desc":
          "From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure now.",
    },
    {
      "image": AppImages.onboarding2,
      "title": "Explore new horizons, one step at a time.",
      "desc":
          "Stay in sync & enjoy the story waiting to be lived. Let us help you travel with recommendations that inspire, connect, and guide.",
    },
    {
      "image": AppImages.onboarding3,
      "title": "See the beauty, one journey at a time.",
      "desc":
          "Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.",
    },
  ];

  void next() {
    if (page < onboardingData.length - 1) {
      setState(() => page++);
    } else {
      Navigator.pushReplacementNamed(context, '/location');
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = onboardingData[page];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button on top:
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: Text("Skip", style: TextStyle(color: Colors.white)),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/location'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      current['image']!,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    current['title']!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    current['desc']!,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (i) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == page
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white24,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 36),
                  RoundedButton(
                    text: page < onboardingData.length - 1
                        ? 'Next'
                        : 'Get Started',
                    onPressed: next,
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
