import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/trip/trip_provider.dart';
import '../../models/trip_status.dart';

class TripsScreen extends ConsumerWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tripProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Trips')),
      body: state.trips.isEmpty
          ? const Center(child: Text('No trips yet'))
          : ListView.builder(
        itemCount: state.trips.length,
        itemBuilder: (context, index) {
          final trip = state.trips[index];

          return Dismissible(
            key: ValueKey(trip.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              ref
                  .read(tripProvider.notifier)
                  .deleteTrip(trip.id);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Trip deleted')),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(
                  '${trip.pickupLocation} → ${trip.dropLocation}',
                ),
                subtitle: Text(
                  'Status: ${_statusText(trip.status)}',
                ),
                trailing: Text(
                  '₹${trip.fare.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _statusText(TripStatus status) {
    switch (status) {
      case TripStatus.requested:
        return 'Requested';
      case TripStatus.driverAssigned:
        return 'Driver Assigned';
      case TripStatus.rideStarted:
        return 'Ride Started';
      case TripStatus.completed:
        return 'Completed';
      case TripStatus.cancelled:
        return 'Cancelled';
    }
  }
}
