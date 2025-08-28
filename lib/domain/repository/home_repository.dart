import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/domain/models/card_model.dart';
import 'package:rick_and_morty/data/dto/card_dto.dart';
import 'package:rick_and_morty/domain/repository/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final String _baseUrl = '''https://rickandmortyapi.com/api''';

  @override
  Future<List<CardModel>> loadCards({int page = 1}) async {
    try {
      final url = Uri.parse("$_baseUrl/character?page=$page");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final cards = CardDto.listFromJson(data);
        return cards.map((dto) => dto.toDomain()).toList();
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка сети или парсинга: $e');
    }
  }
}
