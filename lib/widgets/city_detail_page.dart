import 'package:flutter/material.dart';

class CityDetailPage extends StatelessWidget {
  const CityDetailPage({super.key, required this.category, this.city});

  final String category;
  final String? city;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String title = city == null ? category : '$category · $city';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          Text(
            category,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'We\'re preparing rich content for $category. Soon you\'ll find curated essays, multimedia, and guides tailored to your selected city.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Text(
            'In the meantime, explore other sections or personalize your home base to unlock more insights.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
