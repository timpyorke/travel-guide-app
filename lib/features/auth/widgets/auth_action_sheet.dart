import 'package:flutter/material.dart';

import '../../../l10n/app_locale.dart';

typedef AuthActionCallback = Future<void> Function(String displayName);

Future<void> showAuthActionSheet({
  required BuildContext context,
  required AuthActionCallback onSignIn,
  required AuthActionCallback onSignUp,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: AuthActionSheet(onSignIn: onSignIn, onSignUp: onSignUp),
        ),
      );
    },
  );
}

enum _AuthFlowMode { signIn, signUp }

extension on _AuthFlowMode {
  String title(BuildContext context) {
    return this == _AuthFlowMode.signIn
        ? AppLocale.commonSignIn.tr(context)
        : AppLocale.commonCreateAccount.tr(context);
  }
}

class AuthActionSheet extends StatelessWidget {
  const AuthActionSheet({
    super.key,
    required this.onSignIn,
    required this.onSignUp,
  });

  final AuthActionCallback onSignIn;
  final AuthActionCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    final double maxHeight = MediaQuery.of(context).size.height * 0.9;
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.rocket_launch_outlined,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocale.profileAuthSheetTitle.tr(context),
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocale.profileAuthSheetMessage.tr(context),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                _AuthFeatureChip(
                  icon: Icons.tune,
                  label: AppLocale.profileTravelPreferencesTitle.tr(context),
                ),
                _AuthFeatureChip(
                  icon: Icons.language,
                  label: AppLocale.profileLanguageTitle.tr(context),
                ),
                _AuthFeatureChip(
                  icon: Icons.notifications_active_outlined,
                  label: AppLocale.profileNotificationsTitle.tr(context),
                ),
                _AuthFeatureChip(
                  icon: Icons.favorite_outline,
                  label: AppLocale.profileFavoritesTitle.tr(context),
                ),
              ],
            ),
            const SizedBox(height: 28),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool isCompact = constraints.maxWidth < 360;
                final Widget signInButton = FilledButton.icon(
                  onPressed: () =>
                      _openCredentialSheet(context, _AuthFlowMode.signIn),
                  icon: const Icon(Icons.login_rounded),
                  label: Text(AppLocale.commonSignIn.tr(context)),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
                final Widget signUpButton = OutlinedButton.icon(
                  onPressed: () =>
                      _openCredentialSheet(context, _AuthFlowMode.signUp),
                  icon: const Icon(Icons.person_add_alt_1),
                  label: Text(AppLocale.commonCreateAccount.tr(context)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      signInButton,
                      const SizedBox(height: 12),
                      signUpButton,
                    ],
                  );
                }
                return Row(
                  children: <Widget>[
                    Expanded(child: signInButton),
                    const SizedBox(width: 12),
                    Expanded(child: signUpButton),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCredentialSheet(
    BuildContext context,
    _AuthFlowMode mode,
  ) async {
    final String? displayName = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _AuthCredentialSheet(mode: mode);
      },
    );
    if (displayName == null || displayName.trim().isEmpty) {
      return;
    }
    final NavigatorState navigator = Navigator.of(context);
    navigator.pop();
    final String trimmed = displayName.trim();
    if (mode == _AuthFlowMode.signIn) {
      await onSignIn(trimmed);
    } else {
      await onSignUp(trimmed);
    }
  }
}

class _AuthFeatureChip extends StatelessWidget {
  const _AuthFeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthCredentialSheet extends StatefulWidget {
  const _AuthCredentialSheet({required this.mode});

  final _AuthFlowMode mode;

  @override
  State<_AuthCredentialSheet> createState() => _AuthCredentialSheetState();
}

class _AuthCredentialSheetState extends State<_AuthCredentialSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding =
        MediaQuery.of(context).viewInsets +
        const EdgeInsets.fromLTRB(24, 16, 24, 24);
    final String title = widget.mode.title(context);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: padding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                AppLocale.profileAuthSheetMessage.tr(context),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: AppLocale.profileEditorDisplayNameLabel.tr(
                    context,
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocale.profileEditorNameEmpty.tr(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FilledButton(onPressed: _submit, child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pop(_nameController.text.trim());
  }
}
