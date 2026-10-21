/// Sealed hierarchy (R9): the compiler forces every `switch` to handle
/// all three states.
sealed class Countdown {
  const Countdown();

  /// How long an event is considered "running" after its start.
  static const eventLength = Duration(hours: 3);

  factory Countdown.of(DateTime starts, DateTime now) {
    final diff = starts.difference(now);
    if (!diff.isNegative) return Upcoming(diff);
    final since = -diff;
    if (since < eventLength) return Started(since);
    return const Ended();
  }
}

final class Upcoming extends Countdown {
  const Upcoming(this.left);
  final Duration left;
}

final class Started extends Countdown {
  const Started(this.since);
  final Duration since;
}

final class Ended extends Countdown {
  const Ended();
}
