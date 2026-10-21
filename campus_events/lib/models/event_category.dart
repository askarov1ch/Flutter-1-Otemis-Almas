import 'package:flutter/material.dart';

/// Enhanced enum: every value carries its label and icon (R2).
enum EventCategory {
  tech('Tech', Icons.computer),
  sport('Sport', Icons.sports_soccer),
  music('Music', Icons.music_note),
  art('Art', Icons.palette),
  career('Career', Icons.work);

  const EventCategory(this.label, this.icon);

  final String label;
  final IconData icon;

  /// Exhaustive switch expression: adding a value breaks the build
  /// until it gets a colour. Returns a colorScheme role, never a literal.
  Color color(ColorScheme scheme) => switch (this) {
    EventCategory.tech => scheme.primary,
    EventCategory.sport => scheme.secondary,
    EventCategory.music => scheme.tertiary,
    EventCategory.art => scheme.error,
    EventCategory.career => scheme.outline,
  };
}
