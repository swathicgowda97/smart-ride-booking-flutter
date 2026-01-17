import '../../models/trip_model.dart';
import '../local/trip_hive_service.dart';

class TripRepository {
  final TripHiveService hiveService;

  TripRepository(this.hiveService);

  Future<List<TripModel>> fetchTrips() {
    return hiveService.getTrips();
  }

  Future<void> addTrip(TripModel trip) {
    return hiveService.addTrip(trip);
  }

  Future<void> updateTrip(TripModel trip) {
    return hiveService.updateTrip(trip);
  }

  Future<void> deleteTrip(String id) {
    return hiveService.deleteTrip(id);
  }
}
