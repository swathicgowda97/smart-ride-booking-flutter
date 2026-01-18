import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_ride_booking/data/local/trip_hive_service.dart';
import 'package:smart_ride_booking/data/repositories/trip_repository.dart';
import 'package:smart_ride_booking/models/trip_model.dart';
import 'package:smart_ride_booking/state/trip/trip_provider.dart';
import 'package:smart_ride_booking/ui/dashboard/dashboard_screen.dart';

/// ✅ Fake Hive service that satisfies the type system
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
  testWidgets('Dashboard screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // ✅ Override repository with fake Hive service
          tripRepositoryProvider.overrideWithValue(
            TripRepository(FakeTripHiveService()),
          ),
        ],
        child: const MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Total Trips'), findsOneWidget);
    expect(find.text('Total Spent'), findsOneWidget);
  });
}
