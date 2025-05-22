import 'package:lifted/src/constants/test_workouts.dart';
import 'package:lifted/src/features/workouts/domain/workout.dart';

class FakeWorkoutRespository {
  final List<Workout> _workouts = kTestWorkouts;

  List<Workout> getWorkoutsList() {
    return _workouts;
  }

  Workout? getWorkout(String id) {
    return _workouts.firstWhere((workout) => workout.id == id);
  }

  Future<List<Workout>> fetchWorkoutsList() async {
    return Future.value(_workouts);
  }

  Stream<List<Workout>> watchWorkoutsList() {
    return Stream.value(_workouts);
  }

  Stream<Workout?> watchWorkout(String id) {
    return watchWorkoutsList()
        .map((workouts) => workouts.firstWhere((workout) => workout.id == id));
  }
}
