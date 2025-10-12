import 'package:flutter/material.dart';

Future<void> showQuickPlannerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (BuildContext sheetContext) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController) {
          return QuickPlannerSheet(scrollController: scrollController);
        },
      );
    },
  );
}

class QuickPlannerSheet extends StatelessWidget {
  const QuickPlannerSheet({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? _) {
        if (didPop) {
          return;
        }
        _confirmDismiss(context).then((bool shouldClose) {
          if (shouldClose && context.mounted) {
            Navigator.of(context).pop();
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          children: <Widget>[
            Text(
              'Quick Travel Planner',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              'Kickstart a new itinerary by picking a template below.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            const _QuickPlannerChipList(),
            const SizedBox(height: 24),
            TextField(
              minLines: 1,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Trip description',
                hintText: 'Describe your travel vibe or must-see spots…',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Start planning'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDismiss(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Discard planner?'),
              content: const Text(
                'If you close now, the details you entered will be lost.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Keep editing'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: const Text('Discard'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

class _QuickPlannerChipList extends StatelessWidget {
  const _QuickPlannerChipList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const <Widget>[
        _QuickPlannerChip(icon: Icons.flight_takeoff, label: 'Weekend getaway'),
        _QuickPlannerChip(icon: Icons.hiking, label: 'Outdoor adventure'),
        _QuickPlannerChip(icon: Icons.restaurant_menu, label: 'Foodie crawl'),
      ],
    );
  }
}

class _QuickPlannerChip extends StatelessWidget {
  const _QuickPlannerChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onSelected: (_) {},
      showCheckmark: false,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
