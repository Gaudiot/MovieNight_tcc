import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/lib_mvvm/view/widgets/movie_rating.dart";
import "package:movie_night_tcc/src/shared/components/ui_button.dart";

class MovieBanner extends StatelessWidget {
  final String backdropUrl;
  final double rating;
  final bool isFavorite;

  final VoidCallback onRemove;
  final VoidCallback onToggleFavorite;

  const MovieBanner({
    required this.backdropUrl,
    required this.rating,
    required this.isFavorite,
    required this.onRemove,
    required this.onToggleFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: backdropUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => const Placeholder(),
              errorWidget: (context, url, error) => const Placeholder(),
            ),
            const SizedBox(width: 2),
            Positioned(
              right: 5,
              bottom: 8,
              child: MovieRating(rating: rating),
            ),
            Positioned(
              left: 5,
              top: 8,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _FavoriteButton(
                  key: ValueKey(isFavorite),
                  isFavorite: isFavorite,
                  onToggle: onToggleFavorite,
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 8,
              child: UIButton(
                onTap: onRemove,
                child: Assets.lib.assets.icCloseCircle.svg(
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const _FavoriteButton({
    required this.isFavorite,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UIButton(
      onTap: onToggle,
      inkwellOpacity: 0,
      child: Visibility(
        visible: isFavorite,
        replacement: Assets.lib.assets.heartOutline.svg(),
        child: Assets.lib.assets.heart.svg(),
      ),
    );
  }
}
