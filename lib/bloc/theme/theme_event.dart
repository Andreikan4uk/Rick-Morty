part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();

  factory ThemeEvent.loadTheme() = _LoadTheme;

  factory ThemeEvent.loggleTheme() = _ToggleTheme;
}

class _LoadTheme extends ThemeEvent {
  const _LoadTheme();
}

class _ToggleTheme extends ThemeEvent {
  const _ToggleTheme();
}
