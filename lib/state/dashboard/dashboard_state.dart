import '../../models/trip_model.dart';
import '../../models/ride_type.dart';

class DashboardState {
  final int totalTrips;
  final double totalSpent;
  final List<TripModel> recentTrips;
  final Map<RideType, int> tripsByRideType;

  DashboardState({
    required this.totalTrips,
    required this.totalSpent,
    required this.recentTrips,
    required this.tripsByRideType,
  });
}
