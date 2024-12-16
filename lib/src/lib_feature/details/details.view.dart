import "package:flutter/material.dart";
import "package:movie_night_tcc/gen/assets.gen.dart";
import "package:movie_night_tcc/src/base/widgets/base_wrapper.dart";
import "package:movie_night_tcc/src/core/design/app_colors.dart";
import "package:movie_night_tcc/src/core/design/app_fonts.dart";
import "package:movie_night_tcc/src/core/design/app_strings.dart";
import "package:movie_night_tcc/src/core/locator.dart";
import "package:movie_night_tcc/src/core/navigation/inavigation.dart";
import "package:movie_night_tcc/src/lib_feature/home/movie.entity.dart";
import "package:movie_night_tcc/src/shared/components/ui_button.dart";
import "package:movie_night_tcc/src/shared/components/ui_image.dart";
import "package:movie_night_tcc/src/shared/functions/time_utils.dart";

part "details.widgets.dart";

class DetailsView extends StatefulWidget {
  final String movieId;
  final MovieModel? movie;
  final navigation = locator.get<INavigation>();

  DetailsView({
    required this.movieId,
    this.movie,
    super.key,
  });

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      appBar: _DetailsAppBar(onTap: widget.navigation.pop),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.movie?.title ?? widget.movieId,
                style: AppFonts.robotoTitleBigBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              _DetailMovieBanner(
                movie: widget.movie ?? MovieModel.empty(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  children: widget.movie?.genres
                          .map(
                            (genre) => _GenreTag(label: genre.label),
                          )
                          .toList() ??
                      [],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.details.synopsis,
                    style: AppFonts.robotoTitleBigMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.movie?.synopsis ?? "Description",
                    style: AppFonts.robotoTextSmallRegular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
