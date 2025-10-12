import 'package:flutter/material.dart';

class MockInsight {
  const MockInsight({
    required this.title,
    required this.readTime,
  });

  final String title;
  final String readTime;
}

class TravelInsightsSection extends StatelessWidget {
  const TravelInsightsSection({
    super.key,
    required this.insights,
  });

  final List<MockInsight> insights;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: insights
          .map(
            (MockInsight insight) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _MockInsightCard(insight: insight),
            ),
          )
          .toList(),
    );
  }
}

class _MockInsightCard extends StatelessWidget {
  const _MockInsightCard({required this.insight});

  final MockInsight insight;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.lightbulb,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  insight.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  insight.readTime,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
