import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lifted/src/app.dart';
import 'package:lifted/src/constants/test_workouts.dart';
import 'package:lifted/src/features/authentication/data/fake_auth_repository.dart';
import 'package:lifted/src/features/workouts/data/fake_workouts_repository.dart';
import 'package:lifted/src/features/workouts/presentation/home_app_bar/more_menu_button.dart';
import 'package:lifted/src/features/workouts/presentation/workouts_list/workout_card.dart';

import 'features/authentication/auth_robot.dart';

class Robot {
  Robot(this.tester) : auth = AuthRobot(tester);

  final WidgetTester tester;
  final AuthRobot auth;

  // Pumpers
  Future<void> pumpMyApp() async {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    final workoutsRepository = FakeWorkoutsRepository(addDelay: false);
    final authRepository = FakeAuthRepository(addDelay: false);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          workoutsRepositoryProvider.overrideWithValue(workoutsRepository),
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: MyApp(),
      ),
    );

    await tester.pumpAndSettle();
  }

  // Actions
  Future<void> openPopupMenu() async {
    final popupMenuButton = find.byType(MoreMenuButton);
    final matches = popupMenuButton.evaluate();
    if (matches.isNotEmpty) {
      await tester.tap(popupMenuButton);
      await tester.pumpAndSettle();
    }
  }

  // Expectations
  Future<void> expectFindAllWorkoutCards() async {
    final workoutCards = find.byType(WorkoutCard);
    expect(workoutCards, findsNWidgets(kTestWorkouts.length));
  }
}
