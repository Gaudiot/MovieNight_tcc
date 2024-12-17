import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:shimmer/shimmer.dart";

class WatchedSkeleton extends StatelessWidget {
  const WatchedSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 2500),
      baseColor: AppColors.gray,
      highlightColor: Colors.white,
      child: const _WatchedContentSkeleton(),
    );
  }
}

class _WatchedContentSkeleton extends StatelessWidget {
  const _WatchedContentSkeleton();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 16 / 9,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      children: List.generate(
        20,
        (_) {
          return const DecoratedBox(
            decoration: ShapeDecoration(
              color: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          );
        },
      ),
    );
  }
}
