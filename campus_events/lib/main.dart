import 'package:flutter/material.dart';

import 'data/seed.dart';
import 'models/event.dart';
import 'screens/events_tab.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Events',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      home: const _Preview(),
    );
  }
}

/// TEMPORARY home for step 2: holds the list the way the shell will
/// in step 3. Replaced by the NavigationBar shell.
class _Preview extends StatefulWidget {
  const _Preview();

  @override
  State<_Preview> createState() => _PreviewState();
}

class _PreviewState extends State<_Preview> {
  late List<Event> _events = buildSeed(DateTime.now());

  void _toggleFavourite(Event event) {
    setState(() {
      _events = [
        for (final e in _events)
          e.id == event.id ? e.copyWith(favourite: !e.favourite) : e,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Events')),
      body: EventsTab(
        events: _events,
        onToggleFavourite: _toggleFavourite,
        onOpen: (event) {},
      ),
    );
  }
}
