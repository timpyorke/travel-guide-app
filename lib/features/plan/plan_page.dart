import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/plan_hero_banner.dart';
import 'package:travel_guide/widgets/trip_timeline.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  static const List<TimelineEntry> _initialEntries = <TimelineEntry>[
    TimelineEntry(
      day: 'Day 1',
      time: '08:30',
      title: 'Morning Arrival • Kyoto Station',
      description:
          'Drop luggage at the hotel and grab a matcha latte at Kissa Sai.',
    ),
    TimelineEntry(
      day: 'Day 1',
      time: '11:00',
      title: 'Stroll Through Arashiyama',
      description:
          'Walk the bamboo grove, then visit Tenryu-ji Temple gardens.',
    ),
    TimelineEntry(
      day: 'Day 1',
      time: '18:30',
      title: 'Kaiseki Dinner',
      description:
          'Seasonal tasting menu at a traditional ryokan near the river.',
    ),
    TimelineEntry(
      day: 'Day 2',
      time: '09:00',
      title: 'Fushimi Inari Hike',
      description:
          'Early start to climb the torii-lined path before the crowds.',
    ),
    TimelineEntry(
      day: 'Day 2',
      time: '15:30',
      title: 'Tea Ceremony Workshop',
      description:
          'Hands-on lesson in a machiya townhouse with local tea masters.',
    ),
  ];

  late final List<TimelineEntry> _timelineEntries = List<TimelineEntry>.from(
    _initialEntries,
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        children: <Widget>[
          PlanHeroBanner(
            title: 'Kyoto Spring Escape',
            subtitle: '2 days, 6 highlights, cherry blossom season',
            tags: const <PlanBannerTag>[
              PlanBannerTag(icon: Icons.local_florist, label: 'Sakura'),
              PlanBannerTag(icon: Icons.directions_walk, label: 'Scenic'),
              PlanBannerTag(icon: Icons.restaurant, label: 'Foodie'),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Timeline',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          TripTimeline(
            entries: _timelineEntries,
            onEntryTap: _handlePreviewTimelineEntry,
            onEntryLongPress: _handleEditTimelineEntry,
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: _handleAddTimelineEntry,
            icon: const Icon(Icons.add),
            label: const Text('Add timeline item'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddTimelineEntry() async {
    final TimelineEntry? newEntry = await _openTimelineEditor();
    if (newEntry == null) {
      return;
    }
    setState(() {
      _timelineEntries.add(newEntry);
    });
  }

  Future<void> _handlePreviewTimelineEntry(
    int index,
    TimelineEntry entry,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.title,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${entry.day} • ${entry.time}',
                      style: Theme.of(sheetContext).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                entry.description,
                style: Theme.of(sheetContext).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  _handleEditTimelineEntry(index, entry);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit entry'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleEditTimelineEntry(int index, TimelineEntry entry) async {
    final TimelineEntry? updatedEntry = await _openTimelineEditor(
      initial: entry,
    );
    if (updatedEntry == null) {
      return;
    }
    setState(() {
      _timelineEntries[index] = updatedEntry;
    });
  }

  Future<TimelineEntry?> _openTimelineEditor({TimelineEntry? initial}) {
    final bool isEditing = initial != null;
    final TextEditingController dayController = TextEditingController(
      text: initial?.day ?? 'Day ${_timelineEntries.length + 1}',
    );
    final TextEditingController timeController = TextEditingController(
      text: initial?.time ?? '09:00',
    );
    final TextEditingController titleController = TextEditingController(
      text: initial?.title ?? '',
    );
    final TextEditingController descriptionController = TextEditingController(
      text: initial?.description ?? '',
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showModalBottomSheet<TimelineEntry>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        final EdgeInsets viewInsets = MediaQuery.of(sheetContext).viewInsets;
        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets.bottom),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isEditing ? 'Edit timeline item' : 'Add timeline item',
                    style: Theme.of(sheetContext).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: dayController,
                    decoration: const InputDecoration(
                      labelText: 'Day',
                      border: OutlineInputBorder(),
                    ),
                    validator: _requiredFieldValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: timeController,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      hintText: 'e.g. 08:30',
                      border: OutlineInputBorder(),
                    ),
                    validator: _requiredFieldValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: _requiredFieldValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: _requiredFieldValidator,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            final bool isValid =
                                formKey.currentState?.validate() ?? false;
                            if (!isValid) {
                              return;
                            }
                            Navigator.of(sheetContext).pop(
                              TimelineEntry(
                                day: dayController.text.trim(),
                                time: timeController.text.trim(),
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                              ),
                            );
                          },
                          child: Text(isEditing ? 'Save changes' : 'Add item'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? _requiredFieldValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}
