import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/theme/theme_bloc.dart';
import 'package:rick_and_morty/theme/app_theme.dart';
import 'package:rick_and_morty/ui/screens/home_screen.dart';

void main() {
  runApp(BlocProvider(create: (context) => ThemeBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          home: HomeScreen(),
          theme: AppTheme.light(),
          themeMode: state.themeMode,
          darkTheme: AppTheme.dark(),
        );
      },
    );
  }
}
