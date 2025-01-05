part of "../details.view.dart";

class _GenreTag extends StatelessWidget {
  final String label;

  const _GenreTag({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: ShapeDecoration(
        color: AppColors.gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        label,
        style: AppFonts.robotoTextSmallRegular,
      ),
    );
  }
}

class _DetailsAppBar extends StatelessWidget {
  final VoidCallback onTap;

  const _DetailsAppBar({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        children: [
          UIButton(
            onTap: onTap,
            child: Assets.lib.assets.icBackCircle.svg(),
          ),
        ],
      ),
    );
  }
}

class _DetailMovieBanner extends StatelessWidget {
  final MovieModel movie;

  const _DetailMovieBanner({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          UIImage(imageUrl: movie.backdropUrl!),
          Positioned(
            right: 6,
            bottom: 8,
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.white.withOpacity(0.6),
                shape: const StadiumBorder(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.lib.assets.icStar.svg(
                      height: 8,
                      colorFilter: const ColorFilter.mode(
                        AppColors.yellow,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toStringAsFixed(2),
                      style: AppFonts.robotoTextSmallerRegular
                          .copyWith(color: AppColors.black),
                    ),
                    const VerticalDivider(color: AppColors.black),
                    Text(
                      TimeUtils.dateTimeToYear(movie.releaseDate),
                      style: AppFonts.robotoTextSmallerRegular
                          .copyWith(color: AppColors.black),
                    ),
                    const VerticalDivider(color: AppColors.black),
                    Text(
                      TimeUtils.intToRuntime(movie.runtime),
                      style: AppFonts.robotoTextSmallerRegular
                          .copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreamingIcon extends StatelessWidget {
  final String imageUrl;
  final Color? dotColor;

  const _StreamingIcon({
    required this.imageUrl,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox.square(
          dimension: 50,
          child: UIImage(
            imageUrl: imageUrl,
          ),
        ),
        if (dotColor != null)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
