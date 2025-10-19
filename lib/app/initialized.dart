import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';

/// Centralizes application-level initialization invoked at app launch.
class Initialized {
  const Initialized._();

  static Future<void> ensure() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterLocalization.instance.ensureInitialized();
  }
}
