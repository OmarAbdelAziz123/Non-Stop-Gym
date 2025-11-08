import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Route<T> route) => Navigator.of(this).push(route);

  Size get screenSize => MediaQuery.of(this).size;
  double get height => screenSize.height;
  double get width => screenSize.width;

  void unfocus() => FocusScope.of(this).unfocus();

  void showSnack(String message, {Color? color}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
