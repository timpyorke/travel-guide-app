import 'package:flutter/foundation.dart';

/// Bridges a [ChangeNotifier] with GoRouter's [Listenable] refresh API.
class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier({required ChangeNotifier listenable})
    : _listenable = listenable {
    _listenable.addListener(_handleChange);
  }

  final ChangeNotifier _listenable;

  void _handleChange() => notifyListeners();

  @override
  void dispose() {
    _listenable.removeListener(_handleChange);
    super.dispose();
  }
}
