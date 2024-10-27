import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:movie_night_tcc/src/shared/widgets/movie_rating.dart";

class MoviePoster extends StatelessWidget {
  final String imageUrl;
  final double rating;

  const MoviePoster({
    required this.imageUrl,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: 92,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (_, __) => const Placeholder(),
            errorWidget: (_, __, ___) => const Placeholder(),
          ),
          const SizedBox(width: 2),
          Positioned(
            right: 5,
            bottom: 8,
            child: MovieRating(rating: rating),
          ),
        ],
      ),
    );
  }
}
