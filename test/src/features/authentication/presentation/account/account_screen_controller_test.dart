import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifted/src/features/authentication/data/fake_auth_repository.dart';
import 'package:lifted/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    late MockAuthRepository authRepository;
    late AccountScreenController controller;
    setUp(() {
      authRepository = MockAuthRepository();
      controller = AccountScreenController(authRepository: authRepository);
    });
    test('initital state is AsyncData', () {
      verifyNever(authRepository.signOut);
      expect(controller.state, AsyncData<void>(null));
    });

    test('signOut success', () async {
      // setup
      when(authRepository.signOut).thenAnswer(
        (_) => Future.value(),
      );
      expectLater(
        controller.stream,
        emitsInOrder(
          const [
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ],
        ),
      );
      // run
      await controller.signOut();
      // verify
      verify(authRepository.signOut).called(1);
    });

    test('signOut failure', () async {
      // setup
      final exception = Exception('Connection Failed');
      when(authRepository.signOut).thenThrow(exception);
      expectLater(
        controller.stream,
        emitsInOrder(
          [
            AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value.hasError, true);
              return true;
            }),
          ],
        ),
      );
      // run
      await controller.signOut();
      // verify
      verify(authRepository.signOut).called(1);
    });
  });
}
