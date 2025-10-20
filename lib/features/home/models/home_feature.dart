import 'package:flutter/material.dart';

class HomeFeature {
  const HomeFeature({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.content,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<FeatureListSection> content;
}

class FeatureListSection {
  const FeatureListSection({
    required this.heading,
    required this.entries,
  });

  final String heading;
  final List<FeatureListEntry> entries;
}

class FeatureListEntry {
  const FeatureListEntry({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.detail,
    this.thumbnail,
  });

  final String id;
  final String title;
  final String subtitle;
  final String detail;
  final String? thumbnail;
}
