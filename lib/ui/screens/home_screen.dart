import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/bloc/favorite/favorites_bloc_bloc.dart';
import 'package:rick_and_morty/domain/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/bloc/theme/theme_bloc.dart';
import 'package:rick_and_morty/domain/db/db.dart';
import 'package:rick_and_morty/domain/repository/home_repository.dart';
import 'package:rick_and_morty/ui/screens/card_screen.dart';
import 'package:rick_and_morty/ui/screens/favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<HomeBloc>(create: (_) => HomeBloc(HomeRepository(), DBProvider.db)..add(HomeEvent.loadCards())),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc(HomeRepository(), DBProvider.db)),
        BlocProvider<FavoritesBloc>(create: (_) => FavoritesBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          // leading: Padding(
          //   padding: EdgeInsets.only(left: 25),
          //   child: Switch(
          //     value: context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark,
          //     onChanged: (_) {
          //       context.read<ThemeBloc>().add(ThemeEvent.loggleTheme());
          //     },
          //   ),
          // ),
          title: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Text(state.currentIndex == 0 ? 'CardsScreen' : 'FavoritesScreen');
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                debugPrint(index.toString());
                context.read<HomeBloc>().add(HomeEvent.changePage(index: index));
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
              ],
            );
          },
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final List<Widget> screens = [CardScreen(), FavoriteScreen()];
              return screens.elementAt(state.currentIndex);
            },
          ),
        ),
      ),
    );
  }
}
