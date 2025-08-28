import 'package:rick_and_morty/domain/models/card_model.dart';

abstract class IHomeRepository {
  Future<List<CardModel>> loadCards({int page});
}
