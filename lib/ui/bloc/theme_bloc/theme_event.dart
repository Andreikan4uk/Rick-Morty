part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();

  factory ThemeEvent.loggleTheme() = _ToggleTheme;
}

class _ToggleTheme extends ThemeEvent {
  const _ToggleTheme();
}
