import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/dashboard/dashboard_provider.dart';
import '../../models/ride_type.dart';
import '../trips/add_trip_screen.dart';
import '../trips/trips_screen.dart';



class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTripScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summaryCard(
              title: 'Total Trips',
              value: dashboard.totalTrips.toString(),
            ),
            const SizedBox(height: 12),
            _summaryCard(
              title: 'Total Spent',
              value: '₹${dashboard.totalSpent.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TripsScreen()),
                );
              },
              child: const Text('View All Trips'),
            ),

            const SizedBox(height: 24),
            const Text(
              'Trips by Ride Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...RideType.values.map(
                  (type) => ListTile(
                title: Text(type.name.toUpperCase()),
                trailing: Text(
                  dashboard.tripsByRideType[type].toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
