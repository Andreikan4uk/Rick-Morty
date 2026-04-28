part of 'theme_bloc.dart';

class ThemeState with EquatableMixin {
  final ThemeMode themeMode;
  ThemeState(this.themeMode);

  factory ThemeState.initial([ThemeMode mode = ThemeMode.light]) => ThemeState(mode);

  @override
  List<Object> get props => [themeMode];
}
