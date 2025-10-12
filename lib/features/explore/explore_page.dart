import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/feature_card.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  colorScheme.primary,
                  colorScheme.primary.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Discover More',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Unlock curated recommendations tailored to your travel vibe.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: colorScheme.onPrimary.withOpacity(0.85)),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.onPrimary,
                    foregroundColor: colorScheme.primary,
                  ),
                  icon: const Icon(Icons.explore),
                  label: const Text('Personalize explore feed'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 12 / 9,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: const <Widget>[
              FeatureCard(
                icon: Icons.terrain,
                title: 'Epic trails',
                subtitle: 'Guided hikes and mountain escapes.',
              ),
              FeatureCard(
                icon: Icons.palette,
                title: 'Art districts',
                subtitle: 'Museums, murals, and galleries.',
              ),
              FeatureCard(
                icon: Icons.theater_comedy,
                title: 'Nightlife',
                subtitle: 'Comedy clubs and live shows.',
              ),
              FeatureCard(
                icon: Icons.spa,
                title: 'Wellness',
                subtitle: 'Spas, saunas, and mindful retreats.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final int day = index + 1;
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: colorScheme.surfaceVariant,
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  child: Text(
                    '$day',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
                title: Text('Destination Highlight $day'),
                subtitle: const Text(
                  'Discover hidden gems, scenic spots, and local favorites.',
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
            itemCount: 6,
          ),
        ],
      ),
    );
  }
}
