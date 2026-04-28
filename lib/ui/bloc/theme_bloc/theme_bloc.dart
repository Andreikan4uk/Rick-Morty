import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/local/prefs/i_prefs.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final IPrefsDataSource _prefs;

  ThemeBloc({required ThemeMode initialMode, required IPrefsDataSource prefs})
    : _prefs = prefs,
      super(ThemeState.initial(initialMode)) {
    on<_ToggleTheme>(_toggleTheme);
  }

  Future<void> _toggleTheme(_ToggleTheme event, Emitter<ThemeState> emit) async {
    final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _prefs.saveIsDark(newMode == ThemeMode.dark);
    emit(ThemeState(newMode));
  }
}
