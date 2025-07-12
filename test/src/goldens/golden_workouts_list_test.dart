import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/app.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

import '../robot.dart';

void main() {
  final sizeVariant = ValueVariant<Size>({
    const Size(300, 600),
    const Size(600, 800),
    const Size(1000, 1000),
  });
  testWidgets(
    'Golden - workouts list',
    (tester) async {
      final r = Robot(tester);
      final currentSize = sizeVariant.currentValue!;
      await r.golden.setSurfaceSize(currentSize);
      await r.golden.loadRobotoFont();
      await r.golden.loadMaterialIconFont();
      await r.pumpMyApp();
      r.auth.expectFormType(EmailPasswordSignInFormType.signIn);
      await r.auth.signInWithEmailAndPassword();
      await r.golden.precacheImages();
      await expectLater(
          find.byType(MyApp),
          matchesGoldenFile(
              'workouts_list_${currentSize.width.toInt()}x${currentSize.height.toInt()}.png'));
      await r.expectFindAllWorkoutCards();
    },
    variant: sizeVariant,
    tags: ['golden'],
    skip: true, // Skip until able to run on CI
  );
}
