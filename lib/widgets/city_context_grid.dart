import 'package:flutter/material.dart';

class CityContextItem {
  const CityContextItem({
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
}

class CityContextGrid extends StatelessWidget {
  const CityContextGrid({super.key, required this.items});

  final List<CityContextItem> items;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 5 / 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: items
          .map(
            (CityContextItem item) => Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: item.onTap,
                child: Ink(
                  decoration: BoxDecoration(
                    color: colors.primaryContainer.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: colors.primary.withOpacity(0.15),
                        child:
                            Icon(item.icon, size: 18, color: colors.primary),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          item.label,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
