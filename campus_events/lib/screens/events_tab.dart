import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/event_category.dart';
import '../widgets/empty_state.dart';
import '../widgets/event_card.dart';

/// Tab 1. The events come in as a parameter and changes go up as callbacks
/// (R10); only the view state (search, chips) lives here.
class EventsTab extends StatefulWidget {
  const EventsTab({
    super.key,
    required this.events,
    required this.onToggleFavourite,
    required this.onOpen,
  });

  final List<Event> events;
  final ValueChanged<Event> onToggleFavourite;
  final ValueChanged<Event> onOpen;

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  final _search = TextEditingController();
  String _query = '';
  EventCategory? _category; // null means "All"
  bool _showPast = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  /// R7: where() builds a new list, so sorting it never touches the state.
  /// Upcoming first by date, past items last.
  List<Event> get _visible {
    final q = _query.trim().toLowerCase();
    final result = widget.events
        .where(
          (e) =>
              (_category == null || e.category == _category) &&
              (_showPast || !e.isPast) &&
              (q.isEmpty || e.title.toLowerCase().contains(q)),
        )
        .toList();
    result.sort((a, b) {
      if (a.isPast != b.isPast) return a.isPast ? 1 : -1;
      return a.starts.compareTo(b.starts);
    });
    return result;
  }

  void _clearSearch() {
    _search.clear();
    setState(() {
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            controller: _search,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search events',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ),
        _buildChips(),
        Expanded(
          child: visible.isEmpty
              ? EmptyState(
                  icon: Icons.search_off,
                  message: 'No events match your filters',
                  actionLabel: _query.isEmpty ? null : 'Clear search',
                  onAction: _query.isEmpty ? null : _clearSearch,
                )
              // R20: the layout depends on the space we are given,
              // not on the screen size, hence LayoutBuilder.
              : LayoutBuilder(
                  builder: (context, constraints) => constraints.maxWidth >= 600
                      ? _buildGrid(visible)
                      : _buildList(visible),
                ),
        ),
      ],
    );
  }

  Widget _buildChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Past'),
            selected: _showPast,
            onSelected: (value) {
              setState(() {
                _showPast = value;
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('All'),
            selected: _category == null,
            onSelected: (_) {
              setState(() {
                _category = null;
              });
            },
          ),
          for (final c in EventCategory.values)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ChoiceChip(
                avatar: Icon(c.icon),
                label: Text(c.label),
                selected: _category == c,
                onSelected: (_) {
                  setState(() {
                    _category = c;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _card(Event event) {
    return EventCard(
      key: ValueKey(event.id),
      event: event,
      onTap: () => widget.onOpen(event),
      onToggleFavourite: () => widget.onToggleFavourite(event),
    );
  }

  Widget _buildList(List<Event> items) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _card(items[index]),
    );
  }

  Widget _buildGrid(List<Event> items) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360, // cells are never wider than 360 px
        mainAxisExtent: 112,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _card(items[index]),
    );
  }
}
