import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/feature_card.dart';
import 'package:travel_guide/widgets/welcome_banner.dart';

import '../detail/feature_detail_page.dart';
import '../home/models/home_feature.dart';
import '../list/feature_list_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  static const List<HomeFeature> _exploreFeatures = <HomeFeature>[
    HomeFeature(
      id: 'outdoors',
      title: 'Epic trails',
      subtitle: 'Guided hikes and mountain escapes.',
      icon: Icons.terrain,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Alpine Adventures',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'matterhorn-circuit',
              title: 'Matterhorn Circuit',
              subtitle: 'Zermatt, Switzerland • 4 days',
              detail:
                  'Tackle the iconic loop with mountain guides, panoramic cable cars, and glacier lookout points.',
            ),
            FeatureListEntry(
              id: 'inca-sunrise',
              title: 'Inca Trail Sunrise',
              subtitle: 'Cusco, Peru • 3 days',
              detail:
                  'Permitted trek to Machu Picchu with sunrise entry, Andean camp cuisine, and cultural stops.',
            ),
          ],
        ),
      ],
    ),
    HomeFeature(
      id: 'art-districts',
      title: 'Art districts',
      subtitle: 'Museums, murals, and galleries.',
      icon: Icons.palette,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Urban Immersions',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'berlin-gallery-hop',
              title: 'Berlin Gallery Hop',
              subtitle: 'Berlin, Germany • Weekend',
              detail:
                  'Walk through Mitte\'s contemporary galleries, underground studios, and street-art corridors.',
            ),
            FeatureListEntry(
              id: 'melbourne-laneways',
              title: 'Melbourne Laneway Murals',
              subtitle: 'Melbourne, Australia • 1 day',
              detail:
                  'Guided stroll through Hosier Lane, pop-up workshops, and espresso stops between murals.',
            ),
          ],
        ),
      ],
    ),
    HomeFeature(
      id: 'nightlife',
      title: 'Nightlife',
      subtitle: 'Comedy clubs and live shows.',
      icon: Icons.theater_comedy,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'After-dark Playbook',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'seoul-neon',
              title: 'Neon Nights in Seoul',
              subtitle: 'Seoul, South Korea • 2 nights',
              detail:
                  'Sip craft soju, catch K-indie gigs in Hongdae, and wrap with late-night barbecue.',
            ),
            FeatureListEntry(
              id: 'lisbon-fado',
              title: 'Fado & Rooftops',
              subtitle: 'Lisbon, Portugal • 1 night',
              detail:
                  'Intimate fado performances in Alfama followed by rooftop cocktails over the Tagus River.',
            ),
          ],
        ),
      ],
    ),
    HomeFeature(
      id: 'wellness',
      title: 'Wellness',
      subtitle: 'Spas, saunas, and mindful retreats.',
      icon: Icons.spa,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Reset Rituals',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'bali-soundbath',
              title: 'Ubud Soundbath Retreat',
              subtitle: 'Bali, Indonesia • 5 days',
              detail:
                  'Daily yoga, ceremonial sound baths, and Balinese healing cuisine amid jungle rice terraces.',
            ),
            FeatureListEntry(
              id: 'finland-sauna',
              title: 'Nordic Sauna Circuit',
              subtitle: 'Helsinki, Finland • Weekend',
              detail:
                  'Ice plunges, lakeside saunas, and mindful forest walks led by local hosts.',
            ),
          ],
        ),
      ],
    ),
  ];

  static const HomeFeature _highlightFeature = HomeFeature(
    id: 'destination-highlights',
    title: 'Destination Highlights',
    subtitle: 'Discover hidden gems, scenic spots, and local favorites.',
    icon: Icons.location_on,
    content: <FeatureListSection>[
      FeatureListSection(
        heading: 'Highlights',
        entries: <FeatureListEntry>[
          FeatureListEntry(
            id: 'bordeaux',
            title: 'Bordeaux Vineyards',
            subtitle: 'France • Day trip',
            detail:
                'Cycle between châteaux, sample small-batch vintages, and picnic along the Garonne.',
          ),
          FeatureListEntry(
            id: 'queenstown',
            title: 'Queenstown Skyline',
            subtitle: 'New Zealand • Half day',
            detail:
                'Ride the gondola, hike to Ben Lomond Saddle, and savor dinners overlooking Lake Wakatipu.',
          ),
          FeatureListEntry(
            id: 'fes-medina',
            title: 'Fes Medina Secrets',
            subtitle: 'Morocco • Guided walk',
            detail:
                'Navigate labyrinthine souks, artisan workshops, and rooftop tea houses with a local storyteller.',
          ),
          FeatureListEntry(
            id: 'banff-lakes',
            title: 'Banff Hidden Lakes',
            subtitle: 'Canada • Full day',
            detail:
                'Canoe emerald waters, spot wildlife on forested trails, and unwind in natural hot springs.',
          ),
          FeatureListEntry(
            id: 'kyoto-night',
            title: 'Kyoto Night Lanterns',
            subtitle: 'Japan • Evening',
            detail:
                'Guided lantern walk through Higashiyama, traditional sweets tasting, and a private tea ritual.',
          ),
          FeatureListEntry(
            id: 'amalfi-coast',
            title: 'Amalfi Coastal Drive',
            subtitle: 'Italy • Day trip',
            detail:
                'Convertible coastal drive, cliffside lemon groves, and sunset aperitivo in Positano.',
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          WelcomeBanner(
            imageUrl:
                'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1600&q=80',
            title: 'Discover More',
            subtitle: 'Unlock curated recommendations tailored to your travel vibe.',
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {},
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
            icon: const Icon(Icons.explore),
            label: const Text('Personalize explore feed'),
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 12 / 9,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: <Widget>[
              for (final HomeFeature feature in _exploreFeatures)
                FeatureCard(
                  icon: feature.icon,
                  title: feature.title,
                  subtitle: feature.subtitle,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => FeatureListPage(feature: feature),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _highlightFeature.content.first.entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (BuildContext context, int index) {
              final FeatureListEntry entry =
                  _highlightFeature.content.first.entries[index];
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
                    '${index + 1}',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
                title: Text(entry.title),
                subtitle: Text(entry.subtitle),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => FeatureDetailPage(
                      feature: _highlightFeature,
                      entry: entry,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
