part of 'theme_bloc.dart';

class ThemeState with EquatableMixin {
  final ThemeMode themeMode;
  ThemeState(this.themeMode);

  factory ThemeState.initial() => ThemeState(ThemeMode.light);

  @override
  List<Object> get props => [themeMode];
}
