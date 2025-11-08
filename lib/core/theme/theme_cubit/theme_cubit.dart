// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:non_stop/core/services/local_storage.dart';
// import 'package:non_stop/core/theme/dark_theme.dart';
// import 'package:non_stop/core/theme/light_theme.dart';
// import 'package:non_stop/core/theme/theme_cubit/theme_state.dart';
//
// /// 🧩 Handles the app's theme state (Light / Dark).
// ///
// /// This Cubit manages theme switching logic and provides
// /// the correct [ThemeData] to the application UI.
// ///
// /// Example usage:
// /// ```dart
// /// context.read<ThemeCubit>().toggleTheme();
// /// ```
// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(const ThemeState.light());
//
//
//   static const _themeKey = 'isDarkTheme';
//   final LocalStorageService _storage = LocalStorageService();
//
//   /// Initialize theme based on saved value.
//   Future<void> init() async {
//     await _storage.init();
//     final isDark = await _storage.get<bool>(_themeKey) ?? false;
//     emit(isDark ? const ThemeState.dark() : const ThemeState.light());
//   }
//
//   /// Toggles between light/dark and saves preference.
//   Future<void> toggleTheme() async {
//     final newIsDark = !state.isDark;
//     emit(newIsDark ? const ThemeState.dark() : const ThemeState.light());
//     await _storage.set<bool>(_themeKey, newIsDark);
//   }
//
//   /// Returns the currently active [ThemeData].
//   ThemeData get currentTheme =>
//       state.isDark ? DarkTheme.theme : LightTheme.theme;
// }
