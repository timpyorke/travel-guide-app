import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/base/models/app_router_type.dart';

import '../location/models/location_selection.dart';
import '../location/providers/location_controller.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key, this.isEditing = false});

  final bool isEditing;

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  String? _selectedCountryOverride;
  String? _selectedCityOverride;
  final Set<String> _selectedPreferences = <String>{};

  Future<void> _submit() async {
    final LocationSelection? selection = ref
        .read(locationControllerProvider)
        .valueOrNull;
    final String? country = _selectedCountryOverride ?? selection?.country;
    final String? city = _selectedCityOverride ?? selection?.city;
    if (country == null || city == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both country and city.')),
      );
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(locationControllerProvider.notifier);

    try {
      await notifier.setLocation(country: country, city: city);
      if (mounted) {
        if (widget.isEditing) {
          messenger.showSnackBar(
            const SnackBar(content: Text('Travel home base updated.')),
          );
          context.pop();
        } else {
          context.go(AppRoute.home.path);
        }
      }
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to save location: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationControllerProvider);
    final controller = ref.watch(locationControllerProvider.notifier);
    final LocationSelection? selection = locationState.valueOrNull;
    final List<String> countryOptions = controller.countries;
    final String? resolvedCountry =
        _selectedCountryOverride ?? selection?.country;
    final String? resolvedCity = _selectedCityOverride ?? selection?.city;
    final List<String> cityOptions = resolvedCountry == null
        ? const <String>[]
        : controller.citiesForCountry(resolvedCountry);
    const List<String> preferenceOptions = <String>[
      'Culture',
      'Food & Drink',
      'Outdoors',
      'Nightlife',
      'Wellness',
      'Family Friendly',
    ];

    final bool isLoading = locationState.isLoading;
    final String title = widget.isEditing
        ? 'Update your travel home base'
        : 'Choose your travel home base';

    return Scaffold(
      appBar: widget.isEditing
          ? AppBar(title: const Text('Change home location'))
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              Text(
                'Pick a country and city to personalize your travel guide recommendations.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: resolvedCountry,
                items: countryOptions
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
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountryOverride = newValue;
                    _selectedCityOverride = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: resolvedCity,
                items: cityOptions
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
                onChanged: resolvedCountry == null
                    ? null
                    : (String? newValue) {
                        setState(() {
                          _selectedCityOverride = newValue;
                        });
                      },
              ),
              const SizedBox(height: 24),
              Text(
                'Travel preferences',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: preferenceOptions
                    .map(
                      (String preference) => FilterChip(
                        label: Text(preference),
                        selected: _selectedPreferences.contains(preference),
                        onSelected: (bool isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedPreferences.add(preference);
                            } else {
                              _selectedPreferences.remove(preference);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: isLoading ? null : _submit,
                icon: const Icon(Icons.check_circle),
                label: Text(widget.isEditing ? 'Save changes' : 'Continue'),
              ),
              if (widget.isEditing)
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          await ref
                              .read(locationControllerProvider.notifier)
                              .clearLocation();
                          if (mounted) {
                            setState(() {
                              _selectedCountryOverride = null;
                              _selectedCityOverride = null;
                            });
                          }
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Location cleared.'),
                              ),
                            );
                            context.pop();
                          }
                        },
                  child: const Text('Clear selection'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
