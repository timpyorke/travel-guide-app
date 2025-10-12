import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/widgets/profile_sections.dart';

import '../auth/models/auth_state.dart';
import '../auth/providers/auth_provider.dart';
import '../location/models/location_selection.dart';
import '../location/providers/location_controller.dart';
import '../../router/app_router.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  static const List<String> _availablePreferences = <String>[
    'Coastal',
    'Cultural',
    'Foodie',
    'Photography',
    'Outdoors',
    'Wellness',
    'Nightlife',
    'Family-friendly',
  ];

  String _displayName = 'Traveler Guest';
  String _tagline = 'Sunrise chaser • Food lover';
  final Set<String> _selectedPreferences = <String>{
    'Coastal',
    'Foodie',
    'Photography',
  };
  final List<String> _supportedLanguages = <String>[
    'English (US)',
    'Français',
    'Deutsch',
    'ไทย',
    '日本語',
  ];
  String _selectedLanguage = 'English (US)';
  bool _shareActivity = true;
  bool _personalizedTips = true;
  bool _tripReminders = true;
  bool _productUpdates = true;
  bool _promoEmails = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthState authState = ref.watch(authControllerProvider);
    final bool isGuest = authState.isGuest;
    final String effectiveName = authState.userName ?? _displayName;
    final String tagline = authState.isGuest
        ? 'Sign in to personalize suggestions'
        : _tagline;
    final AsyncValue<LocationSelection?> locationState = ref.watch(
      locationControllerProvider,
    );
    final LocationSelection? selection = locationState.valueOrNull;
    final String locationLabel = selection == null
        ? 'Set a home base to personalize trips'
        : '${selection.city}, ${selection.country}';
    final List<String> notificationFlags = <String>[
      if (_tripReminders) 'Trip reminders',
      if (_productUpdates) 'Product updates',
      if (_promoEmails) 'Partner offers',
    ];
    final String notificationSubtitle = notificationFlags.isEmpty
        ? 'All notifications off'
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
                message:
                    'Sign in to save plans, sync preferences, and access exclusive itineraries.',
              ),
              const SizedBox(height: 32),
            ] else ...<Widget>[
              SectionHeader(
                title: 'Travel Preferences',
                action: TextButton.icon(
                  onPressed: _openProfileEditor,
                  icon: const Icon(Icons.tune, size: 18),
                  label: const Text('Adjust'),
                ),
              ),
              const SizedBox(height: 12),
              PreferencesSection(
                options: _availablePreferences,
                selected: _selectedPreferences,
                onToggle: (String preference, bool value) {
                  setState(() {
                    if (value) {
                      _selectedPreferences.add(preference);
                    } else {
                      _selectedPreferences.remove(preference);
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
            ],
            Text('Account Settings', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            ProfileSettingsCard(
              tiles: <SettingsTileData>[
                if (!isGuest)
                  SettingsTileData(
                    icon: Icons.manage_accounts_outlined,
                    title: 'Profile details',
                    subtitle: 'Update name & travel style',
                    onTap: _openProfileEditor,
                  ),
                if (!isGuest)
                  SettingsTileData(
                    icon: Icons.place_outlined,
                    title: 'Travel home base',
                    subtitle: locationLabel,
                    onTap: () => context.pushNamed(AppRoute.editLocation.name),
                  ),
                SettingsTileData(
                  icon: Icons.language,
                  title: 'App language',
                  subtitle: _selectedLanguage,
                  onTap: _openLanguageSheet,
                ),
                SettingsTileData(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: notificationSubtitle,
                  onTap: isGuest ? _openAuthSheet : _openNotificationSettings,
                ),
                SettingsTileData(
                  icon: Icons.security,
                  title: 'Privacy',
                  subtitle: 'Manage visibility and data',
                  onTap: _openPrivacySettings,
                ),
                SettingsTileData(
                  icon: Icons.help_outline,
                  title: 'Support',
                  subtitle: 'FAQ and contact options',
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
                    label: const Text('Sign out'),
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
            builder: (BuildContext context, void Function(void Function()) setModalState) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Privacy controls',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Share anonymous activity'),
                      subtitle: const Text(
                        'Improve recommendations by sharing aggregated travel engagement data.',
                      ),
                      value: shareActivity,
                      onChanged: (bool value) {
                        setModalState(() => shareActivity = value);
                      },
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Personalized tips'),
                      subtitle: const Text(
                        'Use your saved plans and preferences to tailor insights.',
                      ),
                      value: personalizedTips,
                      onChanged: (bool value) {
                        setModalState(() => personalizedTips = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'You can request a data export or account deletion at any time through support.',
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Save'),
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
        const SnackBar(content: Text('Privacy preferences updated')),
      );
    }
  }

  Future<void> _openLanguageSheet() async {
    String tempLanguage = _selectedLanguage;

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
                          'Choose app language',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        ..._supportedLanguages.map(
                          (String language) => RadioListTile<String>(
                            value: language,
                            groupValue: tempLanguage,
                            title: Text(language),
                            onChanged: (String? value) {
                              if (value != null) {
                                modalSetState(() => tempLanguage = value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Interface translations roll out progressively. Choosing a language ensures you receive updates as soon as they are available.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Save'),
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

    if (saved == true && tempLanguage != _selectedLanguage) {
      setState(() {
        _selectedLanguage = tempLanguage;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Language set to $_selectedLanguage')),
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
                'Need a hand?',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.help_center_outlined),
                title: const Text('Browse FAQs'),
                subtitle: const Text(
                  'View top questions about planning, saving, and privacy.',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('FAQ center coming soon.')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Email support'),
                subtitle: const Text('We typically reply within 24 hours.'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email composer not wired yet.'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: const Text('Live chat'),
                subtitle: const Text(
                  'Connect with our travel team (weekdays 9-6 PST).',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Chat support launching soon.'),
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
      text: _displayName,
    );
    final TextEditingController taglineController = TextEditingController(
      text: _tagline,
    );
    final Set<String> tempSelected = Set<String>.from(_selectedPreferences);

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
                          'Edit profile',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: 'Display name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: taglineController,
                          decoration: const InputDecoration(
                            labelText: 'Travel tagline',
                            hintText: 'Ex. Sunrise chaser • Food lover',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Travel preferences',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _availablePreferences.map((
                            String preference,
                          ) {
                            final bool isSelected = tempSelected.contains(
                              preference,
                            );
                            return FilterChip(
                              label: Text(preference),
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
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  if (nameController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Name cannot be empty.'),
                                      ),
                                    );
                                    return;
                                  }
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Save changes'),
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
        _tagline = taglineController.text.trim().isEmpty
            ? 'Inspired traveler'
            : taglineController.text.trim();
        _selectedPreferences
          ..clear()
          ..addAll(tempSelected);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated')));
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
                          'Notification preferences',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Trip reminders'),
                          subtitle: const Text(
                            'Stay on top of upcoming itineraries and saved routes.',
                          ),
                          value: tripReminders,
                          onChanged: (bool value) =>
                              setStateModal(() => tripReminders = value),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Product updates'),
                          subtitle: const Text(
                            'Learn about new destinations and app features.',
                          ),
                          value: productUpdates,
                          onChanged: (bool value) =>
                              setStateModal(() => productUpdates = value),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Partner offers'),
                          subtitle: const Text(
                            'Get curated deals and exclusive promotions.',
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
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Save'),
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
        const SnackBar(content: Text('Notification preferences updated')),
      );
    }
  }

  Future<void> _openAuthSheet() async {
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
                'Ready to personalize?',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const Text(
                'Sign in or create a Travel Guide account to save plans, sync preferences, and unlock exclusive itineraries.',
              ),
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton(
                      onPressed: _simulateSignIn,
                      child: const Text('Sign in'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _simulateSignIn,
                      child: const Text('Create account'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _simulateSignIn() {
    Navigator.of(context).pop();
    ref.read(authControllerProvider.notifier).signIn(name: 'Avery Traveler');
    setState(() {
      _displayName = 'Avery Traveler';
      _tagline = 'Always chasing golden hours';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed in as Avery Traveler')),
    );
  }

  void _handleSignOut() {
    ref.read(authControllerProvider.notifier).signOut();
    setState(() {
      _displayName = 'Traveler Guest';
      _tagline = 'Sign in to personalize suggestions';
      _selectedPreferences
        ..clear()
        ..addAll(<String>{'Coastal', 'Foodie', 'Photography'});
      _tripReminders = true;
      _productUpdates = true;
      _promoEmails = false;
      _shareActivity = true;
      _personalizedTips = true;
      _selectedLanguage = _supportedLanguages.first;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Signed out')));
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
