import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_guide/widgets/city_context_grid.dart';
import 'package:travel_guide/widgets/city_detail_page.dart';
import 'package:travel_guide/widgets/feature_card.dart';
import 'package:travel_guide/widgets/plan_ahead_section.dart';
import 'package:travel_guide/widgets/quick_planner_sheet.dart';
import 'package:travel_guide/widgets/travel_insights_section.dart';
import 'package:travel_guide/widgets/welcome_banner.dart';

import '../location/models/location_selection.dart';
import '../location/providers/location_controller.dart';
import 'models/home_feature.dart';
import '../list/feature_list_page.dart';
import '../../flavors.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const List<HomeFeature> _homeFeatures = <HomeFeature>[
    HomeFeature(
      id: 'itineraries',
      title: 'Itineraries',
      subtitle: 'Handpicked routes across top destinations.',
      icon: Icons.map,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Kyoto, Japan',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'kyoto-day1',
              title: 'Two-day Cherry Blossom Walk',
              subtitle: 'Kyoto • 2 days • Spring',
              detail:
                  'Experience Kyoto\'s blossom season with temple visits, tea ceremonies, and scenic hikes.',
            ),
            FeatureListEntry(
              id: 'kyoto-day2',
              title: 'Gion Cultural Evening',
              subtitle: 'Kyoto • 1 evening',
              detail:
                  'Wander historic alleys, catch traditional performances, and dine in intimate kaiseki venues.',
            ),
          ],
        ),
        FeatureListSection(
          heading: 'Lisbon, Portugal',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'lisbon-weekend',
              title: 'Against the Atlantic Breeze',
              subtitle: 'Lisbon • 3 days',
              detail:
                  'A city-to-coast jump featuring pastel delights, fado nights, and day trips to Sintra cliffs.',
            ),
          ],
        ),
      ],
    ),
    HomeFeature(
      id: 'eats',
      title: 'Local Eats',
      subtitle: 'Taste the culture with foodie favorites.',
      icon: Icons.restaurant,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Chiang Mai Classics',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'chiangmai-lanna',
              title: 'Lanna Flavors Night Market',
              subtitle: 'Chiang Mai • 1 night',
              detail:
                  'Sample khao soi, sai oua, and coconut ice cream across lively street stalls.',
            ),
            FeatureListEntry(
              id: 'chiangmai-coffee',
              title: 'Doi Coffee Roastery Hop',
              subtitle: 'Chiang Mai • Half day',
              detail:
                  'Sip single-origin pours from mountain cooperatives paired with locally baked pastries.',
            ),
          ],
        ),
        FeatureListSection(
          heading: 'Barcelona Bites',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'barcelona-tapas',
              title: 'Tapas Trail in El Born',
              subtitle: 'Barcelona • Evening',
              detail:
                  'Discover pintxos bars, vermouth tastings, and sweet churros around medieval squares.',
            ),
          ],
        ),
      ],
    ),
    HomeFeature(
      id: 'festivals',
      title: 'Festivals',
      subtitle: 'Don\'t miss the best seasonal events.',
      icon: Icons.event,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Global Calendar',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'edinburgh-fringe',
              title: 'Edinburgh Fringe',
              subtitle: 'Scotland • August',
              detail:
                  'World\'s largest arts festival with over 3,000 shows across comedy, theatre, and improv.',
            ),
            FeatureListEntry(
              id: 'songkran',
              title: 'Songkran Water Festival',
              subtitle: 'Thailand • April',
              detail:
                  'Join nationwide water fights, temple rituals, and street parades welcoming Thai New Year.',
            ),
          ],
        ),
        FeatureListSection(
          heading: 'Local Picks',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'tokyo-design',
              title: 'Tokyo Design Week',
              subtitle: 'Japan • October',
              detail:
                  'Immersive exhibitions, pop-up studios, and collaborative installations across the city.',
            ),
          ],
        ),
      ],
    ),
    HomeFeature(
      id: 'tips',
      title: 'Tips',
      subtitle: 'Travel smarter with pro insights.',
      icon: Icons.tips_and_updates,
      content: <FeatureListSection>[
        FeatureListSection(
          heading: 'Practical Guides',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'smart-packing',
              title: 'Smart Packing for Multi-Climate Trips',
              subtitle: 'Checklists • Gear • Hacks',
              detail:
                  'Layer with merino essentials, compress bulk, and build modular outfits adaptable to any climate.',
            ),
            FeatureListEntry(
              id: 'airport-ninja',
              title: 'Airport Ninja Moves',
              subtitle: 'Boarding • Security • Lounges',
              detail:
                  'Leverage digital queues, lounge passes, and seat alerts to breeze from check-in to take-off.',
            ),
          ],
        ),
        FeatureListSection(
          heading: 'Mindful Travel',
          entries: <FeatureListEntry>[
            FeatureListEntry(
              id: 'slow-travel',
              title: 'What Slow Travel Actually Means',
              subtitle: 'Community • Culture • Connection',
              detail:
                  'Build longer stays, learn local phrases, and contribute to community-led experiences.',
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<LocationSelection?> locationState = ref.watch(
      locationControllerProvider,
    );
    final LocationSelection? selection = locationState.valueOrNull;
    const List<MockTrip> upcomingTrips = <MockTrip>[
      MockTrip(
        title: 'Spring Escape',
        location: 'Kyoto, Japan',
        dateRange: 'Apr 12 – Apr 18',
      ),
      MockTrip(
        title: 'Mediterranean Cruise',
        location: 'Santorini, Greece',
        dateRange: 'Jun 02 – Jun 10',
      ),
    ];
    const List<MockInsight> travelInsights = <MockInsight>[
      MockInsight(
        title: 'Packing smarter for long-haul adventures',
        readTime: '3 min read',
      ),
      MockInsight(
        title: 'Navigating local transit like a pro',
        readTime: '4 min read',
      ),
      MockInsight(
        title: 'Budgeting tips for food lovers abroad',
        readTime: '6 min read',
      ),
    ];
    final String greetingSubtitle = selection == null
        ? 'Set your travel home base to unlock tailored guides.'
        : 'Exploring ideas for ${selection.city}, ${selection.country}.';
    final String bannerTitle = selection == null
        ? 'Welcome to ${F.title}'
        : 'Welcome to ${selection.city}';
    final String aboutLabel = selection?.city == null
        ? 'About this destination'
        : 'About ${selection?.city}';
    final Map<String, IconData> cityContext = <String, IconData>{
      'The city': Icons.location_city,
      'History': Icons.history_edu,
      'Etymology': Icons.translate,
      'Geography': Icons.map_outlined,
      'Cityscape': Icons.apartment,
      'Economy': Icons.trending_up,
    };
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        onPressed: () => showQuickPlannerSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Plan trip'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              WelcomeBanner(
                imageUrl:
                    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
                title: bannerTitle,
                subtitle: greetingSubtitle,
              ),
              const SizedBox(height: 24),
              Text(
                aboutLabel,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              CityContextGrid(
                items: cityContext.entries
                    .map(
                      (MapEntry<String, IconData> entry) => CityContextItem(
                        label: entry.key,
                        icon: entry.value,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => CityDetailPage(
                              category: entry.key,
                              city: selection?.city,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              Text(
                'Explore Features',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 4 / 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  for (final HomeFeature feature in _homeFeatures)
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
              Text(
                'Plan Ahead',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              PlanAheadSection(trips: upcomingTrips),
              const SizedBox(height: 12),
              Text(
                'Travel Insights',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TravelInsightsSection(insights: travelInsights),
            ],
          ),
        ),
      ),
    );
  }
}
