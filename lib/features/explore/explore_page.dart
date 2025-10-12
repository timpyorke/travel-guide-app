import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemBuilder: (BuildContext context, int index) {
          final int day = index + 1;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            tileColor: Theme.of(context).colorScheme.surfaceVariant,
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                '$day',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            title: Text('Destination Highlight $day'),
            subtitle: const Text('Discover hidden gems, scenic spots, and local favorites.'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
        itemCount: 6,
      ),
    );
  }
}
