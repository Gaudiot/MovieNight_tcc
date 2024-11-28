import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";

class MovieRating extends StatelessWidget {
  final double rating;

  const MovieRating({
    required this.rating,
    super.key,
  });

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
