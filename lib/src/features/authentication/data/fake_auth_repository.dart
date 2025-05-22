import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifted/src/features/authentication/domain/app_user.dart';
import 'package:lifted/src/utils/in_memory_store.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Connection failed');
    _authState.value = null;
  }

  void _createNewUser(String email) {
    // note: the uid could be any unique string. Here we simply reverse the email.
    _authState.value =
        AppUser(uid: email.split('').reversed.join(), email: email);
  }

  void dispose() => _authState.close();
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
