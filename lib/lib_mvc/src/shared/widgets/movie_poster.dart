import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/lib_mvc/src/shared/app_colors.dart";
import "package:movie_night_tcc/lib_mvc/src/shared/app_fonts.dart";

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
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CachedNetworkImage(imageUrl: imageUrl),
        const SizedBox(width: 2),
        Positioned(
          right: 5,
          bottom: 8,
          child: _MovieRating(rating: rating),
        ),
      ],
    );
  }
}

class _MovieRating extends StatelessWidget {
  final double rating;

  const _MovieRating({required this.rating});

  String get _rating => rating.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(
          side: BorderSide.none,
        ),
        color: Colors.black.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          children: [
            Assets.lib.assets.icStar.svg(
              width: 10,
              height: 10,
              colorFilter:
                  const ColorFilter.mode(AppColors.yellow, BlendMode.srcIn),
            ),
            const SizedBox(width: 4),
            Text(
              _rating,
              style: AppFonts.robotoTextSmallerBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
