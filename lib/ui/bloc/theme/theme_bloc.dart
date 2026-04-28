import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required ThemeMode initialMode}) : super(ThemeState.initial(initialMode)) {
    on<_ToggleTheme>(_toggleTheme);
  }

  Future<void> _toggleTheme(_ToggleTheme event, Emitter<ThemeState> emit) async {
    final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', newMode == ThemeMode.dark);
    emit(ThemeState(newMode));
  }
}
