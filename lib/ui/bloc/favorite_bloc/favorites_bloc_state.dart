part of 'favorites_bloc_bloc.dart';

class FavoritesState with EquatableMixin {
  final List<CardModel> favorites;

  const FavoritesState({required this.favorites});

  factory FavoritesState.initial() => FavoritesState(favorites: []);

  FavoritesState copyWith({List<CardModel>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object> get props => [favorites];
}
