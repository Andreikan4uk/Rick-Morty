import 'package:equatable/equatable.dart';

class CardModel with EquatableMixin {
  final String? imageUrl;
  final int id;
  final String? name;
  final String? status;
  final String? species;
  final String? gender;

  const CardModel({this.imageUrl, required this.id, this.name, this.status, this.species, this.gender});

  CardModel copyWith({String? imageUrl, int? id, String? name, String? status, String? species, String? gender}) {
    return CardModel(
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'status': status, 'species': species, 'gender': gender, 'image': imageUrl};
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      gender: map['gender'],
      imageUrl: map['image'],
    );
  }

  @override
  List<Object?> get props => [imageUrl, id, name, status, species, gender];
}
