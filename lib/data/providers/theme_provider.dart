import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
// freezed package for generation of boilperplate code
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presetup/utilities/theme.dart';

// Import freezed file (maybe not yet generated)
part 'theme_provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({
    @Default(ThemeMode.light) ThemeMode mode,
  }) = _ThemeState;

  const ThemeState._();
}

// Creating state notifier provider
final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) => ThemeNotifier());

// Creating Notifier
class ThemeNotifier extends StateNotifier<ThemeState> {
  // Notifier constructor - call functions on provider initialization
  ThemeNotifier() : super(const ThemeState()) {
    //
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(mode: mode); // mode;
    FpTheme.saveThemeMode(mode);
  }
}
