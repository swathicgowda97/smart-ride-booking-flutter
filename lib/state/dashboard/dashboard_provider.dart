import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ride_type.dart';
import '../../models/trip_status.dart';
import '../trip/trip_provider.dart';
import 'dashboard_state.dart';

final dashboardProvider = Provider<DashboardState>((ref) {
  final trips = ref.watch(tripProvider).trips;

  final completedTrips =
  trips.where((t) => t.status == TripStatus.completed).toList();

  final totalSpent =
  completedTrips.fold<double>(0, (sum, t) => sum + t.fare);

  final recentTrips = completedTrips.reversed.take(5).toList();

  final Map<RideType, int> tripsByRideType = {
    for (var type in RideType.values) type: 0
  };

  for (final trip in completedTrips) {
    tripsByRideType[trip.rideType] =
        tripsByRideType[trip.rideType]! + 1;
  }

  return DashboardState(
    totalTrips: completedTrips.length,
    totalSpent: totalSpent,
    recentTrips: recentTrips,
    tripsByRideType: tripsByRideType,
  );
});
