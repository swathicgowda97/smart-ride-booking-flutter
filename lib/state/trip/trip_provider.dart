import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/trip_hive_service.dart';
import '../../data/repositories/trip_repository.dart';
import 'trip_notifier.dart';
import 'trip_state.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  return TripRepository(TripHiveService());
});

final tripProvider =
StateNotifierProvider<TripNotifier, TripState>((ref) {
  final repo = ref.watch(tripRepositoryProvider);
  return TripNotifier(repo);
});
