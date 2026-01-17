import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/trip_repository.dart';
import '../../models/trip_model.dart';
import 'trip_state.dart';
import 'dart:async';
import '../../models/trip_status.dart';


class TripNotifier extends StateNotifier<TripState> {
  final TripRepository repository;

  TripNotifier(this.repository) : super(TripState(trips: [])) {
    loadTrips();
  }

  Future<void> loadTrips() async {
    state = state.copyWith(isLoading: true);
    final trips = await repository.fetchTrips();
    state = state.copyWith(trips: trips, isLoading: false);
  }

  Future<void> addTrip(TripModel trip) async {
    await repository.addTrip(trip);
    state = state.copyWith(trips: [...state.trips, trip]);

    // Start real-time ride simulation
    unawaited(startRideSimulation(trip));
  }


  Future<void> updateTrip(TripModel trip) async {
    await repository.updateTrip(trip);
    state = state.copyWith(trips: [...state.trips]);
  }

  Future<void> deleteTrip(String id) async {
    await repository.deleteTrip(id);
    state = state.copyWith(
      trips: state.trips.where((t) => t.id != id).toList(),
    );
  }

  Future<void> startRideSimulation(TripModel trip) async {
    _updateStatus(trip, TripStatus.driverAssigned);

    await Future.delayed(const Duration(seconds: 4));
    _updateStatus(trip, TripStatus.rideStarted);

    await Future.delayed(const Duration(seconds: 6));
    _updateStatus(trip, TripStatus.completed);
  }

  Future<void> _updateStatus(TripModel trip, TripStatus status) async {
    trip.status = status;
    await repository.updateTrip(trip);

    state = state.copyWith(trips: [...state.trips]);
  }

}
