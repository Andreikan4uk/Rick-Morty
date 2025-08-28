import 'package:flutter/material.dart';
import 'package:rick_and_morty/bloc/favorite/favorites_bloc_bloc.dart';
import 'package:rick_and_morty/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/theme/theme_bloc.dart';
import 'package:rick_and_morty/domain/repository/home_repository.dart';
import 'package:rick_and_morty/ui/screens/card_screen.dart';
import 'package:rick_and_morty/ui/screens/favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => HomeBloc(HomeRepository())..add(HomeEvent.loadCards())),
        BlocProvider<FavoritesBloc>(create: (_) => FavoritesBloc()..add(FavoritesEvent.loadFavorites())),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 25),
            child: Switch(
              value: context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark,
              onChanged: (_) {
                context.read<ThemeBloc>().add(ThemeEvent.loggleTheme());
              },
            ),
          ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Ваш блок (HomeBloc) и стейт (HomeState)
// // Предположим, HomeState имеет свойство currentIndex

// class HomeState {
//   final int currentIndex;

//   HomeState({required this.currentIndex});

//   HomeState copyWith({int? currentIndex}) {
//     return HomeState(currentIndex: currentIndex ?? this.currentIndex);
//   }
// }

// class HomeBloc extends Cubit<HomeState> {
//   HomeBloc() : super(HomeState(currentIndex: 0));

//   void changePage(int index) {
//     emit(state.copyWith(currentIndex: index));
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeBloc(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('BottomNavigationBar Example')),
//         body: Center(
//           child: BlocBuilder<HomeBloc, HomeState>(
//             builder: (context, state) {
//               // Отображение контента на основе state.currentIndex
//               return Text('Current index: ${state.currentIndex}');
//             },
//           ),
//         ),
//         bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
//           builder: (context, state) {
//             return BottomNavigationBar(
//               currentIndex: state.currentIndex,
//               onTap: (index) {
//                 context.read<HomeBloc>().changePage(index);
//               },
//               items: const [
//                 BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//                 BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//                 BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
