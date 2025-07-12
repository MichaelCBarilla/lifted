import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  final testEmail = 'test@test.com';
  final testPassword = 'testpassword';
  late MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('sign in', () {
    testWidgets('''
      Given the formtype is signIn,
      When tapping the sign in button,
      then signInWithEmailAndPassword is not called
    ''', (tester) async {
      final r = AuthRobot(tester);
      await r.pumpEmailAndPasswordSignInContents(
          formType: EmailPasswordSignInFormType.signIn,
          authRepository: authRepository);
      await r.tapEmailAndPasswordSubmitButton();
      verifyNever(
          () => authRepository.signInWithEmailAndPassword(any(), any()));
    });

    testWidgets('''
      Given the formtype is signIn,
      when entering valid email and password,
      and tapping the sign in button,
      then signInWithEmailAndPassword is called
      And onSignedIn is called
      And the errorAlert is not shown
    ''', (tester) async {
      var onSignedInCalled = false;
      final r = AuthRobot(tester);
      await r.pumpEmailAndPasswordSignInContents(
        formType: EmailPasswordSignInFormType.signIn,
        authRepository: authRepository,
        onSignedIn: () => onSignedInCalled = true,
      );
      when(() => authRepository.signInWithEmailAndPassword(
          testEmail, testPassword)).thenAnswer((_) => Future.value());
      await r.enterEmail(testEmail);
      await r.enterPassword(testPassword);
      await r.tapEmailAndPasswordSubmitButton();
      verify(() => authRepository.signInWithEmailAndPassword(
          testEmail, testPassword)).called(1);
      expect(onSignedInCalled, isTrue);
      r.expectErrorAlertNotFound();
    });

    testWidgets('''
      Given the formtype is signIn,
      when tapping the form switch button,
      then the formtype is changed to register
    ''', (tester) async {
      final r = AuthRobot(tester);
      await r.pumpEmailAndPasswordSignInContents(
        formType: EmailPasswordSignInFormType.signIn,
        authRepository: authRepository,
      );
      await r.tapFormSwitchButton();
      r.expectFormType(EmailPasswordSignInFormType.register);
    });
  });

  group('register', () {
    testWidgets('''
      Given the formtype is register,
      when entering valid email and password,
      and tapping the submit button,
      then createUserWithEmailAndPassword is called
      And onSignedIn is called
      And the errorAlert is not shown
    ''', (tester) async {
      var onSignedInCalled = false;
      final r = AuthRobot(tester);
      await r.pumpEmailAndPasswordSignInContents(
        formType: EmailPasswordSignInFormType.register,
        authRepository: authRepository,
        onSignedIn: () => onSignedInCalled = true,
      );
      when(() => authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword)).thenAnswer((_) => Future.value());
      await r.enterEmail(testEmail);
      await r.enterPassword(testPassword);
      await r.tapEmailAndPasswordSubmitButton();
      verify(() => authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword)).called(1);
      expect(onSignedInCalled, isTrue);
      r.expectErrorAlertNotFound();
    });
    testWidgets('''
      Given the formtype is register,
      when tapping the form switch button,
      then the formtype is changed to signIn
    ''', (tester) async {
      final r = AuthRobot(tester);
      await r.pumpEmailAndPasswordSignInContents(
        formType: EmailPasswordSignInFormType.register,
        authRepository: authRepository,
      );
      await r.tapFormSwitchButton();
      r.expectFormType(EmailPasswordSignInFormType.signIn);
    });
  });
}
