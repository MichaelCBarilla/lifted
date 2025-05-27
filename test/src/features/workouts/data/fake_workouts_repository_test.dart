import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/constants/test_workouts.dart';
import 'package:lifted/src/features/workouts/data/fake_workouts_repository.dart';

void main() {
  FakeWorkoutsRepository makeWorkoutsRepository() => FakeWorkoutsRepository(
        addDelay: false,
      );
  group('FakeWorkoutsRepository', () {
    test('getWorkoutsList returns global list', () {
      final productsRepository = makeWorkoutsRepository();
      expect(
        productsRepository.getWorkoutsList(),
        kTestWorkouts,
      );
    });

    test('getWorkout(1) returns first item', () {
      final productsRepository = makeWorkoutsRepository();
      expect(
        productsRepository.getWorkout('1'),
        kTestWorkouts[0],
      );
    });

    test('getWorkout(100) returns null', () {
      final productsRepository = makeWorkoutsRepository();
      expect(
        productsRepository.getWorkout('100'),
        null,
      );
    });

    test('fetchWorkoutsList returns global list', () async {
      final productsRepository = makeWorkoutsRepository();
      expect(
        await productsRepository.fetchWorkoutsList(),
        kTestWorkouts,
      );
    });

    test('watchWorkoutsList emits global list', () {
      final productsRepository = makeWorkoutsRepository();
      expect(
        productsRepository.watchWorkoutsList(),
        emits(kTestWorkouts),
      );
    });

    test('watchWorkout(1) emits first item', () {
      final productsRepository = makeWorkoutsRepository();
      expect(
        productsRepository.watchWorkout('1'),
        emits(kTestWorkouts[0]),
      );
    });

    test('watchWorkout(100) emits null', () {
      final productsRepository = makeWorkoutsRepository();
      expect(
        productsRepository.watchWorkout('100'),
        emits(null),
      );
    });
  });
}
