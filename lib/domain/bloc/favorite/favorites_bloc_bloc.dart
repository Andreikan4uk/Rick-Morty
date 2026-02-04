import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/db/db.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';

part 'favorites_bloc_event.dart';
part 'favorites_bloc_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState.initial()) {
    on<_LoadFavorites>(_loadFavorites);
    on<_AddFavorites>(_addFavorites);
    on<_RemoveFavorites>(_removeFavorites);
    add(_LoadFavorites());
  }

  Future _loadFavorites(_LoadFavorites event, Emitter<FavoritesState> emit) async {
    final cards = await DBProvider.db.getFavorites();
    emit(state.copyWith(favorites: cards));
  }

  Future _addFavorites(_AddFavorites event, Emitter<FavoritesState> emit) async {
    await DBProvider.db.addToFavorites(event.card);
    final updated = List<CardModel>.from(state.favorites)..add(event.card);
    emit(state.copyWith(favorites: updated));
  }

  Future _removeFavorites(_RemoveFavorites event, Emitter<FavoritesState> emit) async {
    await DBProvider.db.removeFromFavorites(event.id);
    final updated = state.favorites.where((card) => card.id != event.id).toList();
    emit(state.copyWith(favorites: updated));
  }
}
