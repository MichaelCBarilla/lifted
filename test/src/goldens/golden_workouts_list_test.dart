import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/app.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

import '../robot.dart';

void main() {
  testWidgets('Golden - workouts list', (tester) async {
    final r = Robot(tester);
    await r.golden.loadRobotoFont();
    await r.golden.loadMaterialIconFont();
    await r.pumpMyApp();
    r.auth.expectFormType(EmailPasswordSignInFormType.signIn);
    await r.auth.signInWithEmailAndPassword();
    await r.golden.precacheImages();
    await expectLater(
        find.byType(MyApp), matchesGoldenFile('workouts_list.png'));
    await r.expectFindAllWorkoutCards();
  });
}
