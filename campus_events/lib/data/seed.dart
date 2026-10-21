import '../models/event.dart';
import '../models/event_category.dart';

List<String> _people(int n) => List.generate(n, (i) => 'Student ${i + 1}');

/// Twelve seed events, dates relative to [now].
/// Mandatory five: 60-char title (#1), at limit (#2), past (#3),
/// online (#4), no description (#5).
List<Event> buildSeed(DateTime now) {
  DateTime at(int days, int hour, [int minute = 0]) =>
      DateTime(now.year, now.month, now.day + days, hour, minute);

  return [
    Event(
      id: 'e1',
      title: 'Flutter Hackathon: Build, Break and Ship an App in 24 Hours!',
      category: EventCategory.tech,
      starts: at(3, 10),
      capacity: 40,
      place: 'Lab 301, Block B',
      attendees: _people(36), // 4 left -> "4 left" badge
      description: 'Teams of four, one weekend, one working mobile app.',
    ),
    Event(
      id: 'e2',
      title: 'Chess Tournament',
      category: EventCategory.sport,
      starts: at(2, 15),
      capacity: 8,
      place: 'Student Hall',
      attendees: _people(8), // at the limit -> "FULL"
      description: 'Swiss system, five rounds.',
    ),
    Event(
      id: 'e3',
      title: 'Open Mic Night',
      category: EventCategory.music,
      starts: at(-2, 18),
      capacity: 30,
      place: 'Campus Cafe',
      attendees: _people(22), // past
      description: 'Bring an instrument or just your voice.',
    ),
    Event(
      id: 'e4',
      title: 'Career Q&A with Alumni',
      category: EventCategory.career,
      starts: at(5, 17),
      capacity: 100,
      online: true, // place is a link
      place: 'https://meet.example.com/alumni',
      attendees: _people(41),
      description: 'Five alumni answer your questions live.',
    ),
    Event(
      id: 'e5',
      title: 'Photo Walk',
      category: EventCategory.art,
      starts: at(1, 9, 30),
      capacity: 15,
      place: 'Main Gate',
      attendees: _people(6), // no description
    ),
    Event(
      id: 'e6',
      title: 'Morning Run 5K',
      category: EventCategory.sport,
      starts: at(4, 7),
      capacity: 25,
      place: 'Stadium',
      attendees: _people(20), // 5 left
      description: 'Easy pace, all levels.',
    ),
    Event(
      id: 'e7',
      title: 'Intro to Git Workshop',
      category: EventCategory.tech,
      starts: at(6, 14),
      capacity: 50,
      online: true,
      place: 'https://meet.example.com/git',
      attendees: _people(12),
    ),
    Event(
      id: 'e8',
      title: 'Jazz Evening',
      category: EventCategory.music,
      starts: at(8, 19),
      capacity: 60,
      place: 'Concert Hall',
      attendees: _people(33),
      description: 'Live quartet from the music department.',
    ),
    Event(
      id: 'e9',
      title: 'Poster Design Meetup',
      category: EventCategory.art,
      starts: at(-5, 16),
      capacity: 20,
      place: 'Studio 2',
      attendees: _people(9), // past
    ),
    Event(
      id: 'e10',
      title: 'CV Clinic',
      category: EventCategory.career,
      starts: at(10, 11),
      capacity: 12,
      place: 'Career Center',
      attendees: _people(11), // 1 left
      description: 'Bring a printed CV for a 10-minute review.',
    ),
    Event(
      id: 'e11',
      title: 'Basketball Pickup Game',
      category: EventCategory.sport,
      starts: at(0, 20),
      capacity: 20,
      place: 'Gym 1',
      attendees: _people(14),
    ),
    Event(
      id: 'e12',
      title: 'Board Games Night',
      category: EventCategory.art,
      starts: at(12, 18),
      capacity: 35,
      place: 'Library, 2nd floor',
      attendees: _people(3),
      description: 'Catan, Codenames and many more.',
    ),
  ];
}
