import 'package:rick_and_morty/domain/models/card_model.dart';

abstract class ILocalDataSource {
  Future<List<CardModel>> getCards();
  Future<void> insertCards(List<CardModel> cards);
  Future<void> addToFavorites(CardModel card);
  Future<void> removeFromFavorites(int id);
  Future<List<CardModel>> getFavorites();
  Future<bool> isFavorite(int id);
}
