part of 'favorites_bloc_bloc.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();

  factory FavoritesEvent.loadFavorites() = _LoadFavorites;

  factory FavoritesEvent.addFavorites({required CardModel card}) = _AddFavorites;

  factory FavoritesEvent.removeFavorites({required int id}) = _RemoveFavorites;
}

class _LoadFavorites extends FavoritesEvent {
  const _LoadFavorites();
}

class _AddFavorites extends FavoritesEvent {
  final CardModel card;
  const _AddFavorites({required this.card});
}

class _RemoveFavorites extends FavoritesEvent {
  final int id;
  const _RemoveFavorites({required this.id});
}
