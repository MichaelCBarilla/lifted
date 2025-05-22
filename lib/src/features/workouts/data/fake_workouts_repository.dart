import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifted/src/constants/test_workouts.dart';
import 'package:lifted/src/features/workouts/domain/workout.dart';

class FakeWorkoutsRepository {
  final List<Workout> _workouts = kTestWorkouts;

  List<Workout> getWorkoutsList() {
    return _workouts;
  }

  Workout? getWorkout(String id) {
    return _workouts.firstWhere((workout) => workout.id == id);
  }

  Future<List<Workout>> fetchWorkoutsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_workouts);
  }

  Stream<List<Workout>> watchWorkoutsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _workouts;
  }

  Stream<Workout?> watchWorkout(String id) {
    return watchWorkoutsList()
        .map((workouts) => workouts.firstWhere((workout) => workout.id == id));
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
