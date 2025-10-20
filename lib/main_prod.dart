import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'flavors.dart';
import 'app/initialized.dart';

Future<void> main() async {
  await Initialized.ensure();
  F.appFlavor = Flavor.production;

  runApp(const ProviderScope(child: App()));
}
