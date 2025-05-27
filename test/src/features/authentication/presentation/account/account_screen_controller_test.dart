import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/features/authentication/data/fake_auth_repository.dart';
import 'package:lifted/src/features/authentication/presentation/account/account_screen_controller.dart';

void main() {
  group('AccountScreenController', () {
    test('initital state is AsyncData', () {
      final authRepo = FakeAuthRepository();
      final controller = AccountScreenController(authRepository: authRepo);
      expect(controller.state, AsyncData<void>(null));
    });
  });
}
