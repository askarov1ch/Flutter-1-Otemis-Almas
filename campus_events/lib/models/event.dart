// ignore_for_file: prefer_initializing_formals
import 'package:flutter/foundation.dart';

import 'event_category.dart';

@immutable
class Event {
  const Event({
    required this.id,
    required this.title,
    required this.category,
    required this.starts,
    required this.capacity,
    required this.place,
    List<String> attendees = const [],
    this.online = false,
    this.description,
    this.favourite = false,
  }) : _attendees = attendees;
  factory Event.empty() {
    final now = DateTime.now();
    return Event(
      id: now.microsecondsSinceEpoch.toString(),
      title: '',
      category: EventCategory.tech,
      starts: DateTime(now.year, now.month, now.day + 1, 10),
      capacity: 30,
      place: '',
    );
  }

  final String id;
  final String title;
  final EventCategory category;
  final DateTime starts;
  final int capacity;

  /// A room when [online] is false, a link when it is true.
  final String place;
  final bool online;
  final String? description;
  final bool favourite;

  final List<String> _attendees;

  /// Read-only view: nobody can mutate the state from outside (R1).
  List<String> get attendees => List.unmodifiable(_attendees);

  // ---- derived values: getters, never fields (R4) ----
  int get count => _attendees.length;
  int get free => capacity - count;
  bool get isFull => free <= 0;
  bool get isPast => starts.isBefore(DateTime.now());
  bool contains(String name) => _attendees.contains(name);

  /// Record getter (R5): destructure where shown,
  /// e.g. `final (:taken, :free) = event.places;`
  ({int taken, int free}) get places => (taken: count, free: free);

  Event copyWith({
    String? title,
    EventCategory? category,
    DateTime? starts,
    int? capacity,
    String? place,
    List<String>? attendees,
    bool? online,
    String? description,
    bool clearDescription = false,
    bool? favourite,
  }) {
    return Event(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      starts: starts ?? this.starts,
      capacity: capacity ?? this.capacity,
      place: place ?? this.place,
      attendees: List.of(attendees ?? _attendees),
      online: online ?? this.online,
      description: clearDescription ? null : (description ?? this.description),
      favourite: favourite ?? this.favourite,
    );
  }
}
