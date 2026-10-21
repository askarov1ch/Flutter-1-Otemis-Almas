import 'package:flutter/material.dart';

/// The only colour literal in lib/: the seed that ColorScheme.fromSeed
/// derives the whole palette from (R22). Everything else uses colorScheme roles.
const _seed = Color(0xFF3F51B5);

ThemeData buildTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: brightness),
  );
}
