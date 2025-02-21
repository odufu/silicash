import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color lightCardColor;
  final Color darkCardColor;

  const AppThemeExtension({
    required this.lightCardColor,
    required this.darkCardColor,
  });

  /// Returns the appropriate card color based on the theme context
  Color cardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardColor
        : lightCardColor;
  }

  @override
  ThemeExtension<AppThemeExtension> copyWith(
      {Color? lightCardColor, Color? darkCardColor}) {
    return AppThemeExtension(
      lightCardColor: lightCardColor ?? this.lightCardColor,
      darkCardColor: darkCardColor ?? this.darkCardColor,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
      ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;

    return AppThemeExtension(
      lightCardColor: Color.lerp(lightCardColor, other.lightCardColor, t)!,
      darkCardColor: Color.lerp(darkCardColor, other.darkCardColor, t)!,
    );
  }
}
