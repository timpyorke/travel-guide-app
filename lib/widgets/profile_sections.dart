import 'package:flutter/material.dart';
import 'package:travel_guide/l10n/app_locale.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.initials,
    required this.displayName,
    required this.tagline,
    this.onEdit,
    this.showEditButton = false,
  });

  final String initials;
  final String displayName;
  final String tagline;
  final VoidCallback? onEdit;
  final bool showEditButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 36,
          backgroundColor: theme.colorScheme.primary,
          child: Text(
            initials,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(displayName, style: theme.textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(tagline, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class GuestAuthActions extends StatelessWidget {
  const GuestAuthActions({
    super.key,
    required this.onSignIn,
    required this.onCreateAccount,
    required this.message,
  });

  final VoidCallback onSignIn;
  final VoidCallback onCreateAccount;
  final String message;

  @override
  Widget build(BuildContext context) {
    final TextStyle? bodyStyle = Theme.of(context).textTheme.bodyMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: FilledButton(
                onPressed: onSignIn,
                child: Text(AppLocale.commonSignIn.tr(context)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: onCreateAccount,
                child: Text(AppLocale.commonCreateAccount.tr(context)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(message, style: bodyStyle),
      ],
    );
  }
}

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({
    super.key,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  final List<String> options;
  final Set<String> selected;
  final void Function(String preference, bool isSelected) onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((String preferenceKey) {
        final bool isSelected = selected.contains(preferenceKey);
        return ChoiceChip(
          label: Text(preferenceKey.tr(context)),
          selected: isSelected,
          onSelected: (bool value) => onToggle(preferenceKey, value),
        );
      }).toList(),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.action});

  final String title;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        action,
      ],
    );
  }
}

class SettingsTileData {
  const SettingsTileData({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
}

class ProfileSettingsCard extends StatelessWidget {
  const ProfileSettingsCard({super.key, required this.tiles});

  final List<SettingsTileData> tiles;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < tiles.length; i++) ...<Widget>[
            _SettingsTile(
              icon: tiles[i].icon,
              title: tiles[i].title,
              subtitle: tiles[i].subtitle,
              onTap: tiles[i].onTap,
            ),
            if (i != tiles.length - 1) const Divider(height: 1),
          ],
        ],
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
