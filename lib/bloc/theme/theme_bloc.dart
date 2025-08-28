import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<_LoadTheme>(_loadTheme);
    on<_ToggleTheme>(_toggleTheme);
  }

  Future _loadTheme(_LoadTheme event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeState(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> _toggleTheme(_ToggleTheme event, Emitter<ThemeState> emit) async {
    final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', newMode == ThemeMode.dark);
    emit(ThemeState(newMode));
  }
}
