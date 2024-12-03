import "package:flutter/material.dart";
import "package:movie_night_tcc/src/lib_feature/home/widgets/movie_rating.dart";
import "package:movie_night_tcc/src/shared/components/ui_image.dart";

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
          UIImage(imageUrl: imageUrl),
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
