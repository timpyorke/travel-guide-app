import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flavors.dart';
import 'l10n/app_locale.dart';
import 'features/location/providers/location_controller.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    super.initState();

    _localization.init(
      mapLocales: const <MapLocale>[
        MapLocale('en', AppLocale.en, countryCode: 'US'),
        MapLocale('th', AppLocale.th),
        MapLocale('zh', AppLocale.zh),
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _handleTranslatedLanguage;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(locationControllerProvider.notifier).syncWithDeviceLocation();
    });
  }

  @override
  void dispose() {
    _localization.onTranslatedLanguage = null;
    super.dispose();
  }

  void _handleTranslatedLanguage(Locale? locale) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final String title = F.title;

    return MaterialApp.router(
      title: title,
      theme: AppTheme.light(),
      routerConfig: router,
      locale: _localization.currentLocale,
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        ..._localization.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
