import 'package:rick_and_morty/domain/models/card_model.dart';

class CardDto {
  final String? imageUrl;
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? gender;

  CardDto({this.imageUrl, this.id, this.name, this.status, this.species, this.gender});

  factory CardDto.fromJson(Map<String, dynamic> json) {
    return CardDto(
      imageUrl: json['image'] != null ? json['image'] as String? : null,
      id: json['id'] != null ? json['id'] as int? : null,
      name: json['name'] != null ? json['name'] as String? : null,
      status: json['status'] != null ? json['status'] as String? : null,
      species: json['species'] != null ? json['species'] as String? : null,
      gender: json['gender'] != null ? json['gender'] as String? : null,
    );
  }

  static List<CardDto> listFromJson(Map<String, dynamic> json) {
    final results = json['results'] as List<dynamic>? ?? [];
    return results.map((e) => CardDto.fromJson(e)).toList();
  }

  CardModel toDomain() {
    if (id == null) {
      throw Exception("CardDto.id is null");
    }
    return CardModel(imageUrl: imageUrl, id: id!, name: name, status: status, species: species, gender: gender);
  }
}
