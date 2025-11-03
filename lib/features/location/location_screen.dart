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
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome! Your Smart Travel Alarm',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              Spacer(),
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
      ),
    );
  }
}
