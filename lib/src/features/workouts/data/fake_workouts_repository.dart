import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifted/src/constants/test_workouts.dart';
import 'package:lifted/src/features/workouts/domain/workout.dart';
import 'package:lifted/src/utils/delay.dart';

class FakeWorkoutsRepository {
  FakeWorkoutsRepository({this.addDelay = true});

  final bool addDelay;
  final List<Workout> _workouts = kTestWorkouts;

  List<Workout> getWorkoutsList() {
    return _workouts;
  }

  Workout? getWorkout(String id) {
    return _getWorkout(_workouts, id);
  }

  Future<List<Workout>> fetchWorkoutsList() async {
    await delay(addDelay);
    return Future.value(_workouts);
  }

  Stream<List<Workout>> watchWorkoutsList() async* {
    await delay(addDelay);
    yield _workouts;
  }

  Stream<Workout?> watchWorkout(String id) {
    return watchWorkoutsList().map((workouts) => _getWorkout(workouts, id));
  }

  static Workout? _getWorkout(List<Workout> workouts, String id) {
    try {
      return workouts.firstWhere((workout) => workout.id == id);
    } catch (e) {
      return null;
    }
  }
}

final workoutsRepositoryProvider = Provider<FakeWorkoutsRepository>((ref) {
  return FakeWorkoutsRepository();
});

final workoutsListStreamProvider =
    StreamProvider.autoDispose<List<Workout>>((ref) {
  final workoutsRepository = ref.watch(workoutsRepositoryProvider);
  return workoutsRepository.watchWorkoutsList();
});

final workoutsListFutureProvider =
    FutureProvider.autoDispose<List<Workout>>((ref) {
  final workoutsRepository = ref.watch(workoutsRepositoryProvider);
  return workoutsRepository.fetchWorkoutsList();
});

final workoutProvider =
    StreamProvider.autoDispose.family<Workout?, String>((ref, id) {
  final workoutsRepository = ref.watch(workoutsRepositoryProvider);
  return workoutsRepository.watchWorkout(id);
});
