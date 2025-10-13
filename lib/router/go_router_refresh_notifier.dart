import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier({
    required Ref ref,
    required ProviderListenable<dynamic> listenable,
  }) {
    _subscription = ref.listen<dynamic>(
      listenable,
      (_, __) => notifyListeners(),
      fireImmediately: true,
    );
  }

  late final ProviderSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
