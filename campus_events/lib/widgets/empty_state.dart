import 'package:flutter/material.dart';

/// One empty-state widget for every tab and screen (R23):
/// icon, message and an optional button.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Local copies promote to non-null, so no `!` is needed (R6).
    final label = actionLabel;
    final onTap = onAction;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            if (label != null && onTap != null) ...[
              const SizedBox(height: 16),
              FilledButton.tonal(onPressed: onTap, child: Text(label)),
            ],
          ],
        ),
      ),
    );
  }
}
