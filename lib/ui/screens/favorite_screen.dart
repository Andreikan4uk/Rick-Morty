import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/favorite/favorites_bloc_bloc.dart';
import 'package:rick_and_morty/ui/widgets/character_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final sortedFavorites = List.of(state.favorites)..sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
          return CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.favorites.length,
                  (context, int index) => CharacterCard(
                    isFavorite: true,
                    card: sortedFavorites[index],
                    onPressed: () {
                      context.read<FavoritesBloc>().add(FavoritesEvent.removeFavorites(id: state.favorites[index].id));
                    },
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
              ),
            ],
          );
        },
      ),
    );
  }
}
