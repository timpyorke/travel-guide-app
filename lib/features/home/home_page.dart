import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../location/models/location_selection.dart';
import '../location/providers/location_controller.dart';
import '../../flavors.dart';
import '../../widgets/feature_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<LocationSelection?> locationState = ref.watch(
      locationControllerProvider,
    );
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
                  FeatureCard(
                    icon: Icons.map,
                    title: 'Itineraries',
                    subtitle: 'Handpicked routes across top destinations.',
                  ),
                  FeatureCard(
                    icon: Icons.restaurant,
                    title: 'Local Eats',
                    subtitle: 'Taste the culture with foodie favorites.',
                  ),
                  FeatureCard(
                    icon: Icons.event,
                    title: 'Festivals',
                    subtitle: 'Don\'t miss the best seasonal events.',
                  ),
                  FeatureCard(
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
