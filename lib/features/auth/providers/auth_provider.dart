import 'package:flutter_riverpod/legacy.dart';

import '../models/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState.guest());

  void signIn({required String name}) {
    state = AuthState.authenticated(userName: name);
  }

  void signOut() {
    state = const AuthState.guest();
  }
}

final StateNotifierProvider<AuthController, AuthState> authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) => AuthController());
