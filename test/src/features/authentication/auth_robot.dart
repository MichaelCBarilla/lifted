import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/common_widgets/alert_dialogs.dart';
import 'package:lifted/src/common_widgets/custom_text_button.dart';
import 'package:lifted/src/common_widgets/primary_button.dart';
import 'package:lifted/src/features/authentication/data/fake_auth_repository.dart';
import 'package:lifted/src/features/authentication/presentation/account/account_screen.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:lifted/src/features/workouts/presentation/home_app_bar/more_menu_button.dart';

import '../../mocks.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  // pumpers
  Future<void> pumpAccountScreen({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null)
            authRepositoryProvider.overrideWithValue(authRepository)
        ],
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> pumpEmailAndPasswordSignInContents({
    required FakeAuthRepository? authRepository,
    required EmailPasswordSignInFormType formType,
    VoidCallback? onSignedIn,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null)
            authRepositoryProvider.overrideWithValue(authRepository)
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EmailPasswordSignInContents(
              formType: formType,
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
  }

  //actions
  Future<void> openAccountScreen() async {
    final accountButton = find.byKey(MoreMenuButton.accountKey);
    expect(accountButton, findsOneWidget);
    await tester.tap(accountButton);
    await tester.pumpAndSettle();
  }

  Future<void> enterEmail(String email) async {
    final emailField = find.byKey(EmailPasswordSignInScreen.emailKey);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
    await tester.pump();
  }

  Future<void> enterPassword(String password) async {
    final passwordField = find.byKey(EmailPasswordSignInScreen.passwordKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
    await tester.pump();
  }

  Future<void> signInWithEmailAndPassword() async {
    await enterEmail('test@test.com');
    await enterPassword('test1234');
    await tapEmailAndPasswordSubmitButton();
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final submitButton = find.byType(PrimaryButton);
    expect(submitButton, findsOneWidget);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapFormSwitchButton() async {
    final formSwitchButton = find.byType(CustomTextButton);
    expect(formSwitchButton, findsOneWidget);
    await tester.tap(formSwitchButton);
    await tester.pump();
  }

  Future<void> tapLogoutButton() async {
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  Future<void> tapCancelButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  Future<void> tapDialogLogoutButton({shouldSettle = false}) async {
    final logoutButton = find.byKey(kDialogDefaultKey);
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    shouldSettle ? await tester.pumpAndSettle() : await tester.pump();
  }

  //expectations
  void expectFormType(EmailPasswordSignInFormType formType) {
    var formTypeText = '';
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        formTypeText = 'Sign in';
      case EmailPasswordSignInFormType.register:
        formTypeText = 'Create an account';
    }
    final formTypeTextFinder = find.text(formTypeText);
    expect(formTypeTextFinder, findsOneWidget);
  }

  void expectLogoutDialogFound() {
    final dialogText = find.text('Are you sure?');
    expect(dialogText, findsOneWidget);
  }

  void expectLogoutDialogNotFound() {
    final dialogText = find.text('Are you sure?');
    expect(dialogText, findsNothing);
  }

  void expectErrorAlertFound() {
    final finder = find.text('Error');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text('Error');
    expect(finder, findsNothing);
  }

  void expectCircularProgressIndicator() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOneWidget);
  }
}
