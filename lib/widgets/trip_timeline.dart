import 'package:flutter/material.dart';

class TripTimeline extends StatelessWidget {
  const TripTimeline({
    super.key,
    required this.entries,
    this.onEntryTap,
    this.onEntryLongPress,
  });

  final List<TimelineEntry> entries;
  final void Function(int index, TimelineEntry entry)? onEntryTap;
  final void Function(int index, TimelineEntry entry)? onEntryLongPress;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      final ThemeData theme = Theme.of(context);
      final ColorScheme colorScheme = theme.colorScheme;
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'No timeline stops yet',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Use “Add timeline item” to start shaping your itinerary.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (BuildContext context, int index) {
        final TimelineEntry entry = entries[index];
        final bool isLast = index == entries.length - 1;
        return _TimelineTile(
          entry: entry,
          isLast: isLast,
          onTap: onEntryTap == null ? null : () => onEntryTap!(index, entry),
          onLongPress: onEntryLongPress == null
              ? null
              : () => onEntryLongPress!(index, entry),
        );
      },
    );
  }
}

class TimelineEntry {
  const TimelineEntry({
    required this.day,
    required this.time,
    required this.title,
    required this.description,
  });

  final String day;
  final String time;
  final String title;
  final String description;

  TimelineEntry copyWith({
    String? day,
    String? time,
    String? title,
    String? description,
  }) {
    return TimelineEntry(
      day: day ?? this.day,
      time: time ?? this.time,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.entry,
    required this.isLast,
    this.onTap,
    this.onLongPress,
  });

  final TimelineEntry entry;
  final bool isLast;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: 64,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.day,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  entry.time,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 24,
            child: Column(
              children: <Widget>[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colorScheme.primary.withOpacity(0.4),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Material(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTap,
                onLongPress: onLongPress,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        entry.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        entry.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
