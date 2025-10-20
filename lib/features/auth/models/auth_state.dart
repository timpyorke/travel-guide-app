enum AuthStatus { guest, authenticated }

class AuthState {
  const AuthState._(this.status, this.userName);

  const AuthState.guest() : this._(AuthStatus.guest, null);

  const AuthState.authenticated({required this.userName})
      : status = AuthStatus.authenticated;

  final AuthStatus status;
  final String? userName;

  bool get isGuest => status == AuthStatus.guest;
}
