import 'package:hive/hive.dart';
import 'ride_type.dart';
import 'trip_status.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String pickupLocation;

  @HiveField(2)
  final String dropLocation;

  @HiveField(3)
  final RideType rideType;

  @HiveField(4)
  double fare;

  @HiveField(5)
  TripStatus status;

  @HiveField(6)
  final DateTime dateTime;

  TripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.rideType,
    required this.fare,
    required this.status,
    required this.dateTime,
  });
}
