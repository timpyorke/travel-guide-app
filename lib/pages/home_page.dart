import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/location/models/location_selection.dart';
import '../features/location/providers/location_controller.dart';
import '../flavors.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<LocationSelection?> locationState =
        ref.watch(locationControllerProvider);
    final LocationSelection? selection = locationState.valueOrNull;
    final String greetingSubtitle = selection == null
        ? 'Set your travel home base to unlock tailored guides.'
        : 'Exploring ideas for ${selection.city}, ${selection.country}.';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to ${F.title}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              greetingSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 4 / 3,
                children: const <Widget>[
                  _FeatureCard(
                    icon: Icons.map,
                    title: 'Itineraries',
                    subtitle: 'Handpicked routes across top destinations.',
                  ),
                  _FeatureCard(
                    icon: Icons.restaurant,
                    title: 'Local Eats',
                    subtitle: 'Taste the culture with foodie favorites.',
                  ),
                  _FeatureCard(
                    icon: Icons.event,
                    title: 'Festivals',
                    subtitle: 'Don\'t miss the best seasonal events.',
                  ),
                  _FeatureCard(
                    icon: Icons.tips_and_updates,
                    title: 'Tips',
                    subtitle: 'Travel smarter with pro insights.',
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

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
