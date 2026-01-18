import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_ride_booking/models/ride_type.dart';
import 'package:smart_ride_booking/models/trip_model.dart';
import 'package:smart_ride_booking/models/trip_status.dart';
import 'package:smart_ride_booking/state/trip/trip_provider.dart';
import 'package:smart_ride_booking/data/repositories/trip_repository.dart';
import 'package:smart_ride_booking/data/local/trip_hive_service.dart';

/// Fake Hive service (no disk, no init)
class FakeTripHiveService extends TripHiveService {
  final List<TripModel> _trips = [];

  @override
  Future<List<TripModel>> getTrips() async => _trips;

  @override
  Future<void> addTrip(TripModel trip) async {
    _trips.add(trip);
  }

  @override
  Future<void> updateTrip(TripModel trip) async {}

  @override
  Future<void> deleteTrip(String id) async {
    _trips.removeWhere((t) => t.id == id);
  }
}

void main() {
  test('Trip is added successfully via TripNotifier', () async {
    final container = ProviderContainer(
      overrides: [
        tripRepositoryProvider.overrideWithValue(
          TripRepository(FakeTripHiveService()),
        ),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(tripProvider.notifier);

    // ✅ IMPORTANT: wait for initial async load
    await Future.delayed(const Duration(milliseconds: 10));

    final trip = TripModel(
      id: '1',
      pickupLocation: 'A',
      dropLocation: 'B',
      rideType: RideType.mini,
      fare: 100,
      status: TripStatus.requested,
      dateTime: DateTime.now(),
    );

    final state = container.read(tripProvider);

    expect(
      state.trips.where((t) => t.id == '1').length,
      1,
    );
  });
}
