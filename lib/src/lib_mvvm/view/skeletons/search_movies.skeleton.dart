import "package:flutter/material.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/shared/components/skeletons/skeletons.dart";
import "package:shimmer/shimmer.dart";

class SearchMoviesSkeleton extends StatelessWidget {
  const SearchMoviesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 2500),
      baseColor: AppColors.gray,
      highlightColor: Colors.white,
      child: const Expanded(child: _SearchMoviesContentSkeleton()),
    );
  }
}

class _SearchMoviesContentSkeleton extends StatelessWidget {
  const _SearchMoviesContentSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (_, __) {
        return const _MovieTileSkeleton();
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.gray,
        ),
      ),
    );
  }
}

class _MovieTileSkeleton extends StatelessWidget {
  const _MovieTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 136,
            width: 95,
            decoration: const ShapeDecoration(
              color: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextSkeleton(
                text: "V for Vendetta",
                style: AppFonts.robotoTitleSmallMedium,
              ),
              Row(
                children: [
                  TextSkeleton(
                    text: "2006",
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                  const SizedBox(width: 10),
                  TextSkeleton(
                    text: "2h12",
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                ],
              ),
              Wrap(
                spacing: 4,
                children: [
                  TextSkeleton(
                    text: "Action",
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                  TextSkeleton(
                    text: "Science Fiction",
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                  TextSkeleton(
                    text: "Thriller",
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 94,
                    height: 31,
                    decoration: const ShapeDecoration(
                      color: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 94,
                    height: 31,
                    decoration: const ShapeDecoration(
                      color: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
