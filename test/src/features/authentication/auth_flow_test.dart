import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

import '../../robot.dart';

void main() {
  testWidgets('sign in and sign out flow', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    r.auth.expectFormType(EmailPasswordSignInFormType.signIn);
    await r.auth.signInWithEmailAndPassword();
    await r.expectFindAllWorkoutCards();
    await r.openPopupMenu();
    await r.auth.openAccountScreen();
    await r.auth.tapLogoutButton();
    await r.auth.tapDialogLogoutButton();
    r.auth.expectFormType(EmailPasswordSignInFormType.signIn);
  });
}
