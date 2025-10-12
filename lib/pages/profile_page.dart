import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/location/models/location_selection.dart';
import '../features/location/providers/location_controller.dart';
import '../router/app_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final AsyncValue<LocationSelection?> locationState =
        ref.watch(locationControllerProvider);
    final LocationSelection? selection = locationState.valueOrNull;
    final String locationLabel =
        selection == null ? 'Set a home base to personalize trips' : '${selection.city}, ${selection.country}';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 36,
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    'TG',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Traveler Guest', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text('Sunrise chaser • Food lover', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Travel Preferences', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const <Widget>[
                _PreferenceChip(label: 'Coastal'),
                _PreferenceChip(label: 'Cultural'),
                _PreferenceChip(label: 'Foodie'),
                _PreferenceChip(label: 'Photography'),
              ],
            ),
            const SizedBox(height: 32),
            Text('Account Settings', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: <Widget>[
                  _SettingsTile(
                    icon: Icons.place_outlined,
                    title: 'Travel home base',
                    subtitle: locationLabel,
                    onTap: () => context.pushNamed(AppRoute.editLocation.name),
                  ),
                  const Divider(height: 1),
                  const _SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Trip updates and reminders',
                  ),
                  const Divider(height: 1),
                  const _SettingsTile(
                    icon: Icons.security,
                    title: 'Privacy',
                    subtitle: 'Manage visibility and data',
                  ),
                  const Divider(height: 1),
                  const _SettingsTile(
                    icon: Icons.help_outline,
                    title: 'Support',
                    subtitle: 'FAQ and contact options',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceChip extends StatelessWidget {
  const _PreferenceChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSecondaryContainer,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      onTap: onTap,
    );
  }
}
