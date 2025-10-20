import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:travel_guide/firebase_options.dart';

/// Centralizes application-level initialization invoked at app launch.

Future<void> initialized() async {
  await localization();
  await firebase();
}

Future<void> localization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
}

Future<void> firebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
