import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:shimmer/shimmer.dart";

class UIImage extends StatelessWidget {
  final String imageUrl;

  const UIImage({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (_, __) => const _LoadingImage(),
      errorWidget: (_, __, ___) => const _FailedImage(),
    );
  }
}

class _LoadingImage extends StatelessWidget {
  const _LoadingImage();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1500),
      baseColor: AppColors.gray,
      highlightColor: Colors.white,
      child: const ColoredBox(
        color: AppColors.gray,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.yellow,
          ),
        ),
      ),
    );
  }
}

class _FailedImage extends StatelessWidget {
  const _FailedImage();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.gray,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.red,
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: 80,
              child: Text(
                AppStrings.generic.failedToLoadImage,
                style: AppFonts.robotoTextSmallRegular,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
