import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/core/models/app_router_type.dart';

import 'application/onboarding_controller.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key, this.isEditing = false});

  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingState state = ref.watch(onboardingControllerProvider);
    final OnboardingController controller = ref.read(
      onboardingControllerProvider.notifier,
    );

    Future<void> handleSubmit() async {
      final OnboardingSubmitResult result = await controller.submit();
      if (!context.mounted) {
        return;
      }
      final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      if (result.isSuccess) {
        if (isEditing) {
          messenger.showSnackBar(
            const SnackBar(content: Text('Travel home base updated.')),
          );
          context.pop();
        } else {
          context.go(AppRoute.home.path);
        }
      } else if (result.message != null) {
        messenger.showSnackBar(SnackBar(content: Text(result.message!)));
      }
    }

    Future<void> handleClear() async {
      final OnboardingSubmitResult result = await controller.clearSelection();
      if (!context.mounted) {
        return;
      }
      final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      if (result.isSuccess) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Location cleared.')),
        );
        context.pop();
      } else if (result.message != null) {
        messenger.showSnackBar(SnackBar(content: Text(result.message!)));
      }
    }

    final ThemeData theme = Theme.of(context);
    final bool isProcessing = state.isLoading || state.isSubmitting;
    final String title = isEditing
        ? 'Update your travel home base'
        : 'Choose your travel home base';

    return Scaffold(
      appBar: isEditing
          ? AppBar(title: const Text('Change home location'))
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 12),
              Text(
                'Pick a country and city to personalize your travel guide recommendations.',
                style: theme.textTheme.bodyMedium,
              ),
              if (state.isLoading) ...<Widget>[
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
              ],
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: state.selectedCountry,
                items: state.countryOptions
                    .map(
                      (String country) => DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                onChanged: isProcessing
                    ? null
                    : (String? newValue) => controller.updateCountry(newValue),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: state.selectedCity,
                items: state.cityOptions
                    .map(
                      (String city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                onChanged: isProcessing || state.selectedCountry == null
                    ? null
                    : (String? newValue) => controller.updateCity(newValue),
              ),
              const SizedBox(height: 24),
              Text(
                'Travel preferences',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: kOnboardingPreferenceOptions
                    .map(
                      (String preference) => FilterChip(
                        label: Text(preference),
                        selected: state.selectedPreferences.contains(
                          preference,
                        ),
                        onSelected: isProcessing
                            ? null
                            : (_) => controller.togglePreference(preference),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: state.canSubmit && !isProcessing
                    ? handleSubmit
                    : null,
                icon: state.isSubmitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check_circle),
                label: Text(isEditing ? 'Save changes' : 'Continue'),
              ),
              if (isEditing)
                TextButton(
                  onPressed: isProcessing ? null : handleClear,
                  child: const Text('Clear selection'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
