import 'package:flutter/material.dart';

import '../detail/feature_detail_page.dart';
import '../home/models/home_feature.dart';
import '../list/feature_list_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  static const HomeFeature _favoritesFeature = HomeFeature(
    id: 'saved-plans',
    title: 'Saved Plans',
    subtitle: 'Trips you want to revisit or book soon.',
    icon: Icons.favorite,
    content: <FeatureListSection>[
      FeatureListSection(
        heading: 'Getaways',
        entries: <FeatureListEntry>[
          FeatureListEntry(
            id: 'phuket-sun',
            title: 'Summer Escape to Phuket',
            subtitle: '5-day beach getaway • Added 2d ago',
            detail:
                'Sunrise yoga, island-hopping by longtail boat, and spa evenings right on the Andaman Sea.',
          ),
          FeatureListEntry(
            id: 'chiangmai-hike',
            title: 'Hiking Northern Thailand',
            subtitle: '3-day adventure • Added 1w ago',
            detail:
                'Jungle treks, hill-tribe homestays, and waterfall picnics north of Chiang Mai.',
          ),
        ],
      ),
      FeatureListSection(
        heading: 'Food & Culture',
        entries: <FeatureListEntry>[
          FeatureListEntry(
            id: 'bangkok-streetfood',
            title: 'Bangkok Street Food Tour',
            subtitle: 'Weekend foodie trip • Added 3w ago',
            detail:
                'Night market hop with a local guide, boat noodles, Chinatown desserts, and hidden speakeasies.',
          ),
          FeatureListEntry(
            id: 'lisbon-fado',
            title: 'Lisbon Fado Weekend',
            subtitle: 'Music + culinary pairing • Added 1m ago',
            detail:
                'Lisbon apartment stay, fado dinner experiences, and pastel de nata baking workshop.',
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final List<FeatureListEntry> entries =
        _favoritesFeature.content.expand((FeatureListSection section) {
      return section.entries;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Saved Plans',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => FeatureListPage(feature: _favoritesFeature),
                    ),
                  ),
                  icon: const Icon(Icons.menu_book),
                  label: const Text('View all'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (BuildContext context, int index) {
                  final FeatureListEntry entry = entries[index];
                  final Color cardColor = switch (index % 3) {
                    0 => colors.primaryContainer,
                    1 => colors.secondaryContainer,
                    _ => colors.tertiaryContainer,
                  };
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: colors.onPrimaryContainer.withOpacity(0.12),
                        child: Icon(_favoritesFeature.icon,
                            color: colors.onPrimaryContainer),
                      ),
                      title: Text(
                        entry.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(entry.subtitle),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => FeatureDetailPage(
                            feature: _favoritesFeature,
                            entry: entry,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
