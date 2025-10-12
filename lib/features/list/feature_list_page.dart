import 'package:flutter/material.dart';

import '../home/models/home_feature.dart';
import '../detail/feature_detail_page.dart';

class FeatureListPage extends StatelessWidget {
  const FeatureListPage({
    super.key,
    required this.feature,
  });

  final HomeFeature feature;

  @override
  Widget build(BuildContext context) {
    final List<_RenderableRow> rows = _buildRenderableRows(feature);
    return Scaffold(
      appBar: AppBar(title: Text(feature.title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: rows.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          final _RenderableRow row = rows[index];
          return row.map(
            header: (String heading) => Text(
              heading,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            entry: (FeatureListEntry entry) => ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => FeatureDetailPage(
                    feature: feature,
                    entry: entry,
                  ),
                ),
              ),
              leading: entry.thumbnail == null
                  ? CircleAvatar(
                      child: Icon(feature.icon),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        entry.thumbnail!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
              title: Text(entry.title),
              subtitle: Text(entry.subtitle),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }

  List<_RenderableRow> _buildRenderableRows(HomeFeature feature) {
    final List<_RenderableRow> rows = <_RenderableRow>[];
    for (final FeatureListSection section in feature.content) {
      rows.add(_HeaderRow(section.heading));
      rows.addAll(
        section.entries.map<_RenderableRow>(_EntryRow.new),
      );
    }
    return rows;
  }
}

sealed class _RenderableRow {
  const _RenderableRow();

  T map<T>({
    required T Function(String heading) header,
    required T Function(FeatureListEntry entry) entry,
  });
}

class _HeaderRow extends _RenderableRow {
  const _HeaderRow(this.heading);

  final String heading;

  @override
  T map<T>({
    required T Function(String heading) header,
    required T Function(FeatureListEntry entry) entry,
  }) {
    return header(heading);
  }
}

class _EntryRow extends _RenderableRow {
  const _EntryRow(this.entry);

  final FeatureListEntry entry;

  @override
  T map<T>({
    required T Function(String heading) header,
    required T Function(FeatureListEntry entry) entry,
  }) {
    return entry(this.entry);
  }
}
