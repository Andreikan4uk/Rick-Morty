import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/bloc/home/home_bloc.dart';
import 'package:rick_and_morty/domain/bloc/favorite/favorites_bloc_bloc.dart';
import 'package:rick_and_morty/ui/widgets/character_card.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      final state = context.read<HomeBloc>().state;

      if (maxScroll - currentScroll >= 300 && state.canLoadMore && !state.isLoadingMore) {
        context.read<HomeBloc>().add(HomeEvent.loadMoreCards());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => context.read<HomeBloc>().add(HomeEvent.refresh()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final favoritesState = context.watch<FavoritesBloc>().state;
            return state.isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.cards.length,
                          (context, int index) => CharacterCard(
                            isFavorite: favoritesState.favorites.any((fav) => fav.id == state.cards[index].id),
                            card: state.cards[index],
                            onPressed: () {
                              final isFavorite = favoritesState.favorites.any((fav) => fav.id == state.cards[index].id);
                              debugPrint(state.cards[index].toString());
                              if (!isFavorite) {
                                context.read<FavoritesBloc>().add(
                                  FavoritesEvent.addFavorites(card: state.cards[index]),
                                );
                              } else {
                                context.read<FavoritesBloc>().add(
                                  FavoritesEvent.removeFavorites(id: state.cards[index].id),
                                );
                              }
                            },
                          ),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: state.isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
