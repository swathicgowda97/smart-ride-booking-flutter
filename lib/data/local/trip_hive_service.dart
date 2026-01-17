import 'package:hive/hive.dart';
import '../../models/trip_model.dart';

class TripHiveService {
  static const String boxName = 'trips';

  Future<Box<TripModel>> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<TripModel>(boxName);
    }
    return await Hive.openBox<TripModel>(boxName);
  }

  Future<List<TripModel>> getTrips() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addTrip(TripModel trip) async {
    final box = await _openBox();
    await box.put(trip.id, trip);
  }

  Future<void> updateTrip(TripModel trip) async {
    await trip.save();
  }

  Future<void> deleteTrip(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
