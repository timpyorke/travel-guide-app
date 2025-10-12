import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_guide/widgets/feature_card.dart';
import 'package:travel_guide/widgets/plan_ahead_section.dart';
import 'package:travel_guide/widgets/quick_planner_sheet.dart';
import 'package:travel_guide/widgets/travel_insights_section.dart';

import '../location/models/location_selection.dart';
import '../location/providers/location_controller.dart';
import '../../flavors.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
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
              Text(
                'Welcome to ${F.title}',
                style: Theme.of(
                  context,
                )
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                greetingSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 4 / 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
              const SizedBox(height: 32),
              Text(
                'Plan Ahead',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              PlanAheadSection(trips: upcomingTrips),
              const SizedBox(height: 32),
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
