import 'package:flutter/material.dart';
import 'package:softvance_task/constants/colors.dart';
import 'package:softvance_task/features/location/location_screen.dart';
import 'package:softvance_task/features/onboarding/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Backbencher Task',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.bgDark,
        colorScheme: ColorScheme.dark().copyWith(primary: AppColors.purple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.purple),
        ),
      ),
      initialRoute: OnboardingScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LocationScreen.routeName: (_) => LocationScreen(),
      },
    );
  }
}
