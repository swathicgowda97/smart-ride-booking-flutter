import '../../models/trip_model.dart';

class TripState {
  final List<TripModel> trips;
  final bool isLoading;

  TripState({
    required this.trips,
    this.isLoading = false,
  });

  TripState copyWith({
    List<TripModel>? trips,
    bool? isLoading,
  }) {
    return TripState(
      trips: trips ?? this.trips,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
