import 'package:flutter/material.dart';
import 'package:softvance_task/common_widgets/rounded_button.dart';
import 'package:softvance_task/constants/images.dart';
import 'package:softvance_task/helpers/location_helper.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';
  const LocationScreen({super.key});
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? _location;
  bool _loading = false;

  Future<void> _getLocation() async {
    setState(() => _loading = true);
    _location = await LocationHelper.getCurrentCoordinates();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome! Your Smart Travel Alarm',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Stay on schedule and enjoy every moment of your journey.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.location,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 18),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButton(
                      icon: Icons.location_on,
                      text: _loading ? 'Fetching...' : 'Use Current Location',
                      enabled: !_loading,
                      onPressed: _getLocation,
                    ),
                    if (_location != null) ...[
                      SizedBox(height: 14),
                      Text("Selected Location: $_location"),
                    ],
                    SizedBox(height: 16),
                    RoundedButton(
                      text: 'Home',
                      enabled: _location != null,
                      onPressed: () {
                        if (_location != null) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/home',
                            arguments: _location,
                          );
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
    );
  }
}
