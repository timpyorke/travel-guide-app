import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/l10n/app_locale.dart';
import 'package:travel_guide/widgets/profile_sections.dart';

import '../auth/models/auth_state.dart';
import '../auth/providers/auth_provider.dart';
import '../location/models/location_selection.dart';
import '../location/providers/location_controller.dart';
import '../../router/app_router.dart';
import '../auth/widgets/auth_action_sheet.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  static const List<String> _availablePreferenceKeys = <String>[
    AppLocale.preferenceCoastal,
    AppLocale.preferenceCultural,
    AppLocale.preferenceFoodie,
    AppLocale.preferencePhotography,
    AppLocale.preferenceOutdoors,
    AppLocale.preferenceWellness,
    AppLocale.preferenceNightlife,
    AppLocale.preferenceFamily,
  ];

  final FlutterLocalization _localization = FlutterLocalization.instance;

  final Set<String> _selectedPreferenceKeys = <String>{
    AppLocale.preferenceCoastal,
    AppLocale.preferenceFoodie,
    AppLocale.preferencePhotography,
  };

  late final List<_LanguageOption> _languageOptions = <_LanguageOption>[
    _LanguageOption(
      locale: const Locale('en', 'US'),
      labelKey: AppLocale.languageEnglishUs,
    ),
    _LanguageOption(
      locale: const Locale('th', 'TH'),
      labelKey: AppLocale.languageThai,
    ),
    _LanguageOption(
      locale: const Locale('zh', 'CN'),
      labelKey: AppLocale.languageChinese,
    ),
  ];

  String? _displayName;
  String? _tagline;
  String _selectedLanguageCode =
      FlutterLocalization.instance.currentLocale?.languageCode ?? 'en';
  bool _shareActivity = true;
  bool _personalizedTips = true;
  bool _tripReminders = true;
  bool _productUpdates = true;
  bool _promoEmails = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String resolvedCode =
        _localization.currentLocale?.languageCode ??
        _languageOptions.first.code;
    if (_selectedLanguageCode != resolvedCode) {
      _selectedLanguageCode = resolvedCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthState authState = ref.watch(authControllerProvider);
    final bool isGuest = authState.isGuest;
    final String effectiveName =
        authState.userName ??
        _displayName ??
        AppLocale.profileNameGuest.tr(context);
    final String tagline = isGuest
        ? AppLocale.profileTaglineGuest.tr(context)
        : (_tagline ?? AppLocale.profileTaglineDefault.tr(context));
    final AsyncValue<LocationSelection?> locationState = ref.watch(
      locationControllerProvider,
    );
    final LocationSelection? selection = locationState.valueOrNull;
    final String locationLabel = selection == null
        ? AppLocale.profileHomeBasePrompt.tr(context)
        : '${selection.city}, ${selection.country}';
    final _LanguageOption activeLanguage = _languageOptions.firstWhere(
      (_LanguageOption option) => option.code == _selectedLanguageCode,
      orElse: () => _languageOptions.first,
    );
    final String languageLabel = activeLanguage.labelKey.tr(context);
    final List<String> notificationFlags = <String>[
      if (_tripReminders)
        AppLocale.profileNotificationTripReminders.tr(context),
      if (_productUpdates)
        AppLocale.profileNotificationProductUpdates.tr(context),
      if (_promoEmails) AppLocale.profileNotificationPartnerOffers.tr(context),
    ];
    final String notificationSubtitle = notificationFlags.isEmpty
        ? AppLocale.profileLanguageAllOff.tr(context)
        : notificationFlags.join(' • ');

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileHeader(
              initials: _initials(effectiveName),
              displayName: effectiveName,
              tagline: tagline,
              showEditButton: !isGuest,
              onEdit: isGuest ? null : _openProfileEditor,
            ),
            const SizedBox(height: 16),
            if (isGuest) ...<Widget>[
              GuestAuthActions(
                onSignIn: _openAuthSheet,
                onCreateAccount: _openAuthSheet,
                message: AppLocale.profileGuestCtaDescription.tr(context),
              ),
              const SizedBox(height: 32),
            ] else ...<Widget>[
              SectionHeader(
                title: AppLocale.profileTravelPreferencesTitle.tr(context),
                action: TextButton.icon(
                  onPressed: _openProfileEditor,
                  icon: const Icon(Icons.tune, size: 18),
                  label: Text(AppLocale.profileAdjustAction.tr(context)),
                ),
              ),
              const SizedBox(height: 12),
              PreferencesSection(
                options: _availablePreferenceKeys,
                selected: _selectedPreferenceKeys,
                onToggle: (String preference, bool value) {
                  setState(() {
                    if (value) {
                      _selectedPreferenceKeys.add(preference);
                    } else {
                      _selectedPreferenceKeys.remove(preference);
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
            ],
            Text(
              AppLocale.profileAccountSettingsTitle.tr(context),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ProfileSettingsCard(
              tiles: <SettingsTileData>[
                if (!isGuest)
                  SettingsTileData(
                    icon: Icons.manage_accounts_outlined,
                    title: AppLocale.profileDetailsTitle.tr(context),
                    subtitle: AppLocale.profileDetailsSubtitle.tr(context),
                    onTap: _openProfileEditor,
                  ),
                if (!isGuest)
                  SettingsTileData(
                    icon: Icons.place_outlined,
                    title: AppLocale.profileHomeBaseTitle.tr(context),
                    subtitle: locationLabel,
                    onTap: () => context.pushNamed(AppRoute.editLocation.name),
                  ),
                SettingsTileData(
                  icon: Icons.language,
                  title: AppLocale.profileLanguageTitle.tr(context),
                  subtitle: languageLabel,
                  onTap: _openLanguageSheet,
                ),
                SettingsTileData(
                  icon: Icons.notifications_outlined,
                  title: AppLocale.profileNotificationsTitle.tr(context),
                  subtitle: notificationSubtitle,
                  onTap: isGuest ? _openAuthSheet : _openNotificationSettings,
                ),
                SettingsTileData(
                  icon: Icons.security,
                  title: AppLocale.profilePrivacyTitle.tr(context),
                  subtitle: AppLocale.profilePrivacySubtitle.tr(context),
                  onTap: _openPrivacySettings,
                ),
                SettingsTileData(
                  icon: Icons.help_outline,
                  title: AppLocale.profileSupportTitle.tr(context),
                  subtitle: AppLocale.profileSupportSubtitle.tr(context),
                  onTap: _openSupportSheet,
                ),
              ],
            ),
            if (!isGuest)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                  child: TextButton.icon(
                    onPressed: _handleSignOut,
                    icon: const Icon(Icons.logout),
                    label: Text(AppLocale.profileSignOut.tr(context)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _openPrivacySettings() async {
    bool shareActivity = _shareActivity;
    bool personalizedTips = _personalizedTips;

    final bool? saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder:
                (
                  BuildContext context,
                  void Function(void Function()) setModalState,
                ) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocale.profilePrivacySheetTitle.tr(context),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocale.profilePrivacyShareActivity.tr(context),
                          ),
                          subtitle: Text(
                            AppLocale.profilePrivacyShareActivitySubtitle.tr(
                              context,
                            ),
                          ),
                          value: shareActivity,
                          onChanged: (bool value) {
                            setModalState(() => shareActivity = value);
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocale.profilePrivacyPersonalizedTips.tr(
                              context,
                            ),
                          ),
                          subtitle: Text(
                            AppLocale.profilePrivacyPersonalizedTipsSubtitle.tr(
                              context,
                            ),
                          ),
                          value: personalizedTips,
                          onChanged: (bool value) {
                            setModalState(() => personalizedTips = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(AppLocale.profilePrivacyFooter.tr(context)),
                        const SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(AppLocale.commonCancel.tr(context)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(AppLocale.commonSave.tr(context)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
          ),
        );
      },
    );

    if (saved == true) {
      setState(() {
        _shareActivity = shareActivity;
        _personalizedTips = personalizedTips;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocale.profilePrivacyUpdated.tr(context))),
      );
    }
  }

  Future<void> _openLanguageSheet() async {
    String tempLanguage = _selectedLanguageCode;

    final bool? saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (
                BuildContext context,
                void Function(void Function()) modalSetState,
              ) {
                final EdgeInsets viewInsets = MediaQuery.of(context).viewInsets;
                return SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      24,
                      16,
                      24,
                      24 + viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocale.profileLanguageSheetTitle.tr(context),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        ..._languageOptions.map(
                          (_LanguageOption option) => RadioListTile<String>(
                            value: option.code,
                            groupValue: tempLanguage,
                            title: Text(option.labelKey.tr(context)),
                            onChanged: (String? value) {
                              if (value != null) {
                                modalSetState(() => tempLanguage = value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppLocale.profileLanguageSheetDescription.tr(context),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(AppLocale.commonCancel.tr(context)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(AppLocale.commonSave.tr(context)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
        );
      },
    );

    if (saved == true && tempLanguage != _selectedLanguageCode) {
      final _LanguageOption option = _languageOptions.firstWhere(
        (_LanguageOption element) => element.code == tempLanguage,
        orElse: () => _languageOptions.first,
      );
      setState(() {
        _selectedLanguageCode = tempLanguage;
      });
      _localization.translate(option.code);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocale.profileLanguageUpdated.tr(context))),
      );
    }
  }

  Future<void> _openSupportSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocale.profileSupportSheetTitle.tr(context),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.help_center_outlined),
                title: Text(AppLocale.profileSupportFaqTitle.tr(context)),
                subtitle: Text(AppLocale.profileSupportFaqSubtitle.tr(context)),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocale.profileSupportFaqComingSoon.tr(context),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text(AppLocale.profileSupportEmailTitle.tr(context)),
                subtitle: Text(
                  AppLocale.profileSupportEmailSubtitle.tr(context),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocale.profileSupportEmailToast.tr(context),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: Text(AppLocale.profileSupportChatTitle.tr(context)),
                subtitle: Text(
                  AppLocale.profileSupportChatSubtitle.tr(context),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocale.profileSupportChatToast.tr(context),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openProfileEditor() async {
    final TextEditingController nameController = TextEditingController(
      text: _displayName ?? '',
    );
    final TextEditingController taglineController = TextEditingController(
      text: _tagline ?? '',
    );
    final Set<String> tempSelected = Set<String>.from(_selectedPreferenceKeys);

    final bool? didSave = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder:
                (
                  BuildContext context,
                  void Function(void Function()) setModalState,
                ) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          AppLocale.profileEditorTitle.tr(context),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: AppLocale.profileEditorDisplayNameLabel
                                .tr(context),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: taglineController,
                          decoration: InputDecoration(
                            labelText: AppLocale.profileEditorTaglineLabel.tr(
                              context,
                            ),
                            hintText: AppLocale.profileEditorTaglineHint.tr(
                              context,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          AppLocale.profileEditorPreferencesTitle.tr(context),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _availablePreferenceKeys.map((
                            String preference,
                          ) {
                            final bool isSelected = tempSelected.contains(
                              preference,
                            );
                            return FilterChip(
                              label: Text(preference.tr(context)),
                              selected: isSelected,
                              onSelected: (bool value) {
                                setModalState(() {
                                  if (value) {
                                    tempSelected.add(preference);
                                  } else {
                                    tempSelected.remove(preference);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(AppLocale.commonCancel.tr(context)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  if (nameController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppLocale.profileEditorNameEmpty.tr(
                                            context,
                                          ),
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  AppLocale.commonSaveChanges.tr(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
          ),
        );
      },
    );

    if (didSave == true) {
      setState(() {
        _displayName = nameController.text.trim();
        final String trimmedTagline = taglineController.text.trim();
        _tagline = trimmedTagline.isEmpty
            ? AppLocale.profilePreferencesTaglineFallback.tr(context)
            : trimmedTagline;
        _selectedPreferenceKeys
          ..clear()
          ..addAll(tempSelected);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocale.profileEditorUpdated.tr(context))),
      );
    }
  }

  Future<void> _openNotificationSettings() async {
    bool tripReminders = _tripReminders;
    bool productUpdates = _productUpdates;
    bool promoEmails = _promoEmails;

    final bool? saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder:
                (
                  BuildContext context,
                  void Function(void Function()) setStateModal,
                ) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocale.profileNotificationsSheetTitle.tr(context),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocale.profileNotificationTripReminders.tr(
                              context,
                            ),
                          ),
                          subtitle: Text(
                            AppLocale.profileNotificationsTripRemindersSubtitle
                                .tr(context),
                          ),
                          value: tripReminders,
                          onChanged: (bool value) =>
                              setStateModal(() => tripReminders = value),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocale.profileNotificationProductUpdates.tr(
                              context,
                            ),
                          ),
                          subtitle: Text(
                            AppLocale.profileNotificationsProductUpdatesSubtitle
                                .tr(context),
                          ),
                          value: productUpdates,
                          onChanged: (bool value) =>
                              setStateModal(() => productUpdates = value),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppLocale.profileNotificationPartnerOffers.tr(
                              context,
                            ),
                          ),
                          subtitle: Text(
                            AppLocale.profileNotificationsPartnerOffersSubtitle
                                .tr(context),
                          ),
                          value: promoEmails,
                          onChanged: (bool value) =>
                              setStateModal(() => promoEmails = value),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(AppLocale.commonCancel.tr(context)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(AppLocale.commonSave.tr(context)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
          ),
        );
      },
    );

    if (saved == true) {
      setState(() {
        _tripReminders = tripReminders;
        _productUpdates = productUpdates;
        _promoEmails = promoEmails;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocale.profileNotificationsUpdated.tr(context)),
        ),
      );
    }
  }

  Future<void> _openAuthSheet() async {
    await showAuthActionSheet(
      context: context,
      onSignIn: _simulateSignIn,
      onSignUp: _simulateSignIn,
    );
  }

  void _simulateSignIn() {
    Navigator.of(context).pop();
    ref.read(authControllerProvider.notifier).signIn(name: 'Avery Traveler');
    setState(() {
      _displayName = 'Avery Traveler';
      _tagline = AppLocale.profileTaglineSignedIn.tr(context);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocale.profileSignedInAs.trParams(context, <String, String>{
            'name': 'Avery Traveler',
          }),
        ),
      ),
    );
  }

  void _handleSignOut() {
    ref.read(authControllerProvider.notifier).signOut();
    setState(() {
      _displayName = null;
      _tagline = null;
      _selectedPreferenceKeys
        ..clear()
        ..addAll(<String>{
          AppLocale.preferenceCoastal,
          AppLocale.preferenceFoodie,
          AppLocale.preferencePhotography,
        });
      _tripReminders = true;
      _productUpdates = true;
      _promoEmails = false;
      _shareActivity = true;
      _personalizedTips = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocale.profileSignedOut.tr(context))),
    );
  }

  String _initials(String name) {
    final String trimmed = name.trim();
    if (trimmed.isEmpty) return 'TG';
    final List<String> parts = trimmed.split(RegExp(r'\\s+'));
    final String firstChar = parts.first.isNotEmpty
        ? parts.first.substring(0, 1)
        : 'T';
    final String secondChar;
    if (parts.length > 1 && parts.last.isNotEmpty) {
      secondChar = parts.last.substring(0, 1);
    } else if (parts.first.length > 1) {
      secondChar = parts.first.substring(1, 2);
    } else {
      secondChar = 'G';
    }
    return (firstChar + secondChar).toUpperCase();
  }
}

class _LanguageOption {
  const _LanguageOption({required this.locale, required this.labelKey});

  final Locale locale;
  final String labelKey;

  String get code => locale.languageCode;
}


