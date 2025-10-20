import 'package:flutter/material.dart';

class MockTrip {
  const MockTrip({
    required this.title,
    required this.location,
    required this.dateRange,
  });

  final String title;
  final String location;
  final String dateRange;
}

class PlanAheadSection extends StatelessWidget {
  const PlanAheadSection({
    super.key,
    required this.trips,
  });

  final List<MockTrip> trips;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: trips.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        return _MockTripTile(trip: trips[index]);
      },
    );
  }
}

class _MockTripTile extends StatelessWidget {
  const _MockTripTile({required this.trip});

  final MockTrip trip;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          trip.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${trip.location} • ${trip.dateRange}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
