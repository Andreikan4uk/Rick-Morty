import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/local/prefs/prefs.dart';
import 'package:rick_and_morty/ui/bloc/theme_bloc/theme_bloc.dart';
import 'package:rick_and_morty/ui/theme/app_theme.dart';
import 'package:rick_and_morty/ui/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefsProvider = PrefsProvider();
  final isDark = await prefsProvider.getIsDark();

  runApp(
    BlocProvider(
      create: (_) => ThemeBloc(
        initialMode: isDark ? ThemeMode.dark : ThemeMode.light,
        prefs: prefsProvider,
      ),
      child: const MyApp(),
    ),
  );
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
