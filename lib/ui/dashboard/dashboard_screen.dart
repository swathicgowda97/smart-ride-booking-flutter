import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/trip_status.dart';
import '../../models/ride_type.dart';
import '../../state/dashboard/dashboard_provider.dart';
import '../../state/trip/trip_provider.dart';
import '../trips/add_trip_screen.dart';
import '../trips/trips_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  void _showStatusSnack(TripStatus status) {
    final text = switch (status) {
      TripStatus.driverAssigned => 'Driver assigned',
      TripStatus.rideStarted => 'Ride started',
      TripStatus.completed => 'Ride completed',
      _ => null,
    };

    if (text != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Riverpod listen MUST be inside build
    ref.listen(tripProvider, (previous, next) {
      if (previous == null) return;

      for (final newTrip in next.trips) {
        final oldTrip = previous.trips
            .firstWhere((t) => t.id == newTrip.id, orElse: () => newTrip);

        if (newTrip.status != oldTrip.status) {
          _showStatusSnack(newTrip.status);
        }
      }
    });

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
                  MaterialPageRoute(
                    builder: (_) => const TripsScreen(),
                  ),
                );
              },
              child: const Text('View All Trips'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Trips by Ride Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
