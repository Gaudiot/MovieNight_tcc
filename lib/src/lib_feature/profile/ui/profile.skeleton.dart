import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/shared/components/skeletons/skeletons.dart";
import "package:shimmer/shimmer.dart";

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 2500),
      baseColor: AppColors.gray,
      highlightColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextSkeleton(
              text: "Profile",
              style: AppFonts.robotoTitleBigMedium,
            ),
            const SizedBox(height: 20),
            const _TimeSpentWatchingSkeleton(),
            const SizedBox(height: 16),
            const _MainGenresWatchedSkeleton(),
          ],
        ),
      ),
    );
  }
}

class _TimeSpentWatchingSkeleton extends StatelessWidget {
  const _TimeSpentWatchingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.white),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              TextSkeleton(
                text: "Time Spent Watching",
                style: AppFonts.robotoTextSmallRegular,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (_) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextSkeleton(
                      text: "100",
                      style: AppFonts.robotoTextSmallBold,
                    ),
                    const SizedBox(height: 4),
                    TextSkeleton(
                      text: "Minutes",
                      style: AppFonts.robotoTextSmallRegular,
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Container(
            width: 48,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainGenresWatchedSkeleton extends StatelessWidget {
  const _MainGenresWatchedSkeleton();

  @override
  Widget build(BuildContext context) {
    final List<int> movieGenresQuantity = [123, 109, 87, 45, 32];
    final List<String> movieGenres = [
      "Action",
      "Comedy",
      "Drama",
      "Adventure",
      "Fantasy",
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.white),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              TextSkeleton(
                text: "Main Genres Watched",
                style: AppFonts.robotoTextSmallRegular,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSkeleton(
                      text: "",
                      style: AppFonts.robotoTextSmallBold,
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(9, (index) {
                      if (index % 2 == 1) {
                        return const SizedBox(height: 4);
                      }
                      return TextSkeleton(
                        text: "#${index + 1}",
                        style: AppFonts.robotoTextSmallRegular,
                      );
                    }),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSkeleton(
                      text: "Movies",
                      style: AppFonts.robotoTextSmallBold,
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(9, (index) {
                      if (index % 2 == 1) {
                        return const SizedBox(height: 4);
                      }
                      return TextSkeleton(
                        text: "#${movieGenres[index ~/ 2]}",
                        style: AppFonts.robotoTextSmallRegular,
                      );
                    }),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSkeleton(
                      text: "Movies",
                      style: AppFonts.robotoTextSmallBold,
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(9, (index) {
                      if (index % 2 == 1) {
                        return const SizedBox(height: 4);
                      }
                      return TextSkeleton(
                        text: "#${movieGenresQuantity[index ~/ 2]}",
                        style: AppFonts.robotoTextSmallRegular,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
