import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.card, required this.onPressed, this.isFavorite = false});
  final CardModel card;
  final VoidCallback onPressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        card.imageUrl != null
                            ? CachedNetworkImage(
                              imageUrl: card.imageUrl!,
                              placeholder: (context, url) => Placeholder(),
                              errorWidget: (context, url, error) => Placeholder(),
                              fit: BoxFit.cover,
                            )
                            : Placeholder(),
                  ),
                ),
                Text(card.name ?? ''),
                Text(card.gender ?? ''),
                Text(card.species ?? ''),
                Text(card.status ?? ''),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 10,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(isFavorite ? Icons.star : Icons.star_border, size: 35),
            color: Colors.purpleAccent,
          ),
        ),
      ],
    );
  }
}
