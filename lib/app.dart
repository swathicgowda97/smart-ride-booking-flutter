import 'package:flutter/material.dart';
import 'package:smart_ride_booking/ui/dashboard/dashboard_screen.dart';

class SmartRideApp extends StatelessWidget {
  const SmartRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ride Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const DashboardScreen(),
    );
  }
}
