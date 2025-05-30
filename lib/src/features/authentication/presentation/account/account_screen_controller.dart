import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifted/src/features/authentication/data/fake_auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncData<void>(null));

  final FakeAuthRepository authRepository;

  Future<void> signOut() async {
    // try {
    //   state = const AsyncValue<void>.loading();
    //   await authRepository.signOut();
    //   state = const AsyncValue<void>.data(null);
    //   return true;
    // } catch (e, st) {
    //   state = AsyncValue<void>.error(e, st);
    //   return false;
    // }
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider<AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
